// WIP IR Stuff 
// fix the int to binary 
#include <EFM8LB1.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <stdint.h>

#define SYSCLK      72000000L  // SYSCLK frequency in Hz
#define BAUDRATE      115200L  // Baud rate of UART in bps
#define SARCLK 18000000L
#define VDD 4.684 // The measured value of VDD in volts

// 
#define PCA_0_FREQ 38000L // this has been working ~37 kHz
#define OLED_ADDR 0x78

#define SCL P0_0 
#define SDA P0_1 


#define SCL	P0_0
#define SDA P0_1 // Updated in the main program

#define x_sec P2_6 // x position for right joystick

#define PCA_OUT_0   P0_7


#define x_read P2_3
#define y_read P2_2
#define left_joystick_button P2_4 // Left joystick button
#define right_joystick_button P2_5 // Right joystick button

#define butl P3_1
#define butr P3_0

#define trigr P1_0
#define trigl P1_4

#define vibrate P3_7
#define vibrate_power P3_3


// Full screen buffer (128x64 / 8)
unsigned char xdata screen_buffer[1024];

#define CHARS_PER_LINE 16
//#define x_ratio 2.52
//#define y_ratio 2.57

// Declare states
typedef enum {
	STATE_MENU,
	PATH_SELECT,
	MODE_SELECT,
	CONFIRM_SELECT,
	INSTRUCTIONS1,
	INSTRUCTIONS2,
	INSTRUCTIONS3,
	STATS
	
} State;

int xdata x_pos_sec, real_x_sec, path_val, chosen_path;
int xdata screen, mode, chosen_mode, chosen_confirm, confirm; // mode = 0: manual, mode = 1: automatic
int xdata prev_butl, prev_butr, left_button_pressed, right_button_pressed;
State current_state;
int rjs_prev, ljs_prev, rjs, ljs;

uint8_t xdata eight_bitx;
uint8_t xdata eight_bity;	
uint8_t xdata end_sequence = 0;
	

int xdata x_pos, y_pos; 
int xdata real_x, real_y;

char xdata buffer[16]; // Buffer for converting values to strings
int xdata ir_send = 0; // this indicates if we need the ir to be on or off 
int xdata bit_count = 8; // max number of bits in the buffer


char _c51_external_startup (void)
{
	// Disable Watchdog with key sequence
	SFRPAGE = 0x00;
	WDTCN = 0xDE; //First key
	WDTCN = 0xAD; //Second key
  
	VDM0CN |= 0x80;
	RSTSRC = 0x02;

	#if (SYSCLK == 48000000L)	
		SFRPAGE = 0x10;
		PFE0CN  = 0x10; // SYSCLK < 50 MHz.
		SFRPAGE = 0x00;
	#elif (SYSCLK == 72000000L)
		SFRPAGE = 0x10;
		PFE0CN  = 0x20; // SYSCLK < 75 MHz.
		SFRPAGE = 0x00;
	#endif
	
	#if (SYSCLK == 12250000L)
		CLKSEL = 0x10;
		CLKSEL = 0x10;
		while ((CLKSEL & 0x80) == 0);
	#elif (SYSCLK == 24500000L)
		CLKSEL = 0x00;
		CLKSEL = 0x00;
		while ((CLKSEL & 0x80) == 0);
	#elif (SYSCLK == 48000000L)	
		// Before setting clock to 48 MHz, must transition to 24.5 MHz first
		CLKSEL = 0x00;
		CLKSEL = 0x00;
		while ((CLKSEL & 0x80) == 0);
		CLKSEL = 0x07;
		CLKSEL = 0x07;
		while ((CLKSEL & 0x80) == 0);
	#elif (SYSCLK == 72000000L)
		// Before setting clock to 72 MHz, must transition to 24.5 MHz first
		CLKSEL = 0x00;
		CLKSEL = 0x00;
		while ((CLKSEL & 0x80) == 0);
		CLKSEL = 0x03;
		CLKSEL = 0x03;
		while ((CLKSEL & 0x80) == 0);
	#else
		#error SYSCLK must be either 12250000L, 24500000L, 48000000L, or 72000000L
	#endif
	
//	P0MDOUT |= 0x10; // Enable UART0 TX as push-pull output
	P0MDOUT |= 0b10000000;
	P1MDOUT|=0b_1111_1111;
	P2MDOUT|=0b_0000_0001;

	XBR0     = 0x01; // Enable UART0 on P0.4(TX) and P0.5(RX)                     
	XBR1     = 0X00;
	XBR2     = 0x40; // Enable crossbar and weak pull-ups

	#if (((SYSCLK/BAUDRATE)/(2L*12L))>0xFFL)
		#error Timer 0 reload value is incorrect because (SYSCLK/BAUDRATE)/(2L*12L) > 0xFF
	#endif
	// Configure Uart 0
	SCON0 = 0x10;
	CKCON0 |= 0b_0000_0000 ; // Timer 1 uses the system clock divided by 12.
	TH1 = 0x100-((SYSCLK/BAUDRATE)/(2L*12L));
	TL1 = TH1;      // Init Timer1
	TMOD &= ~0xf0;  // TMOD: timer 1 in 8-bit auto-reload
	TMOD |=  0x20;                       
	TR1 = 1; // START Timer1
	TI = 1;  // Indicate TX0 ready
	
	// Initialize the Prgramable Counter Array to generate the requested frequencies
	SFRPAGE=0x0;
	PCA0MD=0x00; // Disable and clear everything in the PCA
	PCA0L=0; // Initialize the PCA counter to zero
	PCA0H=0;
	PCA0MD=0b_0000_1000; // Configure PCA.  System CLK is the frequency input for the PCA
	// Enable all PCS modules comparators and to generate interrupts
	PCA0CPM0=0b_0100_1001; // ECOM|MAT|ECCF;
	// The frequency for PCA channel 0
	PCA0CPL0=(SYSCLK/(2*PCA_0_FREQ))%0x100; //Always write low byte first!
	PCA0CPH0=(SYSCLK/(2*PCA_0_FREQ))/0x100;

	CR=1; // Enable PCA counter
	EIE1|=0b_0001_0000; // Enable PCA interrupts
	
	EA=1; // Enable interrupts
	
	return 0;
}

