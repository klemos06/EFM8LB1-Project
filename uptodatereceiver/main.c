#include <stdio.h>
#include <stdlib.h>
#include "../Common/Include/stm32l051xx.h"

#define F_CPU           32000000L

#define BIT_THRESHOLD_US   310
#define FRAME_GAP_US       2000
#define TIMEOUT_US         50000
#define DATA_BITS          39

uint16_t low_pulse[DATA_BITS + 2];
uint16_t high_gap[DATA_BITS + 2];
uint8_t path_flag;

//state of isr
volatile uint8_t  frame_ready = 0;   // isr sets this to 1 if its caught a complete frame --> main will set to 0 after it has read the o/p
volatile int      frame_count = 0;   // number of bits captured at the end of the frame capture

static uint16_t time_1 = 0;			// holds edge time for the recent edge till new time (updated after subtraction) --> static needed here cause the program throws away  
static int      isr_number = 0;		// counts the bits being captured --> will increment 
static uint8_t  expecting_edge = 1;   // 1 - waiting for low, 0 - waiting for high end --> this will alternate everytime 
static uint16_t last_time_2 = 0;		// time of rising edge - used for subtraction

/* -- SysTick delay ------------------------------------------------------- */
void wait_1ms(void)
{
    SysTick->LOAD = (F_CPU / 1000L) - 1;
    SysTick->VAL  = 0;
    SysTick->CTRL = SysTick_CTRL_CLKSOURCE_Msk | SysTick_CTRL_ENABLE_Msk;
    while ((SysTick->CTRL & BIT16) == 0);
    SysTick->CTRL = 0;
}

void waitms(int ms) {
    while (ms--)
        wait_1ms();
}

/* -- Hardware init ------------------------------------------------------- */
void Init_Hardware(void)
{
    RCC->IOPENR  |= RCC_IOPENR_GPIOBEN; // enables gpio port b
    RCC->APB2ENR |= RCC_APB2ENR_TIM22EN; // enables tim 22 from global timer 

    // configure gpio 
    GPIOB->MODER  &= ~(3U << (4 * 2));    // clearing pb4 bits (3U = 11)
    GPIOB->MODER  |=  (2U << (4 * 2));    // enabling alternate function for timer --> 2u means 10
    GPIOB->AFR[0] &= ~(0xFU << (4 * 4));  // clearing af4 for pb4 (1111)
    GPIOB->AFR[0] |=  (0x4U << (4 * 4)); // setting af4 for pb4 
    GPIOB->PUPDR  &= ~(3U << (4 * 2));		// clearing bits for pb4 pullup
    GPIOB->PUPDR  |=  (1U << (4 * 2));    // pull the pin up to 5v because receiver pulls down to 0 when reading

	// setting up timer (1 us ticks, only 16 bit timer so fills to 2^16)
    TIM22->PSC  = 31;
    TIM22->ARR  = 0xFFFF;
    TIM22->CNT  = 0;
    TIM22->DIER = 0;

   	// captures on both edges - understand this more !!
    TIM22->CCMR1 &= ~TIM_CCMR1_CC1S; // clears the register that tells this channel to act like an input or output (PWM is o/p)
    TIM22->CCMR1 |= TIM_CCMR1_CC1S_0; //  sets this is as an i/p by setting bits to 01
    TIM22->CCER  |=  (TIM_CCER_CC1P | TIM_CCER_CC1NP); // tells the stm to trigger on both edges by setting both bits 
    TIM22->CCER  |=  TIM_CCER_CC1E; // turns on capture logic

// CHANGES 

    // telling tim22 to interrupt on an edge 
    TIM22->DIER |= TIM_DIER_CC1IE;

    // supposedly ai says this connects to internal cpu interrupt controller
    NVIC_EnableIRQ(TIM22_IRQn);
    NVIC_SetPriority(TIM22_IRQn, 0);


	// tim22 start
    TIM22->CR1 |= TIM_CR1_CEN;
}

