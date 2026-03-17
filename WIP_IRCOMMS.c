// WIP IR Stuff 


// to do:

// fix the int to binary 
#include <EFM8LB1.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define SYSCLK      72000000L  // SYSCLK frequency in Hz
#define BAUDRATE      115200L  // Baud rate of UART in bps
#define SARCLK 18000000L
#define VDD 4.684 // The measured value of VDD in volts

#define PCA_0_FREQ 38000L



#define MAIN_OUT    P0_1 // Updated in the main program
#define PCA_OUT_0   P0_7




#define LCD_RS P1_7
// #define LCD_RW Px_x // Not used in this code.  Connect to GND
#define LCD_E  P2_0
#define LCD_D4 P1_3
#define LCD_D5 P1_2
#define LCD_D6 P1_1
#define LCD_D7 P1_0
#define x_read P2_6
#define y_read P2_5
#define but_read P2_4

#define CHARS_PER_LINE 16
//#define x_ratio 2.52
//#define y_ratio 2.57



char buffer[16]; // Buffer for converting values to strings
int ir_send = 0; // this indicates if we need the ir to be on or off 
int bit_count = 8; // max number of bits in the buffer


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
	PCA0CPM0=PCA0CPM1=PCA0CPM2=PCA0CPM3=PCA0CPM4=0b_0100_1001; // ECOM|MAT|ECCF;
	// The frequency for PCA channel 0
	PCA0CPL0=(SYSCLK/(2*PCA_0_FREQ))%0x100; //Always write low byte first!
	PCA0CPH0=(SYSCLK/(2*PCA_0_FREQ))/0x100;

	CR=1; // Enable PCA counter
	EIE1|=0b_0001_0000; // Enable PCA interrupts
	
	EA=1; // Enable interrupts
	
	return 0;
}

void ir_sequence () {
	

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

int fourteen_to_eight(int val){
	return ((val*255.0)/16383.0);
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
void LCD_pulse (void)
{
	LCD_E=1;
	Timer3us(40);
	LCD_E=0;
}

void LCD_byte (unsigned char x)
{
	// The accumulator in the C8051Fxxx is bit addressable!
	ACC=x; //Send high nible
	LCD_D7=ACC_7;
	LCD_D6=ACC_6;
	LCD_D5=ACC_5;
	LCD_D4=ACC_4;
	LCD_pulse();
	Timer3us(40);
	ACC=x; //Send low nible
	LCD_D7=ACC_3;
	LCD_D6=ACC_2;
	LCD_D5=ACC_1;
	LCD_D4=ACC_0;
	LCD_pulse();
}


void WriteData (unsigned char x)
{
	LCD_RS=1;
	LCD_byte(x);
	waitms(2);
}

void WriteCommand (unsigned char x)
{
	LCD_RS=0;
	LCD_byte(x);
	waitms(5);
}

void LCD_4BIT (void)
{
	LCD_E=0; // Resting state of LCD's enable is zero
	// LCD_RW=0; // We are only writing to the LCD in this program
	waitms(20);
	// First make sure the LCD is in 8-bit mode and then change to 4-bit mode
	WriteCommand(0x33);
	WriteCommand(0x33);
	WriteCommand(0x32); // Change to 4-bit mode

	// Configure the LCD
	WriteCommand(0x28);
	WriteCommand(0x0c);
	WriteCommand(0x01); // Clear screen command (takes some time)
	waitms(20); // Wait for clear screen command to finsih.
}

void LCDprint(char * string, unsigned char line, bit clear)
{
	int j;

	WriteCommand(line==2?0xc0:0x80);
	waitms(5);
	for(j=0; string[j]!=0; j++)	WriteData(string[j]);// Write the message
	if(clear) for(; j<CHARS_PER_LINE; j++) WriteData(' '); // Clear the rest of the line
}


void TIMER0_Init(void)
{
	TMOD&=0b_1111_0000; // Set the bits of Timer/Counter 0 to zero
	TMOD|=0b_0000_0001; // Timer/Counter 0 used as a 16-bit timer
	TR0=0; // Stop Timer/Counter 0
}


// ----- float_to_stringx -----
// convert a float to a string and print
void float_to_stringprintx(int line, float x)
{
 	sprintf(buffer, "pos x: %.2f", x); // print string to buffer
 	LCDprint(buffer, line, 1); // print buffer to LCD
}

// ----- float_to_stringy -----
// convert a float to a string and print
void float_to_stringprinty(int line, float x)
{
 	sprintf(buffer, "pos y: %.2f", x); // print string to buffer
 	LCDprint(buffer, line, 1); // print buffer to LCD
}

// ----- int_to_stringprint -----
void int_to_stringprintx(int lin, int y)
{
 	sprintf(buffer, "x: %.1d", y); // print string to buffer
 	LCDprint(buffer, lin, 1); // print buffer to LCD
}

void int_to_stringprinty(int lin, int y)
{
 	sprintf(buffer, "y: %.1d", y); // print string to buffer
 	LCDprint(buffer, lin, 1); // print buffer to LCD
}

void int_to_bin(int input, int* binary, int bit_count, int buff_choice) {
    if (buff_choice){
		for (int i = 0; i < bit_count; i++) {
        binary_x[i] = (integer & (1U << (n - i - 1))) ? '1' : '0';
		}
	}
	else {
	for (int i = 0; i < bit_count; i++) {
        binary[i] = (integer & (1U << (n - i - 1))) ? '1' : '0';

	}
	}
}





//----- MAIN -----
void main (void) 
{
	int button;
	int x_pos, y_pos; 
	int real_x, real_y;
	int eight_bitx, eight_bity;
	xdata int binary_x [8]; 
	xdata int binary_y [8]; 
	int buff_choice = 0; 

	
	
	TIMER0_Init(); // Initialize timer 0
	LCD_4BIT(); // Configure LCD in 4 bit mode
	InitADC(); // Initialize the ADC
	InitPinADC(2,6); // Initialize pin 2.6 as analog


	while(1) {
	//	MAIN_OUT=!MAIN_OUT;
		button = but_read;
		//int_to_stringprint(1, button);
		
		
		x_pos = ADC_at_Pin(QFP32_MUX_P2_6);
		y_pos = ADC_at_Pin(QFP32_MUX_P2_5);
		
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
		
		//create packet 
		

		// 1. Convert x/y pos from full 14 bits to 8 bits
		eight_bitx = fourteen_to_eight(real_y);
		eight_bity = fourteen_to_eight(real_x);

		// 2. Convert these values into binary and store into buffer 
		int_to_bin(eight_bitx,  );
		int_to_bin(eight_bity, !buff_choice);



		int_to_stringprintx(1, real_x);
		int_to_stringprinty(2, real_y);	
		
		printf("x_pos: %d, y_pos: %d, button: %d\n", real_x, real_y, button);
		
	//	x_pos = Volts_at_Pin(QFP32_MUX_P2_6);
	//	float_to_stringprintx(1, x_pos);
		
	//	y_pos = Volts_at_Pin(QFP32_MUX_P2_5);
	//	float_to_stringprinty(2, y_pos);
		
		// use an adc pin to read x and y positions
		
		// Convert x and y coordinates into usable information
		// Communicate via NEC with IR information packages
		// Solder onto protoboard
	
	
	}
}