void InitADC (void)
{
	SFRPAGE = 0x00;
	ADEN=0; // Disable ADC
	
	ADC0CN1=
		(0x2 << 6) | // 0x0: 10-bit, 0x1: 12-bit, 0x2: 14-bit
        (0x0 << 3) | // 0x0: No shift. 0x1: Shift right 1 bit. 0x2: Shift right 2 bits. 0x3: Shift right 3 bits.		
		(0x0 << 0) ; // Accumulate n conversions: 0x0: 1, 0x1:4, 0x2:8, 0x3:16, 0x4:32
	
	ADC0CF0=
	    ((SYSCLK/SARCLK) << 3) | // SAR Clock Divider. Max is 18MHz. Fsarclk = (Fadcclk) / (ADSC + 1)
		(0x0 << 2); // 0:SYSCLK ADCCLK = SYSCLK. 1:HFOSC0 ADCCLK = HFOSC0.
	
	ADC0CF1=
		(0 << 7)   | // 0: Disable low power mode. 1: Enable low power mode.
		(0x1E << 0); // Conversion Tracking Time. Tadtk = ADTK / (Fsarclk)
	
	ADC0CN0 =
		(0x0 << 7) | // ADEN. 0: Disable ADC0. 1: Enable ADC0.
		(0x0 << 6) | // IPOEN. 0: Keep ADC powered on when ADEN is 1. 1: Power down when ADC is idle.
		(0x0 << 5) | // ADINT. Set by hardware upon completion of a data conversion. Must be cleared by firmware.
		(0x0 << 4) | // ADBUSY. Writing 1 to this bit initiates an ADC conversion when ADCM = 000. This bit should not be polled to indicate when a conversion is complete. Instead, the ADINT bit should be used when polling for conversion completion.
		(0x0 << 3) | // ADWINT. Set by hardware when the contents of ADC0H:ADC0L fall within the window specified by ADC0GTH:ADC0GTL and ADC0LTH:ADC0LTL. Can trigger an interrupt. Must be cleared by firmware.
		(0x0 << 2) | // ADGN (Gain Control). 0x0: PGA gain=1. 0x1: PGA gain=0.75. 0x2: PGA gain=0.5. 0x3: PGA gain=0.25.
		(0x0 << 0) ; // TEMPE. 0: Disable the Temperature Sensor. 1: Enable the Temperature Sensor.

	ADC0CF2= 
		(0x0 << 7) | // GNDSL. 0: reference is the GND pin. 1: reference is the AGND pin.
		(0x1 << 5) | // REFSL. 0x0: VREF pin (external or on-chip). 0x1: VDD pin. 0x2: 1.8V. 0x3: internal voltage reference.
		(0x1F << 0); // ADPWR. Power Up Delay Time. Tpwrtime = ((4 * (ADPWR + 1)) + 2) / (Fadcclk)
	
	ADC0CN2 =
		(0x0 << 7) | // PACEN. 0x0: The ADC accumulator is over-written.  0x1: The ADC accumulator adds to results.
		(0x0 << 0) ; // ADCM. 0x0: ADBUSY, 0x1: TIMER0, 0x2: TIMER2, 0x3: TIMER3, 0x4: CNVSTR, 0x5: CEX5, 0x6: TIMER4, 0x7: TIMER5, 0x8: CLU0, 0x9: CLU1, 0xA: CLU2, 0xB: CLU3

	ADEN=1; // Enable ADC
}

void InitPinADC (unsigned char portno, unsigned char pin_num)
{
	unsigned char mask;
	
	mask=1<<pin_num;

	SFRPAGE = 0x20;
	switch (portno)
	{
		case 0:
			P0MDIN &= (~mask); // Set pin as analog input
			P0SKIP |= mask; // Skip Crossbar decoding for this pin
		break;
		case 1:
			P1MDIN &= (~mask); // Set pin as analog input
			P1SKIP |= mask; // Skip Crossbar decoding for this pin
		break;
		case 2:
			P2MDIN &= (~mask); // Set pin as analog input
			P2SKIP |= mask; // Skip Crossbar decoding for this pin
		break;
		default:
		break;
	}
	SFRPAGE = 0x00;
}

unsigned int ADC_at_Pin(unsigned char pin)
{
	ADC0MX = pin;   // Select input from pin
	ADINT = 0;
	ADBUSY = 1;     // Convert voltage at the pin
	while (!ADINT); // Wait for conversion to complete
	return (ADC0);
}

