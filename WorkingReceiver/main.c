#include <stdio.h>
#include <stdlib.h>
#include "../Common/Include/stm32l051xx.h"

#define F_CPU           32000000L

/* HIGH gap threshold: short ~175 us = 0, long ~420 us = 1
   Midpoint = ~310 us                                                        */
#define BIT_THRESHOLD_US   310

/* A HIGH gap >= this means end-of-frame (or the trailing stop pulse)        */
#define FRAME_GAP_US      2000

/* Last pulse (index 26) is the stop pulse � skip it from data               */
#define DATA_BITS          26

uint16_t low_pulse[DATA_BITS + 2];
uint16_t high_gap[DATA_BITS + 2];

/* -- SysTick delay ------------------------------------------------------- */
void wait_1ms(void)
{
    SysTick->LOAD = (F_CPU / 1000L) - 1;
    SysTick->VAL  = 0;
    SysTick->CTRL = SysTick_CTRL_CLKSOURCE_Msk | SysTick_CTRL_ENABLE_Msk;
    while ((SysTick->CTRL & BIT16) == 0);
    SysTick->CTRL = 0;
}
void waitms(int ms) { while (ms--) wait_1ms(); }

/* -- Hardware init ------------------------------------------------------- */
void Init_Hardware(void)
{
    RCC->IOPENR  |= RCC_IOPENR_GPIOAEN;
    GPIOA->MODER &= ~(3U << (8 * 2));
    GPIOA->PUPDR &= ~(3U << (8 * 2));
    GPIOA->PUPDR |=  (1U << (8 * 2));

    RCC->APB1ENR |= RCC_APB1ENR_TIM2EN;
    TIM2->PSC  = 31;
    TIM2->ARR  = 0xFFFF;
    TIM2->DIER = 0;
    TIM2->CNT  = 0;
    TIM2->CR1 |= TIM_CR1_CEN;
}

/* -- Capture one frame --------------------------------------------------- */
/* Returns number of pulses captured (including stop pulse).                 */
int capture_frame(void)
{
    int n = 0;

    /* Wait for idle HIGH */
    TIM2->CNT = 0;
    while (!(GPIOA->IDR & (1U << 8)))
        if (TIM2->CNT > 100000) return 0;

    /* Wait for first falling edge */
    TIM2->CNT = 0;
    while (GPIOA->IDR & (1U << 8))
        if (TIM2->CNT > 100000) return 0;

    __disable_irq();

    while (n < DATA_BITS + 1)
    {
        /* Measure LOW pulse */
        TIM2->CNT = 0;
        while (!(GPIOA->IDR & (1U << 8)))
            if (TIM2->CNT > 50000) goto done;
        low_pulse[n] = (uint16_t)TIM2->CNT;

        /* Measure HIGH gap */
        TIM2->CNT = 0;
        while (GPIOA->IDR & (1U << 8))
            if (TIM2->CNT > 50000) { high_gap[n] = (uint16_t)TIM2->CNT; n++; goto done; }
        high_gap[n] = (uint16_t)TIM2->CNT;

        n++;

        /* Long HIGH gap = frame boundary, stop capturing */
        if (high_gap[n-1] >= FRAME_GAP_US) goto done;
    }

done:
    __enable_irq();
    return n;
}

/* -- Main --------------------------------------------------------------- */
int main(void)
{

	int x_temp, y_temp;
	int k, j, keep;
	int scaled_x;
	int scaled_y;
	
	
    int i;
    uint32_t prev_word = 0xFFFFFFFF;
    uint32_t frame_num = 0;
    int data [24] = {0};


	x_temp = 0;
	y_temp = 0;
    Init_Hardware();
    waitms(500);

    printf("IR Receiver | Decoding HIGH gap width\r\n");
    printf("SHORT gap (~175us) = 0 | LONG gap (~420us) = 1\r\n");
    printf("Threshold: %d us\r\n\r\n", BIT_THRESHOLD_US);

    while (1)
    {
        int n = capture_frame();
        if (n < DATA_BITS) { printf("Short frame (%d pulses).\r\n", n); continue; }

        frame_num++;

                          
        uint32_t word = 0;
        for (i = 0; i < DATA_BITS; i++)
            if (high_gap[i] > BIT_THRESHOLD_US)
                word |= (1UL << (DATA_BITS - 1 - i));

  
        uint32_t diff = word ^ prev_word;

        printf("Frame %lu | 0x%06lX", frame_num, word);
        if (prev_word != 0xFFFFFFFF && diff)
            printf(" <-- CHANGED from 0x%06lX", prev_word);
        printf("\r\n");

      
        printf("Bits:    ");
        for (i = 0; i < DATA_BITS; i++){
        	
        	data[i] = ((word >> (DATA_BITS - 1 - i)) & 1);
        //	printf("%d", data[i]);
        //	printf("\r\n");
            printf("%d", (word >> (DATA_BITS - 1 - i)) & 1);
            }
        printf("\r\n");

        if (prev_word != 0xFFFFFFFF && diff)
        {
            printf("Changed: ");
            for (i = 0; i < DATA_BITS; i++)
                printf("%c", ((diff >> (DATA_BITS - 1 - i)) & 1) ? '^' : ' ');
            printf("\r\n");
        }

       
        printf("HIGH us: ");
        for (i = 0; i < DATA_BITS; i++)
            printf("%4u ", high_gap[i]);
        printf("\r\n\r\n");

        prev_word = word;
        
        
     // DATA PARSING
     	x_temp = 0;
		y_temp = 0;
        // Check start sequence
		if (data[0] && data[1] && data[2] && !data[3] && !data[4]) {
			// Continue parsing if valid start sequence
			k = 12; // set initial buffer position
			j = 0;
			// Convert x bits
			while (k > 4) {
				x_temp += data[k] << j; // convert x value into decimal
				k--;
				j++;
			}
			// Convert y bits
			k = 20;
			j = 0;
			while (k > 12) {
				y_temp += data[k] << j; // convert y value into decimal
				k--;
				j++;
			}
			
			// Check end sequence (THIS WILL BE OUR CHECKSUM IN THE FINAL PRODUCT
			if(data[21] && !data[22] && !data[23] && !data[24] && !data[25]) {
				keep = 1; // Keep if valid
			}
			
			
			else {
				keep = 0; // Else don't keep
			}
			
			
			if(keep) {
				scaled_x = (x_temp/90.0) *100.0 -50; // scale x from -50 to 50
				scaled_y = (y_temp/90.0) *-100.0 +50; // scale y from -50 to 50 (flip to account for inverse joystick readings)
			}
			
	
		printf("scaled x: %d, scaled y: %d\n", scaled_x, scaled_y);
			
		}
		
		// Skip if invalid start sequence
	//	printf("invalid start");
	        
	        
    }
}