// isr
void TIM22_IRQHandler(void)
{
    if (!(TIM22->SR & TIM_SR_CC1IF)) return;
    	uint16_t time = TIM22->CCR1; // captures current time 
    
    if (frame_ready) 
    	return;  //main hasn't processed last frame - ignore 

    if (expecting_edge)
    {
        // end of low pulse 
        if (isr_number == 0)
        {
            // the first edge received - save this value for reference
            time_1 = time;
            expecting_edge = 0;
            return;
        }
        uint16_t dur = (uint16_t)(time - time_1); // curr time - most recent pulse = duration

        // if the duration is greater than the supposed length --> reset 
        if (dur > TIMEOUT_US) { 
        	isr_number = 0; 
        	time_1 = time; // save this next time
        	return; 
        }

        low_pulse[isr_number - 1] = dur;
        last_time_2 = time;
        expecting_edge = 0;
    }
    else
    {
        // end of high pulse 
        uint16_t dur = (uint16_t)(time - last_time_2);

        high_gap[isr_number] = dur;
        time_1 = time;
        isr_number++;

        // checks for long high (end sequence) or if the buffer is full
        if (dur >= FRAME_GAP_US || isr_number >= DATA_BITS + 1)
        {
            frame_count = isr_number;
            frame_ready = 1; // tells main that frame is full
            isr_number = 0;	
            expecting_edge = 1;
            return;
        }

        expecting_edge = 1;
    }
}

/* -- Main --------------------------------------------------------------- */
int main(void)
{
    int x_temp, y_temp, check_sum;
    int k, j, keep;
    int scaled_x = 0;
    int scaled_y = 0;
    int i;
    uint64_t prev_word = 0xFFFFFFFFFFFFFFFFULL;
    uint64_t frame_num = 0;
    int data[39] = {0};

    Init_Hardware();
    waitms(500);

    printf("IR Receiver | Decoding HIGH gap width\r\n");
    printf("SHORT gap (~175us) = 0 | LONG gap (~420us) = 1\r\n");
    printf("Threshold: %d us\r\n\r\n", BIT_THRESHOLD_US);

    while (1)
    {
        // other stuff will go here 

        
        if (!frame_ready) continue;

        int n = frame_count;
        frame_ready = 0; // clear the flag so ISR can continue filling on the next detected frame

        if (n < DATA_BITS) { printf("Short frame (%d pulses).\r\n", n); continue; }

        frame_num++;

        uint64_t word = 0;
        for (i = 0; i < DATA_BITS; i++)
            if (high_gap[i] > BIT_THRESHOLD_US)
                word |= (1ULL << (DATA_BITS - 1 - i));

        uint64_t diff = word ^ prev_word;

        printf("Frame %lu | 0x%02lX%08lX",
              (uint32_t)frame_num,
              (uint32_t)(word >> 32),
              (uint32_t)(word & 0xFFFFFFFF));

        if (prev_word != 0xFFFFFFFFFFFFFFFFULL && diff)
            printf(" <-- CHANGED from 0x%02lX%08lX",
                  (uint32_t)(prev_word >> 32),
                  (uint32_t)(prev_word & 0xFFFFFFFF));
        printf("\r\n");

        printf("Bits:    ");
        for (i = 0; i < DATA_BITS; i++) {
            data[i] = ((word >> (DATA_BITS - 1 - i)) & 1);
            printf("%d", data[i]);
        }
        printf("\r\n");

        if (prev_word != 0xFFFFFFFFFFFFFFFFULL && diff) {
            printf("Changed: ");
            for (i = 0; i < DATA_BITS; i++)
                printf("%c", ((diff >> (DATA_BITS - 1 - i)) & 1) ? '^' : ' ');
            printf("\r\n");
        }

        printf("HIGH us: ");
        for (i = 0; i < DATA_BITS; i++)
            printf("%4u ", (uint32_t)high_gap[i]);
        printf("\r\n\r\n");

        prev_word = word;

        /* DATA PARSING */
        x_temp = 0;
        y_temp = 0;
        check_sum = 0;

        if (data[0] && data[1] && data[2] && !data[3] && !data[4]) {
            k = 12; j = 0;
            while (k > 4)  { x_temp    += data[k] << j; k--; j++; }
            k = 20; j = 0;
            while (k > 12) { y_temp    += data[k] << j; k--; j++; }
            k = 33; j = 0;
            while (k > 25) { check_sum += data[k] << j; k--; j++; }

            keep = (check_sum == (x_temp + y_temp) / 2) ? 1 : 0;

            if (keep) {
                scaled_x = (x_temp / 90.0) *  100.0 - 50;
                scaled_y = (y_temp / 90.0) * -100.0 + 50;
            }

            if      (!data[25] &&  data[26]) path_flag = 1;
            else if ( data[25] && !data[26]) path_flag = 2;
            else if ( data[25] &&  data[26]) path_flag = 3;
            else                             path_flag = 0;

            printf("scaled x: %d, scaled y: %d, left trigger: %d, right trigger: %d, path: %d\n",
                   scaled_x, scaled_y, data[22], data[21], path_flag);
        }
    }
}