float Volts_at_Pin(unsigned char pin)
{
	 return ((ADC_at_Pin(pin)*VDD)/16383.0);
}

// Uses Timer3 to delay <us> micro-seconds. 
void Timer3us(unsigned char us)
{
	unsigned char i;               // usec counter
	
	// The input for Timer 3 is selected as SYSCLK by setting T3ML (bit 6) of CKCON0:
	CKCON0|=0b_0100_0000;
	
	TMR3RL = (-(SYSCLK)/1000000L); // Set Timer3 to overflow in 1us.
	TMR3 = TMR3RL;                 // Initialize Timer3 for first overflow
	
	TMR3CN0 = 0x04;                 // Sart Timer3 and clear overflow flag
	for (i = 0; i < us; i++)       // Count <us> overflows
	{
		while (!(TMR3CN0 & 0x80));  // Wait for overflow
		TMR3CN0 &= ~(0x80);         // Clear overflow indicator
	}
	TMR3CN0 = 0 ;                   // Stop Timer3 and clear overflow flag
}

// ================= I2C =================
void I2C_Delay(void) {
    unsigned char i;
    for(i = 0; i < 5; i++);
}

void I2C_Start(void) {
    SDA = 1; SCL = 1; I2C_Delay();
    SDA = 0; I2C_Delay();
    SCL = 0;
}

void I2C_Stop(void) {
    SDA = 0; SCL = 0; I2C_Delay();
    SCL = 1; I2C_Delay();
    SDA = 1; I2C_Delay();
}

void I2C_Write(unsigned char dat) {
    unsigned char i;
    for (i = 0; i < 8; i++) {
        SDA = (dat & 0x80) ? 1 : 0;
        I2C_Delay();
        SCL = 1; I2C_Delay();
        SCL = 0;
        dat <<= 1;
    }
    SDA = 1; I2C_Delay();
    SCL = 1; I2C_Delay();
    SCL = 0;
}

// ================= OLED =================
void OLED_Command(unsigned char cmd) {
    I2C_Start();
    I2C_Write(OLED_ADDR);
    I2C_Write(0x00);
    I2C_Write(cmd);
    I2C_Stop();
}

void OLED_Init(void) {
    OLED_Command(0xAE);
    OLED_Command(0x20);
    OLED_Command(0x02);
    OLED_Command(0x8D);
    OLED_Command(0x14);
    OLED_Command(0xAF);
}

void OLED_ClearDisplay(void) {
    uint8_t p, i;

    for (p = 0; p < 8; p++) {
        OLED_Command(0xB0 + p);
        OLED_Command(0x00);
        OLED_Command(0x10);

        I2C_Start();
        I2C_Write(OLED_ADDR);
        I2C_Write(0x40);

        for (i = 0; i < 128; i++) {
            I2C_Write(0x00);
        }

        I2C_Stop();
    }
}

void OLED_Update(void) {
    uint8_t p, i;

    for (p = 0; p < 8; p++) {
        OLED_Command(0xB0 + p);
        OLED_Command(0x00);
        OLED_Command(0x10);

        I2C_Start();
        I2C_Write(OLED_ADDR);
        I2C_Write(0x40);

        for (i = 0; i < 128; i++) {
            I2C_Write(screen_buffer[p * 128 + i]);
        }

        I2C_Stop();
    }
}

// ================= GRAPHICS =================
void ClearBuffer(void) {
    uint16_t i;
    for (i = 0; i < 1024; i++) {
        screen_buffer[i] = 0;
    }
}

void SetPixel(uint8_t x, uint8_t y, int on) {
	//find which row to go on
    uint16_t index = x + (y / 8) * 128;
    
    //turn on pixel at that byte
    if(on){
    screen_buffer[index] |= (1 << (y % 8));
    }
    else{
    	 screen_buffer[index] &= (1 << (y % 8));
    }
}

// Draw 5x7 character
void DrawChar(uint8_t x, uint8_t y, const uint8_t *ch) {
    uint8_t i, j;

    for (i = 0; i < 5; i++) {
        uint8_t col = ch[i];
        for (j = 0; j < 8; j++) {
            if (col & (1 << j)) {
                SetPixel(x + i, y + j,1); // turns on bit
            }
        }
    }
}

void DrawLine(int x0, int y0, int x1, int y1) {
    int dx = x1 - x0;
    int dy = y1 - y0;
    int steps = (dx > dy ? dx : dy);

    float x_inc = dx / (float)steps;
    float y_inc = dy / (float)steps;

    float x = x0;
    float y = y0;

    int i;
    for (i = 0; i <= steps; i++) {
        SetPixel((uint8_t)x, (uint8_t)y,1);
        x += x_inc;
        y += y_inc;
    }
}


void DrawCircle(int xc, int yc, int r) {
    int x, y;
    for (x = -r; x <= r; x++) {
        for (y = -r; y <= r; y++) {
            if (x*x + y*y <= r*r) {
                SetPixel(xc + x, yc + y,1);
            }
        }
    }
}

