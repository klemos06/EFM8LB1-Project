#include <EFM8LB1.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>


#define SYSCLK      72000000L  // SYSCLK frequency in Hz
#define BAUDRATE      115200L  // Baud rate of UART in bps
#define SARCLK 18000000L
#define VDD 4.684 // The measured value of VDD in volts



#define PCA_0_FREQ 38000L
#define OLED_ADDR 0x78

#define SCL P0_0 
#define SDA P0_1 

#define x_sec P2_6 // x position for right joystick

#define left_joystick_button P2_4 // Left joystick button
#define right_joystick_button P2_5 // Right joystick button

#define butl P3_1
#define butr P3_0

#define trigr P1_0
#define trigl P1_4

// Full screen buffer (128x64 / 8)
unsigned char xdata screen_buffer[1024];
char buffer[16]; // buffer for int to string conversion

// Declare states
typedef enum {
	STATE_MENU,
	STATE_SCREEN1,
	STATE_SCREEN2,
	STATE_SCREEN3,
	INSTRUCTIONS1,
	INSTRUCTIONS2,
	INSTRUCTIONS3,
	STATS
	
} State;

int x_pos_sec, real_x_sec, path_val, chosen_path;
int screen, mode, chosen_mode, chosen_confirm, confirm; // mode = 0: manual, mode = 1: automatic
int prev_butl, prev_butr, left_button_pressed, right_button_pressed;
State current_state;



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
        return font5x7[1 + (c - '0')];
    }

    // LETTERS
    if (c >= 'A' && c <= 'Z') {
        return font5x7[11 + (c - 'A')];
    }

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
void Init_MCU(void) {
    SFRPAGE = 0x00;
    WDTCN = 0xDE;
    WDTCN = 0xAD;

    CLKSEL = 0x00;
    P0MDOUT = 0x00;
    XBR2 = 0x40;
}
   int rect_x=0;
   
   
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

//void int_to_stringprint(int x)
//{
 //	sprintf(buffer, "x: %.1d", x); // print string to buffer
 //	DrawString(50, 50, buffer);
//}


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
	
	if(right_button_pressed)
    	current_state = STATE_SCREEN1; // Move to other screen
    	
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
    	current_state = STATE_SCREEN2; // Move to other screen
    //	if(path_val ==2)
    		rect_x = 0; // Move rectangle to the left if it is in the middle
    		path_val = 0; // Handles screen switching edge cases
    		mode = 0;
    }
    
    if(left_button_pressed) {
    	current_state = STATE_MENU;
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
	if(right_joystick_button==0){
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
	if(right_button_pressed)
		current_state = STATE_SCREEN3;
	if(left_button_pressed) {
		current_state = STATE_SCREEN1;
		path_val = 1;
		rect_x = 0; // Move cursor to left and fix any edge cases
	}
	
	// Check if right joystick button (select) has been pressed
	if(right_joystick_button==0){
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
	if(right_joystick_button==0 && left_joystick_button ==0){
		if (chosen_path ==4 || chosen_mode ==4)
			DrawString(5, 32, "SELECT ALL OPTIONS");
		else
			chosen_confirm = confirm; // Lock in  a chosen mode from the current mode value
	}
		
  
   	// Print indicator for chosen path
   	if(chosen_confirm == 1)// Yes
    	current_state = STATS;
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
		current_state = STATE_SCREEN2;
		rect_x = 10;
		mode = 0;
	}
		
	OLED_Update();

}

// Display robot information and enable data sending if automatic mode
void stats(void) {

	DrawString(0, 10, "STATISTICS");
	
	// Emergency exit to home
	if(trigr && trigl && !right_joystick_button && !left_joystick_button)
		current_state = STATE_MENU;

	OLED_Update();

}

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
}





// ================= MAIN =================
void main(void) {
	
	// Initialize everything
	Init_MCU();
    OLED_Init();
    OLED_ClearDisplay();  
	InitADC(); // Initialize the ADC
	InitPinADC(2, 6); // Initialize ADC pin
	
	// Initialize everything
	prev_butl = 1; // Set previous button press to zero to help with debouncing
	prev_butr = 1; 
	
	path_val = 1; // Set path to 0 initially
	chosen_path = 4;
	mode = 0; // Set mode initially to zero
	chosen_mode = 4; // Set random mode so no s appears on display screen initially
	
	chosen_confirm = 4; // Set random mode so it doesn't auto select
	confirm = 0;
	
	current_state = STATE_MENU; // set current state

    while (1) {
    	read_inputs(); // Read all inputs
    	
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
	    	case STATE_SCREEN1:
	    		path_selector();
	    		break;
	    	
	    	// Screen 3
	    	case STATE_SCREEN2:
	    		mode_selector();
	    		break;		
	    	
	    	case STATE_SCREEN3:
	    		confirmation();
	    		break;
	    			
	    	case STATS:
	    		stats();
	    		break;
	    }
	   
	}
}