// ================= FONT  =================
const uint8_t font5x7[][5] = {

    // SPACE
    {0x00,0x00,0x00,0x00,0x00}, // 0
	{0x08,0x08,0x08,0x08,0x08}, // '-'	
	
	
    // NUMBERS 1â€“10
    {0x3E,0x51,0x49,0x45,0x3E}, // 0
    {0x00,0x42,0x7F,0x40,0x00}, // 1
    {0x42,0x61,0x51,0x49,0x46}, // 2
    {0x21,0x41,0x45,0x4B,0x31}, // 3
    {0x18,0x14,0x12,0x7F,0x10}, // 4
    {0x27,0x45,0x45,0x45,0x39}, // 5
    {0x3C,0x4A,0x49,0x49,0x30}, // 6
    {0x01,0x71,0x09,0x05,0x03}, // 7
    {0x36,0x49,0x49,0x49,0x36}, // 8
    {0x06,0x49,0x49,0x29,0x1E}, // 9

    // LETTERS Aâ€“Z
    {0x7E,0x11,0x11,0x11,0x7E}, // A
    {0x7F,0x49,0x49,0x49,0x36}, // B
    {0x3E,0x41,0x41,0x41,0x22}, // C
    {0x7F,0x41,0x41,0x22,0x1C}, // D
    {0x7F,0x49,0x49,0x49,0x41}, // E
    {0x7F,0x09,0x09,0x09,0x01}, // F
    {0x3E,0x41,0x49,0x49,0x7A}, // G
    {0x7F,0x08,0x08,0x08,0x7F}, // H
    {0x00,0x41,0x7F,0x41,0x00}, // I
    {0x20,0x40,0x41,0x3F,0x01}, // J
    {0x7F,0x08,0x14,0x22,0x41}, // K
    {0x7F,0x40,0x40,0x40,0x40}, // L
    {0x7F,0x02,0x0C,0x02,0x7F}, // M
    {0x7F,0x04,0x08,0x10,0x7F}, // N
    {0x3E,0x41,0x41,0x41,0x3E}, // O
    {0x7F,0x09,0x09,0x09,0x06}, // P
    {0x3E,0x41,0x51,0x21,0x5E}, // Q
    {0x7F,0x09,0x19,0x29,0x46}, // R
    {0x46,0x49,0x49,0x49,0x31}, // S
    {0x01,0x01,0x7F,0x01,0x01}, // T
    {0x3F,0x40,0x40,0x40,0x3F}, // U
    {0x1F,0x20,0x40,0x20,0x1F}, // V
    {0x3F,0x40,0x38,0x40,0x3F}, // W
    {0x63,0x14,0x08,0x14,0x63}, // X
    {0x07,0x08,0x70,0x08,0x07}, // Y
    {0x61,0x51,0x49,0x45,0x43}  // Z
    
   
};

void DrawFilledRect(uint8_t x1, uint8_t y1, uint8_t x2, uint8_t y2) {
    uint8_t x, y;
    for (x = x1; x <= x2; x++) {
        for (y = y1; y <= y2; y++) {
            SetPixel(x, y,1);
        }
    }
}

void ClearPixel(uint8_t x, uint8_t y) {
    uint16_t index = x + (y / 8) * 128;
    screen_buffer[index] &= ~(1 << (y % 8));
}

// Manual mapping (simple + safe)
const uint8_t* GetChar(char c) {

    // SPACE
    if (c == ' ') return font5x7[0];

    // NUMBERS
    if (c >= '0' && c <= '9') {
        return font5x7[2 + (c - '0')];
    }

    // LETTERS
    if (c >= 'A' && c <= 'Z') {
        return font5x7[12 + (c - 'A')];
    }
    
    if (c == '-')
    	return font5x7[1];

    return font5x7[0];
}


void DrawString(uint8_t x, uint8_t y, char *str) {
    while (*str) {
        DrawChar(x, y, GetChar(*str));
        x += 6;
        str++;
    }
}

// ================= MCU =================
//void Init_MCU(void) {
  //  SFRPAGE = 0x00;
  //  WDTCN = 0xDE;
  //  WDTCN = 0xAD;

  //  CLKSEL = 0x00;
  //  P0MDOUT = 0x00;
   // XBR2 = 0x40;
//}
   int rect_x=0;


void waitms (unsigned int ms)
{
	unsigned int j;
	for(j=ms; j!=0; j--)
	{
		Timer3us(249);
		Timer3us(249);
		Timer3us(249);
		Timer3us(250);
	}
}




void TIMER0_Init(void)
{
	TMOD&=0b_1111_0000; // Set the bits of Timer/Counter 0 to zero
	TMOD|=0b_0000_0001; // Timer/Counter 0 used as a 16-bit timer
	TR0=0; // Stop Timer/Counter 0
}



// -------------------------IR Functions-------------------------------

// converts fourteen bit to eight bit 
int fourteen_to_eight(int val){
	return ((val*255.0)/65535.0);
}

// this fcn is always happening --> therefore the pca will keep triggering in the background (if it runs depends on ir_send's val) 
void PCA_ISR (void) interrupt INTERRUPT_PCA0
{
	unsigned int j;
	
	SFRPAGE=0x0;
	
	if (CCF0)
	{
		
		j=(PCA0CPH0*0x100+PCA0CPL0)+(SYSCLK/(2L*PCA_0_FREQ));
		PCA0CPL0=j%0x100; //Always write low byte first!
		PCA0CPH0=j/0x100;
		CCF0=0;

		if (ir_send == 1){
			PCA_OUT_0=!PCA_OUT_0; // if the IR send is 1 --> turn on the pin 
		}

		else {
			PCA_OUT_0 = 0; // if the IR send is 0 --> turn off the pin even if the interrupt is generated 
		}
	}
	CF=0;
}

// start sequence 
// sends 3 1s and 2 0s --> 11100 
int start_transmit (int start_bit){
	if (start_bit){
		int i;

		for (i = 0;i<3;i++){ 
			ir_send = 1;
			Timer3us(560);
			Timer3us(560);
			Timer3us(560);
			Timer3us(560);
			ir_send = 0;
			Timer3us(560);
			Timer3us(560);
			Timer3us(560);
			Timer3us(560);
			Timer3us(560);
			Timer3us(560);
			Timer3us(560);
			Timer3us(560);
		}

		for (i=0;i<2; i++){
			ir_send = 1; 
			Timer3us(560);
			Timer3us(560);
			Timer3us(560);
			Timer3us(560);
			ir_send = 0;
			Timer3us(560);
			Timer3us(560);
			Timer3us(560);
			Timer3us(560);
			
		}
		
		return 0; 
	}
	else {
		return -1;
	}
}

int end_transmit (int end_bit){			// 10000
	if (end_bit){
		int i;

		for (i = 0;i<1;i++){ 
			ir_send = 1;
			Timer3us(560);
			Timer3us(560);
			Timer3us(560);
			Timer3us(560);
			ir_send = 0;
			Timer3us(560);
			Timer3us(560);
			Timer3us(560);
			Timer3us(560);
			Timer3us(560);
			Timer3us(560);
			Timer3us(560);
			Timer3us(560);
		}

		for (i=0;i<4; i++){
			ir_send = 1; 
			Timer3us(560);
			Timer3us(560);
			Timer3us(560);
			Timer3us(560);
			ir_send = 0;
			Timer3us(560);
			Timer3us(560);
			Timer3us(560);
			Timer3us(560);
			
		}
		return 0; 
	}
	else {
		return -1;
	}
}

// parses 8 bits and sends IR accordingly
void transmit_byte(uint8_t input){

	int i; 
	for (i = 7; i >= 0; i--){
		if ((input >> i) & 1) {			// this shifts the first bit to the right and ands it with 1 --> if this is one, this means the bit is supposed to be a one  
			ir_send = 1; 
			Timer3us(560);
			Timer3us(560);
			Timer3us(560);				// 2240 us high
			Timer3us(560);
			ir_send = 0; 
			Timer3us(560);				// 4480 us low 
			Timer3us(560);
			Timer3us(560);
			Timer3us(560);
			Timer3us(560);
			Timer3us(560);
			Timer3us(560);
			Timer3us(560);
			
		}
		else {				// if its a zero, then its sends zero sequence 
			ir_send = 1; 
			Timer3us(560);			// 2240 us high and low 
			Timer3us(560);
			Timer3us(560);
			Timer3us(560);
			ir_send = 0; 
			Timer3us(560);
			Timer3us(560);
			Timer3us(560);
			Timer3us(560);
		}

	} 
}

void transmit_bit(uint8_t val_bit){
	if (val_bit & 1){
		 ir_send = 1; 
			Timer3us(560);
			Timer3us(560);
			Timer3us(560);				// 2240 us high
			Timer3us(560);
			ir_send = 0; 
			Timer3us(560);				// 4480 us low 
			Timer3us(560);
			Timer3us(560);
			Timer3us(560);
			Timer3us(560);
			Timer3us(560);
			Timer3us(560);
			Timer3us(560);
		}
	else {
		ir_send = 1; 
			Timer3us(560);			// 2240 us high and low 
			Timer3us(560);
			Timer3us(560);
			Timer3us(560);
			ir_send = 0; 
			Timer3us(560);
			Timer3us(560);
			Timer3us(560);
			Timer3us(560);
		}
	}

void transmit_path(int path_flag){

int i;

switch(path_flag){

case 1: // path 1 --> o/p is 00
		for (i=0;i<2; i++){
			ir_send = 1; 
			Timer3us(560);
			Timer3us(560);
			Timer3us(560);
			Timer3us(560);
			ir_send = 0;
			Timer3us(560);
			Timer3us(560);
			Timer3us(560);
			Timer3us(560);
			
		}
		break;
case 2:		// path 2 --> o/p is 01
	for (i=0;i<1; i++){
			ir_send = 1; 
			Timer3us(560);
			Timer3us(560);
			Timer3us(560);
			Timer3us(560);
			ir_send = 0;
			Timer3us(560);
			Timer3us(560);
			Timer3us(560);
			Timer3us(560);		
		}
	for (i = 0;i<1;i++){ 
			ir_send = 1;
			Timer3us(560);
			Timer3us(560);
			Timer3us(560);
			Timer3us(560);
			ir_send = 0;
			Timer3us(560);
			Timer3us(560);
			Timer3us(560);
			Timer3us(560);
			Timer3us(560);
			Timer3us(560);
			Timer3us(560);
			Timer3us(560);
		}
		break;
case 3: // path 3 --> o/p is 10
	for (i = 0;i<1;i++){ 
			ir_send = 1;
			Timer3us(560);
			Timer3us(560);
			Timer3us(560);
			Timer3us(560);
			ir_send = 0;
			Timer3us(560);
			Timer3us(560);
			Timer3us(560);
			Timer3us(560);
			Timer3us(560);
			Timer3us(560);
			Timer3us(560);
			Timer3us(560);
		}
	for (i=0;i<1; i++){
			ir_send = 1; 
			Timer3us(560);
			Timer3us(560);
			Timer3us(560);
			Timer3us(560);
			ir_send = 0;
			Timer3us(560);
			Timer3us(560);
			Timer3us(560);
			Timer3us(560);
			
		}
		break; 
	}
}

void transmit_checksum(uint8_t x_in, uint8_t y_in){
	int i; 
	
	uint8_t math;
	math = (x_in+y_in)/2;
	
	for (i = 7; i >= 0; i--){
		if ((math >> i) & 1) {			// this shifts the first bit to the right and ands it with 1 --> if this is one, this means the bit is supposed to be a one  
			ir_send = 1; 
			Timer3us(560);
			Timer3us(560);
			Timer3us(560);				// 2240 us high
			Timer3us(560);
			ir_send = 0; 
			Timer3us(560);				// 4480 us low 
			Timer3us(560);
			Timer3us(560);
			Timer3us(560);
			Timer3us(560);
			Timer3us(560);
			Timer3us(560);
			Timer3us(560);
			}
		
		else {				// if its a zero, then its sends zero sequence 
			ir_send = 1; 
			Timer3us(560);			// 2240 us high and low 
			Timer3us(560);
			Timer3us(560);
			Timer3us(560);
			ir_send = 0; 
			Timer3us(560);
			Timer3us(560);
			Timer3us(560);
			Timer3us(560);
		}
	}

} 

void int_to_stringprint(int val, int x, int y)
{
 	sprintf(buffer, "%i", val); // print string to buffer
 	DrawString(x, y, buffer);
}


// ----- State machine functions -----


void read_inputs(void) {

	ClearBuffer();
	
	// Read joystick position
    x_pos_sec = ADC_at_Pin(QFP32_MUX_P2_6);

	// Convert joystick position into binary direction
	if(x_pos_sec > 13730)
		real_x_sec = 1;
	else if (x_pos_sec < 9000)
		real_x_sec = -1;	
	else
		real_x_sec = 0;	   
	
	// If right button (green) increment to next screen
	if(butr && !prev_butr) { // Debounced button
		right_button_pressed = 1;
	}
	else
		right_button_pressed = 0;
	prev_butr = butr; // Set current equal to previous 
	
	// If left button (yellow) decrement to previous screen
	if(butl && !prev_butl) { // Debounced button
		left_button_pressed = 1;
	}	
	else
		left_button_pressed = 0;
	prev_butl = butl;  
	
	// Left Joystick
	if(!left_joystick_button && ljs_prev) { // Debounced button
		ljs = 0;
	}	
	else
		ljs = 1;
	ljs_prev = left_joystick_button;  
	
	// Right Joystick
	if(!right_joystick_button && rjs_prev) { // Debounced button
		rjs = 0;
	}	
	else
		rjs = 1;
	rjs_prev = right_joystick_button;  
	
	 
	
	x_pos = ADC_at_Pin(QFP32_MUX_P2_3);
	y_pos = ADC_at_Pin(QFP32_MUX_P2_2);
	
	if(x_pos > 11730) {
		real_x =  11730 + 11730*((x_pos-11730)/4653.0);
	}
	
	else
		real_x = x_pos;
	
	if(y_pos > 11796) {
		real_y = 11796 + 11796*((y_pos-11796)/4587.0);
	}
	
	else
		real_y = y_pos;   
}



void instructions1(void) {

	DrawString(15, 2, "INSTRUCTIONS");
	DrawString(0, 15, "LEFT BUTTON");
	DrawString(0, 25, "PREVIOUS PAGE");

	DrawString(0, 35, "RIGHT BUTTON");
	DrawString(0, 45, "NEXT PAGE");
	DrawString(3, 55, "LEFT FOR INSTRUCTIONS");

	
	if(right_button_pressed)
    	current_state = STATE_MENU;
   	if(left_button_pressed)
    	current_state = INSTRUCTIONS2;
	
	OLED_Update();
}

void instructions3(void) {

	DrawString(15, 2, "INSTRUCTIONS");
	DrawString(0, 15, "TRIGGERS");
	DrawString(0, 25, "SWING ARM");
	DrawString(0, 35, "RIGHT JS BUTTON");
	DrawString(0, 45, "SELECT");
		
	if(right_button_pressed)
    	current_state = INSTRUCTIONS2;
	
	OLED_Update();	
}


void instructions2(void) {

	DrawString(15, 2, "INSTRUCTIONS");
	DrawString(0, 15, "LEFT JOYSTICK");
	DrawString(0, 25, "MOVE ROBOT");
	DrawString(0, 35, "RIGHT JOYSTICK");
	DrawString(0, 45, "MOVE CURSOR");
	DrawString(3, 55, "LEFT FOR INSTRUCTIONS");
	
	if(right_button_pressed)
    	current_state = INSTRUCTIONS1;
	if(left_button_pressed)
    	current_state = INSTRUCTIONS3;
	
	OLED_Update();	
}



// Menu state functionality
void initialization(void) {
	DrawString(20, 5, "WELCOME");
	DrawString(3, 35, "LEFT FOR INSTRUCTIONS");
	DrawString(3, 55, "RIGHT FOR SELECTION");
	
	if(right_button_pressed){
    	current_state = MODE_SELECT; // Move to other screen
    	path_val = 1; // Set initial path val to 0
    	rect_x = 0;
    	mode = 0;
    }
    	
    if(left_button_pressed)
    	current_state = INSTRUCTIONS1; // Move to other screen	
    	
	OLED_Update();
}

// Path selector functionality
void path_selector(void) {

	// Draw strings
	DrawString(10, 10, "PATH SELECTOR");
	DrawString(10, 30, "PATH 1");
    DrawString(50, 30, "PATH 2");
    DrawString(90, 30, "PATH 3");
    
    // Clear lower row
    DrawString(0, 45, "                                       ");
   
    
    if(right_button_pressed) {
    	current_state = CONFIRM_SELECT; // Move to other screen
    //	if(path_val ==2)
    		rect_x = 0; // Move rectangle to the left if it is in the middle
    		path_val = 1; // Handles screen switching edge cases
    		mode = 0;
    }
    
    if(left_button_pressed) {
    	current_state = MODE_SELECT;
    }
   // If joystick right
   if(real_x_sec==1){
   	rect_x+=40;
   	if (path_val < 3) {
   		path_val++;
   	}
   	waitms(50);
   }
   // If joystick left
   if(real_x_sec==-1){
   	rect_x-=40;
   	if (path_val > 1) {
   		path_val--;
   	}
   	waitms(50);
   }
   
   if(rect_x>128||rect_x+43>128){
   	rect_x=80;
   }
   
   if(rect_x<10){
   	 rect_x=10;
   }
   DrawFilledRect(rect_x,40,rect_x+30,43);
   
   	// Check if right joystick button (select) has been pressed
	if(rjs==0){
		chosen_path = path_val; // Lock in  a chosen path from the current path value
	}
	
	// Print indicator for chosen path
    if(chosen_path ==1)
    	DrawString(20, 45, "S");
    
    if(chosen_path ==2)
    	DrawString(60, 45, "S");
    
    if(chosen_path ==3)
    	DrawString(100, 45, "S");
   
   OLED_Update();
}

// Mode selector screen functionality
void mode_selector(void) {

	DrawString(10, 10, "MODE SELECTOR");
	DrawString(10, 30, "AUTOMATIC");
	DrawString(80, 30, "MANUAL");
		
	// Clear lower row
    DrawString(0, 45, "                                       ");
   
	
	// DISPLAY THE LINE
	// If joystick right
   if(real_x_sec==1){
   	rect_x+=80;
   	if (mode < 1) {
   		mode++;
   	}
   	waitms(50);
   }
   // If joystick left
   if(real_x_sec==-1){
   	rect_x-=80;
   	if (mode> 0) {
   		mode--;
   	}
   	waitms(50);
   }
   
   if(rect_x>128||rect_x+43>128){
   	rect_x=80;
   }
   
   if(rect_x<10){
   	 rect_x=10;
   }
   DrawFilledRect(rect_x,40,rect_x+40,43);

	// Switch displays when side button pressed
	if(right_button_pressed) {
		confirm = 0;	
		rect_x = 0; // move cursor to the left
		path_val = 1;
	
		if(chosen_mode == 0) { // Automatic
			current_state=PATH_SELECT;
		}
		else {
			current_state = CONFIRM_SELECT;
		}
	}
	if(left_button_pressed) {
		current_state = STATE_MENU;
		path_val = 1;
		rect_x = 0; // Move cursor to left and fix any edge cases
	}
	
	// Check if right joystick button (select) has been pressed
	if(rjs==0){
		chosen_mode = mode; // Lock in  a chosen mode from the current mode value
	}
	
	// Print indicator for chosen path
   	if(chosen_mode == 0)// Automatic
    	DrawString(20, 45, "S");
    if(chosen_mode == 1) // Manual
    	DrawString(90, 45, "S");
		
	OLED_Update();
}

// Confirmation screen functionality
void confirmation(void) {

	DrawString(5, 10, "CONFIRM?");
	DrawString(10, 20, "NO");
	DrawString(80, 20, "YES");
	DrawString(2, 50, "-PRESS BOTH JS-");
	
	// Check if right joystick button (select) has been pressed
	if(right_joystick_button==0 && left_joystick_button ==0 && confirm == 1){
		if (chosen_mode ==4 || (!chosen_mode && chosen_path==4)) // Ensure all options have been selected
			DrawString(5, 32, "SELECT ALL OPTIONS");
		else
			chosen_confirm = confirm; // Lock in a chosen mode from the current mode value
	}
		
   	// Print indicator for chosen path
   	if(chosen_confirm == 1) { // Yes
    	current_state = STATS;
    	vibrate = 0;
    	waitms(100);
    }
    //if(chosen_confirm == 1) // No
 
   
	
	// DISPLAY THE LINE
	// If joystick right
   if(real_x_sec==1){
   	rect_x+=80;
   	if (confirm < 1) {
   		confirm++;
   	}
   	waitms(50);
   }
   // If joystick left
   if(real_x_sec==-1){
   	rect_x-=80;
   	if (confirm> 0) {
   		confirm--;
   	}
   	waitms(50);
   }
   
   if(rect_x>128||rect_x+43>128){
   	rect_x=80;
   }
   
   if(rect_x<10){
   	 rect_x=10;
   }
   DrawFilledRect(rect_x,40,rect_x+40,43);

	if(left_button_pressed) {
		if(!chosen_mode) {//Automatic
			current_state = PATH_SELECT;
		}
		else { // Manual
			current_state = MODE_SELECT;
		}
		rect_x = 10;
		mode = 0;
		path_val = 1;
	}
		
	OLED_Update();

}

// Display robot information and enable data sending if automatic mode
void stats(void) {
	vibrate = 1;
	
	// If in automatic
	if(chosen_mode==0) {
		DrawString(5, 15, "MODE AUTOMATIC");
		//if path == yada yada
		DrawString(5, 25, "PATH");
	}
	else {
		DrawString(5, 5, "MANUAL MODE");
		DrawString(5, 15, "X POS");
		int_to_stringprint(((real_x/23460.0)*100.0-50), 45, 15); // Scale and display x
		DrawString(5, 25, "Y POS");
		int_to_stringprint((-1*(real_y/23592.0)*100.0+50), 45, 25); // Scale and display y
	}
	
	// this stuff works more - no more conversion to 8 bits 
	if(!right_button_pressed) {
	
		// ----- BEGIN IR STUFF WHEN EVERYTHING IS SELECTED
		// map 14 to 8 bits
		eight_bitx = fourteen_to_eight(real_x);
		eight_bity = fourteen_to_eight(real_y);

		start_transmit(1);
		transmit_byte(eight_bitx);
		transmit_byte(eight_bity);
		transmit_bit(trigl);
		transmit_bit(trigr);
		transmit_bit(chosen_mode);
		transmit_path(chosen_path);
		transmit_checksum(eight_bitx,eight_bity);
		end_transmit(1);
		
		// final pulse - will be thick on oscope
		ir_send =1;
		Timer3us(560);
		Timer3us(560);
		Timer3us(560);				
		Timer3us(560);
		Timer3us(560);
		Timer3us(560);
		Timer3us(560);
		Timer3us(560);
		Timer3us(560);
		Timer3us(560);
		ir_send = 0; 
		
		waitms(100); 
		
	}
	// original package --> 11100xxxxxxxxyyyyyyyy10000 (26 bits)
	// current package --> 11100xxxxxxxxyyyyyyyybbbppcccccccc10000 	
	//	printf("x_pos: %d, y_pos: %d, button: %d\n", real_x, real_y, button);	
	// ints are 16 bits
	//	float_to_stringprinty(2, y_pos);
	
	else {
		// Reset all values
		current_state = STATE_MENU;
		
		path_val = 1; // Set path to 1 initially
		chosen_path = 4;
		mode = 0; // Set mode initially to zero
		chosen_mode = 4; // Set random mode so no s appears on display screen initially
		confirm = 0;
		chosen_confirm = 4; // Set random mode so it doesn't auto select	
	
	//	printf("%d %d\n", path_val, confirm);

	}

	OLED_Update();

}



//----- MAIN -----
void main (void) 
{
	//Init_MCU(); // DO WE STILL NEED THIS?
	OLED_Init(); // Initialize the OLED display
    OLED_ClearDisplay(); // Clear the OLED
	TIMER0_Init(); // Initialize timer 0
	InitADC(); // Initialize the ADC
	InitPinADC(2,2); // Initialize pin 2.2 as analog
	InitPinADC(2,3); // Initialize pin 2.3 as analog
	InitPinADC(2,6); // Initialize pin 2.6 as analog

	// Initialize everything
	prev_butl = 1; // Set previous button press to zero to help with debouncing
	prev_butr = 1; 
	
	
	rjs_prev = 1;
	ljs_prev = 1;
	
	
	path_val = 1; // Set path to 0 initially
	chosen_path = 4;
	mode = 0; // Set mode initially to zero
	chosen_mode = 4; // Set random mode so no s appears on display screen initially
	
	chosen_confirm = 4; // Set random mode so it doesn't auto select
	confirm = 0;
	
	current_state = STATE_MENU; // set current state

	while(1) {
	//	MAIN_OUT=!MAIN_OUT;
		//button = left_joystick_button;
		//int_to_stringprint(1, button);
		
		read_inputs(); // Read all inputs	
		
		// FSM Case Statements
		switch(current_state) {
    	
    		case INSTRUCTIONS1:
    			instructions1();
    			break;
    		case INSTRUCTIONS2:
    			instructions2();
    			break;
    		case INSTRUCTIONS3:
    			instructions3();
    			break;
    	
	    	// Home screen
	    	case STATE_MENU:
	    		initialization();
	    		break;
	    	
	    	// Screen 2
	    	case PATH_SELECT:
	    		path_selector();
	    		break;
	    	
	    	// Screen 3
	    	case MODE_SELECT:
	    		mode_selector();
	    		break;		
	    	
	    	case CONFIRM_SELECT:
	    		confirmation();
	    		break;
	    			
	    	case STATS:
	    		stats();
	    		break;
	    }
	}
}
