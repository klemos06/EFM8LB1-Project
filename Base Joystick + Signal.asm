;--------------------------------------------------------
; File Created by C51
; Version 1.0.0 #1170 (Feb 16 2022) (MSVC)
; This file was generated Tue Mar 24 13:17:22 2026
;--------------------------------------------------------
$name Base_Joystick___Signal
$optc51 --model-small
$printf_float
	R_DSEG    segment data
	R_CSEG    segment code
	R_BSEG    segment bit
	R_XSEG    segment xdata
	R_PSEG    segment xdata
	R_ISEG    segment idata
	R_OSEG    segment data overlay
	BIT_BANK  segment data overlay
	R_HOME    segment code
	R_GSINIT  segment code
	R_IXSEG   segment xdata
	R_CONST   segment code
	R_XINIT   segment code
	R_DINIT   segment code

;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	public _InitPinADC_PARM_2
	public _main
	public _int_to_stringprinty
	public _int_to_stringprintx
	public _float_to_stringprinty
	public _float_to_stringprintx
	public _TIMER0_Init
	public _LCDprint
	public _LCD_4BIT
	public _WriteCommand
	public _WriteData
	public _LCD_byte
	public _LCD_pulse
	public _waitms
	public _Timer3us
	public _Volts_at_Pin
	public _ADC_at_Pin
	public _InitPinADC
	public _InitADC
	public _PCA_ISR
	public __c51_external_startup
	public _LCDprint_PARM_3
	public _int_to_stringprinty_PARM_2
	public _int_to_stringprintx_PARM_2
	public _float_to_stringprinty_PARM_2
	public _float_to_stringprintx_PARM_2
	public _LCDprint_PARM_2
	public _buffer
;--------------------------------------------------------
; Special Function Registers
;--------------------------------------------------------
_ACC            DATA 0xe0
_ADC0ASAH       DATA 0xb6
_ADC0ASAL       DATA 0xb5
_ADC0ASCF       DATA 0xa1
_ADC0ASCT       DATA 0xc7
_ADC0CF0        DATA 0xbc
_ADC0CF1        DATA 0xb9
_ADC0CF2        DATA 0xdf
_ADC0CN0        DATA 0xe8
_ADC0CN1        DATA 0xb2
_ADC0CN2        DATA 0xb3
_ADC0GTH        DATA 0xc4
_ADC0GTL        DATA 0xc3
_ADC0H          DATA 0xbe
_ADC0L          DATA 0xbd
_ADC0LTH        DATA 0xc6
_ADC0LTL        DATA 0xc5
_ADC0MX         DATA 0xbb
_B              DATA 0xf0
_CKCON0         DATA 0x8e
_CKCON1         DATA 0xa6
_CLEN0          DATA 0xc6
_CLIE0          DATA 0xc7
_CLIF0          DATA 0xe8
_CLKSEL         DATA 0xa9
_CLOUT0         DATA 0xd1
_CLU0CF         DATA 0xb1
_CLU0FN         DATA 0xaf
_CLU0MX         DATA 0x84
_CLU1CF         DATA 0xb3
_CLU1FN         DATA 0xb2
_CLU1MX         DATA 0x85
_CLU2CF         DATA 0xb6
_CLU2FN         DATA 0xb5
_CLU2MX         DATA 0x91
_CLU3CF         DATA 0xbf
_CLU3FN         DATA 0xbe
_CLU3MX         DATA 0xae
_CMP0CN0        DATA 0x9b
_CMP0CN1        DATA 0x99
_CMP0MD         DATA 0x9d
_CMP0MX         DATA 0x9f
_CMP1CN0        DATA 0xbf
_CMP1CN1        DATA 0xac
_CMP1MD         DATA 0xab
_CMP1MX         DATA 0xaa
_CRC0CN0        DATA 0xce
_CRC0CN1        DATA 0x86
_CRC0CNT        DATA 0xd3
_CRC0DAT        DATA 0xcb
_CRC0FLIP       DATA 0xcf
_CRC0IN         DATA 0xca
_CRC0ST         DATA 0xd2
_DAC0CF0        DATA 0x91
_DAC0CF1        DATA 0x92
_DAC0H          DATA 0x85
_DAC0L          DATA 0x84
_DAC1CF0        DATA 0x93
_DAC1CF1        DATA 0x94
_DAC1H          DATA 0x8a
_DAC1L          DATA 0x89
_DAC2CF0        DATA 0x95
_DAC2CF1        DATA 0x96
_DAC2H          DATA 0x8c
_DAC2L          DATA 0x8b
_DAC3CF0        DATA 0x9a
_DAC3CF1        DATA 0x9c
_DAC3H          DATA 0x8e
_DAC3L          DATA 0x8d
_DACGCF0        DATA 0x88
_DACGCF1        DATA 0x98
_DACGCF2        DATA 0xa2
_DERIVID        DATA 0xad
_DEVICEID       DATA 0xb5
_DPH            DATA 0x83
_DPL            DATA 0x82
_EIE1           DATA 0xe6
_EIE2           DATA 0xf3
_EIP1           DATA 0xbb
_EIP1H          DATA 0xee
_EIP2           DATA 0xed
_EIP2H          DATA 0xf6
_EMI0CN         DATA 0xe7
_FLKEY          DATA 0xb7
_HFO0CAL        DATA 0xc7
_HFO1CAL        DATA 0xd6
_HFOCN          DATA 0xef
_I2C0ADM        DATA 0xff
_I2C0CN0        DATA 0xba
_I2C0DIN        DATA 0xbc
_I2C0DOUT       DATA 0xbb
_I2C0FCN0       DATA 0xad
_I2C0FCN1       DATA 0xab
_I2C0FCT        DATA 0xf5
_I2C0SLAD       DATA 0xbd
_I2C0STAT       DATA 0xb9
_IE             DATA 0xa8
_IP             DATA 0xb8
_IPH            DATA 0xf2
_IT01CF         DATA 0xe4
_LFO0CN         DATA 0xb1
_P0             DATA 0x80
_P0MASK         DATA 0xfe
_P0MAT          DATA 0xfd
_P0MDIN         DATA 0xf1
_P0MDOUT        DATA 0xa4
_P0SKIP         DATA 0xd4
_P1             DATA 0x90
_P1MASK         DATA 0xee
_P1MAT          DATA 0xed
_P1MDIN         DATA 0xf2
_P1MDOUT        DATA 0xa5
_P1SKIP         DATA 0xd5
_P2             DATA 0xa0
_P2MASK         DATA 0xfc
_P2MAT          DATA 0xfb
_P2MDIN         DATA 0xf3
_P2MDOUT        DATA 0xa6
_P2SKIP         DATA 0xcc
_P3             DATA 0xb0
_P3MDIN         DATA 0xf4
_P3MDOUT        DATA 0x9c
_PCA0CENT       DATA 0x9e
_PCA0CLR        DATA 0x9c
_PCA0CN0        DATA 0xd8
_PCA0CPH0       DATA 0xfc
_PCA0CPH1       DATA 0xea
_PCA0CPH2       DATA 0xec
_PCA0CPH3       DATA 0xf5
_PCA0CPH4       DATA 0x85
_PCA0CPH5       DATA 0xde
_PCA0CPL0       DATA 0xfb
_PCA0CPL1       DATA 0xe9
_PCA0CPL2       DATA 0xeb
_PCA0CPL3       DATA 0xf4
_PCA0CPL4       DATA 0x84
_PCA0CPL5       DATA 0xdd
_PCA0CPM0       DATA 0xda
_PCA0CPM1       DATA 0xdb
_PCA0CPM2       DATA 0xdc
_PCA0CPM3       DATA 0xae
_PCA0CPM4       DATA 0xaf
_PCA0CPM5       DATA 0xcc
_PCA0H          DATA 0xfa
_PCA0L          DATA 0xf9
_PCA0MD         DATA 0xd9
_PCA0POL        DATA 0x96
_PCA0PWM        DATA 0xf7
_PCON0          DATA 0x87
_PCON1          DATA 0xcd
_PFE0CN         DATA 0xc1
_PRTDRV         DATA 0xf6
_PSCTL          DATA 0x8f
_PSTAT0         DATA 0xaa
_PSW            DATA 0xd0
_REF0CN         DATA 0xd1
_REG0CN         DATA 0xc9
_REVID          DATA 0xb6
_RSTSRC         DATA 0xef
_SBCON1         DATA 0x94
_SBRLH1         DATA 0x96
_SBRLL1         DATA 0x95
_SBUF           DATA 0x99
_SBUF0          DATA 0x99
_SBUF1          DATA 0x92
_SCON           DATA 0x98
_SCON0          DATA 0x98
_SCON1          DATA 0xc8
_SFRPAGE        DATA 0xa7
_SFRPGCN        DATA 0xbc
_SFRSTACK       DATA 0xd7
_SMB0ADM        DATA 0xd6
_SMB0ADR        DATA 0xd7
_SMB0CF         DATA 0xc1
_SMB0CN0        DATA 0xc0
_SMB0DAT        DATA 0xc2
_SMB0FCN0       DATA 0xc3
_SMB0FCN1       DATA 0xc4
_SMB0FCT        DATA 0xef
_SMB0RXLN       DATA 0xc5
_SMB0TC         DATA 0xac
_SMOD1          DATA 0x93
_SP             DATA 0x81
_SPI0CFG        DATA 0xa1
_SPI0CKR        DATA 0xa2
_SPI0CN0        DATA 0xf8
_SPI0DAT        DATA 0xa3
_SPI0FCN0       DATA 0x9a
_SPI0FCN1       DATA 0x9b
_SPI0FCT        DATA 0xf7
_SPI0PCF        DATA 0xdf
_TCON           DATA 0x88
_TH0            DATA 0x8c
_TH1            DATA 0x8d
_TL0            DATA 0x8a
_TL1            DATA 0x8b
_TMOD           DATA 0x89
_TMR2CN0        DATA 0xc8
_TMR2CN1        DATA 0xfd
_TMR2H          DATA 0xcf
_TMR2L          DATA 0xce
_TMR2RLH        DATA 0xcb
_TMR2RLL        DATA 0xca
_TMR3CN0        DATA 0x91
_TMR3CN1        DATA 0xfe
_TMR3H          DATA 0x95
_TMR3L          DATA 0x94
_TMR3RLH        DATA 0x93
_TMR3RLL        DATA 0x92
_TMR4CN0        DATA 0x98
_TMR4CN1        DATA 0xff
_TMR4H          DATA 0xa5
_TMR4L          DATA 0xa4
_TMR4RLH        DATA 0xa3
_TMR4RLL        DATA 0xa2
_TMR5CN0        DATA 0xc0
_TMR5CN1        DATA 0xf1
_TMR5H          DATA 0xd5
_TMR5L          DATA 0xd4
_TMR5RLH        DATA 0xd3
_TMR5RLL        DATA 0xd2
_UART0PCF       DATA 0xd9
_UART1FCN0      DATA 0x9d
_UART1FCN1      DATA 0xd8
_UART1FCT       DATA 0xfa
_UART1LIN       DATA 0x9e
_UART1PCF       DATA 0xda
_VDM0CN         DATA 0xff
_WDTCN          DATA 0x97
_XBR0           DATA 0xe1
_XBR1           DATA 0xe2
_XBR2           DATA 0xe3
_XOSC0CN        DATA 0x86
_DPTR           DATA 0x8382
_TMR2RL         DATA 0xcbca
_TMR3RL         DATA 0x9392
_TMR4RL         DATA 0xa3a2
_TMR5RL         DATA 0xd3d2
_TMR0           DATA 0x8c8a
_TMR1           DATA 0x8d8b
_TMR2           DATA 0xcfce
_TMR3           DATA 0x9594
_TMR4           DATA 0xa5a4
_TMR5           DATA 0xd5d4
_SBRL1          DATA 0x9695
_PCA0           DATA 0xfaf9
_PCA0CP0        DATA 0xfcfb
_PCA0CP1        DATA 0xeae9
_PCA0CP2        DATA 0xeceb
_PCA0CP3        DATA 0xf5f4
_PCA0CP4        DATA 0x8584
_PCA0CP5        DATA 0xdedd
_ADC0ASA        DATA 0xb6b5
_ADC0GT         DATA 0xc4c3
_ADC0           DATA 0xbebd
_ADC0LT         DATA 0xc6c5
_DAC0           DATA 0x8584
_DAC1           DATA 0x8a89
_DAC2           DATA 0x8c8b
_DAC3           DATA 0x8e8d
;--------------------------------------------------------
; special function bits
;--------------------------------------------------------
_ACC_0          BIT 0xe0
_ACC_1          BIT 0xe1
_ACC_2          BIT 0xe2
_ACC_3          BIT 0xe3
_ACC_4          BIT 0xe4
_ACC_5          BIT 0xe5
_ACC_6          BIT 0xe6
_ACC_7          BIT 0xe7
_TEMPE          BIT 0xe8
_ADGN0          BIT 0xe9
_ADGN1          BIT 0xea
_ADWINT         BIT 0xeb
_ADBUSY         BIT 0xec
_ADINT          BIT 0xed
_IPOEN          BIT 0xee
_ADEN           BIT 0xef
_B_0            BIT 0xf0
_B_1            BIT 0xf1
_B_2            BIT 0xf2
_B_3            BIT 0xf3
_B_4            BIT 0xf4
_B_5            BIT 0xf5
_B_6            BIT 0xf6
_B_7            BIT 0xf7
_C0FIF          BIT 0xe8
_C0RIF          BIT 0xe9
_C1FIF          BIT 0xea
_C1RIF          BIT 0xeb
_C2FIF          BIT 0xec
_C2RIF          BIT 0xed
_C3FIF          BIT 0xee
_C3RIF          BIT 0xef
_D1SRC0         BIT 0x88
_D1SRC1         BIT 0x89
_D1AMEN         BIT 0x8a
_D01REFSL       BIT 0x8b
_D3SRC0         BIT 0x8c
_D3SRC1         BIT 0x8d
_D3AMEN         BIT 0x8e
_D23REFSL       BIT 0x8f
_D0UDIS         BIT 0x98
_D1UDIS         BIT 0x99
_D2UDIS         BIT 0x9a
_D3UDIS         BIT 0x9b
_EX0            BIT 0xa8
_ET0            BIT 0xa9
_EX1            BIT 0xaa
_ET1            BIT 0xab
_ES0            BIT 0xac
_ET2            BIT 0xad
_ESPI0          BIT 0xae
_EA             BIT 0xaf
_PX0            BIT 0xb8
_PT0            BIT 0xb9
_PX1            BIT 0xba
_PT1            BIT 0xbb
_PS0            BIT 0xbc
_PT2            BIT 0xbd
_PSPI0          BIT 0xbe
_P0_0           BIT 0x80
_P0_1           BIT 0x81
_P0_2           BIT 0x82
_P0_3           BIT 0x83
_P0_4           BIT 0x84
_P0_5           BIT 0x85
_P0_6           BIT 0x86
_P0_7           BIT 0x87
_P1_0           BIT 0x90
_P1_1           BIT 0x91
_P1_2           BIT 0x92
_P1_3           BIT 0x93
_P1_4           BIT 0x94
_P1_5           BIT 0x95
_P1_6           BIT 0x96
_P1_7           BIT 0x97
_P2_0           BIT 0xa0
_P2_1           BIT 0xa1
_P2_2           BIT 0xa2
_P2_3           BIT 0xa3
_P2_4           BIT 0xa4
_P2_5           BIT 0xa5
_P2_6           BIT 0xa6
_P3_0           BIT 0xb0
_P3_1           BIT 0xb1
_P3_2           BIT 0xb2
_P3_3           BIT 0xb3
_P3_4           BIT 0xb4
_P3_7           BIT 0xb7
_CCF0           BIT 0xd8
_CCF1           BIT 0xd9
_CCF2           BIT 0xda
_CCF3           BIT 0xdb
_CCF4           BIT 0xdc
_CCF5           BIT 0xdd
_CR             BIT 0xde
_CF             BIT 0xdf
_PARITY         BIT 0xd0
_F1             BIT 0xd1
_OV             BIT 0xd2
_RS0            BIT 0xd3
_RS1            BIT 0xd4
_F0             BIT 0xd5
_AC             BIT 0xd6
_CY             BIT 0xd7
_RI             BIT 0x98
_TI             BIT 0x99
_RB8            BIT 0x9a
_TB8            BIT 0x9b
_REN            BIT 0x9c
_CE             BIT 0x9d
_SMODE          BIT 0x9e
_RI1            BIT 0xc8
_TI1            BIT 0xc9
_RBX1           BIT 0xca
_TBX1           BIT 0xcb
_REN1           BIT 0xcc
_PERR1          BIT 0xcd
_OVR1           BIT 0xce
_SI             BIT 0xc0
_ACK            BIT 0xc1
_ARBLOST        BIT 0xc2
_ACKRQ          BIT 0xc3
_STO            BIT 0xc4
_STA            BIT 0xc5
_TXMODE         BIT 0xc6
_MASTER         BIT 0xc7
_SPIEN          BIT 0xf8
_TXNF           BIT 0xf9
_NSSMD0         BIT 0xfa
_NSSMD1         BIT 0xfb
_RXOVRN         BIT 0xfc
_MODF           BIT 0xfd
_WCOL           BIT 0xfe
_SPIF           BIT 0xff
_IT0            BIT 0x88
_IE0            BIT 0x89
_IT1            BIT 0x8a
_IE1            BIT 0x8b
_TR0            BIT 0x8c
_TF0            BIT 0x8d
_TR1            BIT 0x8e
_TF1            BIT 0x8f
_T2XCLK0        BIT 0xc8
_T2XCLK1        BIT 0xc9
_TR2            BIT 0xca
_T2SPLIT        BIT 0xcb
_TF2CEN         BIT 0xcc
_TF2LEN         BIT 0xcd
_TF2L           BIT 0xce
_TF2H           BIT 0xcf
_T4XCLK0        BIT 0x98
_T4XCLK1        BIT 0x99
_TR4            BIT 0x9a
_T4SPLIT        BIT 0x9b
_TF4CEN         BIT 0x9c
_TF4LEN         BIT 0x9d
_TF4L           BIT 0x9e
_TF4H           BIT 0x9f
_T5XCLK0        BIT 0xc0
_T5XCLK1        BIT 0xc1
_TR5            BIT 0xc2
_T5SPLIT        BIT 0xc3
_TF5CEN         BIT 0xc4
_TF5LEN         BIT 0xc5
_TF5L           BIT 0xc6
_TF5H           BIT 0xc7
_RIE            BIT 0xd8
_RXTO0          BIT 0xd9
_RXTO1          BIT 0xda
_RFRQ           BIT 0xdb
_TIE            BIT 0xdc
_TXHOLD         BIT 0xdd
_TXNF1          BIT 0xde
_TFRQ           BIT 0xdf
;--------------------------------------------------------
; overlayable register banks
;--------------------------------------------------------
	rbank0 segment data overlay
;--------------------------------------------------------
; internal ram data
;--------------------------------------------------------
	rseg R_DSEG
_buffer:
	ds 16
_LCDprint_PARM_2:
	ds 1
_float_to_stringprintx_PARM_2:
	ds 4
_float_to_stringprinty_PARM_2:
	ds 4
_int_to_stringprintx_PARM_2:
	ds 2
_int_to_stringprinty_PARM_2:
	ds 2
_main_button_1_107:
	ds 2
;--------------------------------------------------------
; overlayable items in internal ram 
;--------------------------------------------------------
	rseg	R_OSEG
_InitPinADC_PARM_2:
	ds 1
	rseg	R_OSEG
	rseg	R_OSEG
;--------------------------------------------------------
; indirectly addressable internal ram data
;--------------------------------------------------------
	rseg R_ISEG
;--------------------------------------------------------
; absolute internal ram data
;--------------------------------------------------------
	DSEG
;--------------------------------------------------------
; bit data
;--------------------------------------------------------
	rseg R_BSEG
_LCDprint_PARM_3:
	DBIT	1
;--------------------------------------------------------
; paged external ram data
;--------------------------------------------------------
	rseg R_PSEG
;--------------------------------------------------------
; external ram data
;--------------------------------------------------------
	rseg R_XSEG
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	XSEG
;--------------------------------------------------------
; external initialized ram data
;--------------------------------------------------------
	rseg R_IXSEG
	rseg R_HOME
	rseg R_GSINIT
	rseg R_CSEG
;--------------------------------------------------------
; Reset entry point and interrupt vectors
;--------------------------------------------------------
	CSEG at 0x0000
	ljmp	_crt0
	CSEG at 0x005b
	ljmp	_PCA_ISR
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	rseg R_HOME
	rseg R_GSINIT
	rseg R_GSINIT
;--------------------------------------------------------
; data variables initialization
;--------------------------------------------------------
	rseg R_DINIT
	; The linker places a 'ret' at the end of segment R_DINIT.
;--------------------------------------------------------
; code
;--------------------------------------------------------
	rseg R_CSEG
;------------------------------------------------------------
;Allocation info for local variables in function '_c51_external_startup'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:42: char _c51_external_startup (void)
;	-----------------------------------------
;	 function _c51_external_startup
;	-----------------------------------------
__c51_external_startup:
	using	0
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:45: SFRPAGE = 0x00;
	mov	_SFRPAGE,#0x00
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:46: WDTCN = 0xDE; //First key
	mov	_WDTCN,#0xDE
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:47: WDTCN = 0xAD; //Second key
	mov	_WDTCN,#0xAD
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:49: VDM0CN |= 0x80;
	orl	_VDM0CN,#0x80
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:50: RSTSRC = 0x02;
	mov	_RSTSRC,#0x02
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:57: SFRPAGE = 0x10;
	mov	_SFRPAGE,#0x10
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:58: PFE0CN  = 0x20; // SYSCLK < 75 MHz.
	mov	_PFE0CN,#0x20
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:59: SFRPAGE = 0x00;
	mov	_SFRPAGE,#0x00
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:80: CLKSEL = 0x00;
	mov	_CLKSEL,#0x00
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:81: CLKSEL = 0x00;
	mov	_CLKSEL,#0x00
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:82: while ((CLKSEL & 0x80) == 0);
L002001?:
	mov	a,_CLKSEL
	jnb	acc.7,L002001?
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:83: CLKSEL = 0x03;
	mov	_CLKSEL,#0x03
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:84: CLKSEL = 0x03;
	mov	_CLKSEL,#0x03
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:85: while ((CLKSEL & 0x80) == 0);
L002004?:
	mov	a,_CLKSEL
	jnb	acc.7,L002004?
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:91: P0MDOUT |= 0b10000000;
	orl	_P0MDOUT,#0x80
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:92: P1MDOUT|=0b_1111_1111;
	mov	a,_P1MDOUT
	mov	_P1MDOUT,#0xFF
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:93: P2MDOUT|=0b_0000_0001;
	orl	_P2MDOUT,#0x01
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:95: XBR0     = 0x01; // Enable UART0 on P0.4(TX) and P0.5(RX)                     
	mov	_XBR0,#0x01
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:96: XBR1     = 0X00;
	mov	_XBR1,#0x00
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:97: XBR2     = 0x40; // Enable crossbar and weak pull-ups
	mov	_XBR2,#0x40
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:103: SCON0 = 0x10;
	mov	_SCON0,#0x10
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:104: CKCON0 |= 0b_0000_0000 ; // Timer 1 uses the system clock divided by 12.
	mov	_CKCON0,_CKCON0
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:105: TH1 = 0x100-((SYSCLK/BAUDRATE)/(2L*12L));
	mov	_TH1,#0xE6
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:106: TL1 = TH1;      // Init Timer1
	mov	_TL1,_TH1
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:107: TMOD &= ~0xf0;  // TMOD: timer 1 in 8-bit auto-reload
	anl	_TMOD,#0x0F
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:108: TMOD |=  0x20;                       
	orl	_TMOD,#0x20
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:109: TR1 = 1; // START Timer1
	setb	_TR1
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:110: TI = 1;  // Indicate TX0 ready
	setb	_TI
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:113: SFRPAGE=0x0;
	mov	_SFRPAGE,#0x00
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:114: PCA0MD=0x00; // Disable and clear everything in the PCA
	mov	_PCA0MD,#0x00
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:115: PCA0L=0; // Initialize the PCA counter to zero
	mov	_PCA0L,#0x00
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:116: PCA0H=0;
	mov	_PCA0H,#0x00
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:117: PCA0MD=0b_0000_1000; // Configure PCA.  System CLK is the frequency input for the PCA
	mov	_PCA0MD,#0x08
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:119: PCA0CPM0=0b_0100_1001; // ECOM|MAT|ECCF;
	mov	_PCA0CPM0,#0x49
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:121: PCA0CPL0=(SYSCLK/(2*PCA_0_FREQ))%0x100; //Always write low byte first!
	mov	_PCA0CPL0,#0xB3
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:122: PCA0CPH0=(SYSCLK/(2*PCA_0_FREQ))/0x100;
	mov	_PCA0CPH0,#0x03
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:124: CR=1; // Enable PCA counter
	setb	_CR
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:125: EIE1|=0b_0001_0000; // Enable PCA interrupts
	orl	_EIE1,#0x10
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:127: EA=1; // Enable interrupts
	setb	_EA
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:129: return 0;
	mov	dpl,#0x00
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'PCA_ISR'
;------------------------------------------------------------
;j                         Allocated to registers r2 r3 
;------------------------------------------------------------
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:133: void PCA_ISR (void) interrupt INTERRUPT_PCA0
;	-----------------------------------------
;	 function PCA_ISR
;	-----------------------------------------
_PCA_ISR:
	push	acc
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	psw
	mov	psw,#0x00
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:137: SFRPAGE=0x0;
	mov	_SFRPAGE,#0x00
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:139: if (CCF0)
	jnb	_CCF0,L003002?
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:141: j=(PCA0CPH0*0x100+PCA0CPL0)+(SYSCLK/(2L*PCA_0_FREQ));
	mov	r3,_PCA0CPH0
	mov	r2,#0x00
	mov	r4,_PCA0CPL0
	mov	r5,#0x00
	mov	a,r4
	add	a,r2
	mov	r2,a
	mov	a,r5
	addc	a,r3
	mov	r3,a
	rlc	a
	subb	a,acc
	mov	r4,a
	mov	r5,a
	mov	a,#0xB3
	add	a,r2
	mov	r2,a
	mov	a,#0x03
	addc	a,r3
	mov	r3,a
	clr	a
	addc	a,r4
	clr	a
	addc	a,r5
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:142: PCA0CPL0=j%0x100; //Always write low byte first!
	mov	ar4,r2
	mov	r5,#0x00
	mov	_PCA0CPL0,r4
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:143: PCA0CPH0=j/0x100;
	mov	ar2,r3
	mov	r3,#0x00
	mov	_PCA0CPH0,r2
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:144: CCF0=0;
	clr	_CCF0
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:145: PCA_OUT_0=!PCA_OUT_0;
	cpl	_P0_7
L003002?:
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:148: CF=0;
	clr	_CF
	pop	psw
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	pop	acc
	reti
;	eliminated unneeded push/pop dpl
;	eliminated unneeded push/pop dph
;	eliminated unneeded push/pop b
;------------------------------------------------------------
;Allocation info for local variables in function 'InitADC'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:152: void InitADC (void)
;	-----------------------------------------
;	 function InitADC
;	-----------------------------------------
_InitADC:
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:154: SFRPAGE = 0x00;
	mov	_SFRPAGE,#0x00
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:155: ADEN=0; // Disable ADC
	clr	_ADEN
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:160: (0x0 << 0) ; // Accumulate n conversions: 0x0: 1, 0x1:4, 0x2:8, 0x3:16, 0x4:32
	mov	_ADC0CN1,#0x80
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:164: (0x0 << 2); // 0:SYSCLK ADCCLK = SYSCLK. 1:HFOSC0 ADCCLK = HFOSC0.
	mov	_ADC0CF0,#0x20
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:168: (0x1E << 0); // Conversion Tracking Time. Tadtk = ADTK / (Fsarclk)
	mov	_ADC0CF1,#0x1E
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:177: (0x0 << 0) ; // TEMPE. 0: Disable the Temperature Sensor. 1: Enable the Temperature Sensor.
	mov	_ADC0CN0,#0x00
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:182: (0x1F << 0); // ADPWR. Power Up Delay Time. Tpwrtime = ((4 * (ADPWR + 1)) + 2) / (Fadcclk)
	mov	_ADC0CF2,#0x3F
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:186: (0x0 << 0) ; // ADCM. 0x0: ADBUSY, 0x1: TIMER0, 0x2: TIMER2, 0x3: TIMER3, 0x4: CNVSTR, 0x5: CEX5, 0x6: TIMER4, 0x7: TIMER5, 0x8: CLU0, 0x9: CLU1, 0xA: CLU2, 0xB: CLU3
	mov	_ADC0CN2,#0x00
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:188: ADEN=1; // Enable ADC
	setb	_ADEN
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'InitPinADC'
;------------------------------------------------------------
;pin_num                   Allocated with name '_InitPinADC_PARM_2'
;portno                    Allocated to registers r2 
;mask                      Allocated to registers r3 
;------------------------------------------------------------
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:191: void InitPinADC (unsigned char portno, unsigned char pin_num)
;	-----------------------------------------
;	 function InitPinADC
;	-----------------------------------------
_InitPinADC:
	mov	r2,dpl
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:195: mask=1<<pin_num;
	mov	b,_InitPinADC_PARM_2
	inc	b
	mov	a,#0x01
	sjmp	L005013?
L005011?:
	add	a,acc
L005013?:
	djnz	b,L005011?
	mov	r3,a
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:197: SFRPAGE = 0x20;
	mov	_SFRPAGE,#0x20
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:198: switch (portno)
	cjne	r2,#0x00,L005014?
	sjmp	L005001?
L005014?:
	cjne	r2,#0x01,L005015?
	sjmp	L005002?
L005015?:
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:200: case 0:
	cjne	r2,#0x02,L005005?
	sjmp	L005003?
L005001?:
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:201: P0MDIN &= (~mask); // Set pin as analog input
	mov	a,r3
	cpl	a
	mov	r2,a
	anl	_P0MDIN,a
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:202: P0SKIP |= mask; // Skip Crossbar decoding for this pin
	mov	a,r3
	orl	_P0SKIP,a
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:203: break;
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:204: case 1:
	sjmp	L005005?
L005002?:
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:205: P1MDIN &= (~mask); // Set pin as analog input
	mov	a,r3
	cpl	a
	mov	r2,a
	anl	_P1MDIN,a
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:206: P1SKIP |= mask; // Skip Crossbar decoding for this pin
	mov	a,r3
	orl	_P1SKIP,a
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:207: break;
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:208: case 2:
	sjmp	L005005?
L005003?:
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:209: P2MDIN &= (~mask); // Set pin as analog input
	mov	a,r3
	cpl	a
	mov	r2,a
	anl	_P2MDIN,a
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:210: P2SKIP |= mask; // Skip Crossbar decoding for this pin
	mov	a,r3
	orl	_P2SKIP,a
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:214: }
L005005?:
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:215: SFRPAGE = 0x00;
	mov	_SFRPAGE,#0x00
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'ADC_at_Pin'
;------------------------------------------------------------
;pin                       Allocated to registers 
;------------------------------------------------------------
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:218: unsigned int ADC_at_Pin(unsigned char pin)
;	-----------------------------------------
;	 function ADC_at_Pin
;	-----------------------------------------
_ADC_at_Pin:
	mov	_ADC0MX,dpl
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:221: ADINT = 0;
	clr	_ADINT
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:222: ADBUSY = 1;     // Convert voltage at the pin
	setb	_ADBUSY
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:223: while (!ADINT); // Wait for conversion to complete
L006001?:
	jnb	_ADINT,L006001?
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:224: return (ADC0);
	mov	dpl,_ADC0
	mov	dph,(_ADC0 >> 8)
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Volts_at_Pin'
;------------------------------------------------------------
;pin                       Allocated to registers r2 
;------------------------------------------------------------
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:227: float Volts_at_Pin(unsigned char pin)
;	-----------------------------------------
;	 function Volts_at_Pin
;	-----------------------------------------
_Volts_at_Pin:
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:229: return ((ADC_at_Pin(pin)*VDD)/16383.0);
	lcall	_ADC_at_Pin
	lcall	___uint2fs
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	dptr,#0xE354
	mov	b,#0x95
	mov	a,#0x40
	lcall	___fsmul
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	clr	a
	push	acc
	mov	a,#0xFC
	push	acc
	mov	a,#0x7F
	push	acc
	mov	a,#0x46
	push	acc
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	lcall	___fsdiv
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Timer3us'
;------------------------------------------------------------
;us                        Allocated to registers r2 
;i                         Allocated to registers r3 
;------------------------------------------------------------
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:233: void Timer3us(unsigned char us)
;	-----------------------------------------
;	 function Timer3us
;	-----------------------------------------
_Timer3us:
	mov	r2,dpl
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:238: CKCON0|=0b_0100_0000;
	orl	_CKCON0,#0x40
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:240: TMR3RL = (-(SYSCLK)/1000000L); // Set Timer3 to overflow in 1us.
	mov	_TMR3RL,#0xB8
	mov	(_TMR3RL >> 8),#0xFF
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:241: TMR3 = TMR3RL;                 // Initialize Timer3 for first overflow
	mov	_TMR3,_TMR3RL
	mov	(_TMR3 >> 8),(_TMR3RL >> 8)
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:243: TMR3CN0 = 0x04;                 // Sart Timer3 and clear overflow flag
	mov	_TMR3CN0,#0x04
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:244: for (i = 0; i < us; i++)       // Count <us> overflows
	mov	r3,#0x00
L008004?:
	clr	c
	mov	a,r3
	subb	a,r2
	jnc	L008007?
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:246: while (!(TMR3CN0 & 0x80));  // Wait for overflow
L008001?:
	mov	a,_TMR3CN0
	jnb	acc.7,L008001?
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:247: TMR3CN0 &= ~(0x80);         // Clear overflow indicator
	anl	_TMR3CN0,#0x7F
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:244: for (i = 0; i < us; i++)       // Count <us> overflows
	inc	r3
	sjmp	L008004?
L008007?:
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:249: TMR3CN0 = 0 ;                   // Stop Timer3 and clear overflow flag
	mov	_TMR3CN0,#0x00
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'waitms'
;------------------------------------------------------------
;ms                        Allocated to registers r2 r3 
;j                         Allocated to registers r2 r3 
;------------------------------------------------------------
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:252: void waitms (unsigned int ms)
;	-----------------------------------------
;	 function waitms
;	-----------------------------------------
_waitms:
	mov	r2,dpl
	mov	r3,dph
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:255: for(j=ms; j!=0; j--)
L009001?:
	cjne	r2,#0x00,L009010?
	cjne	r3,#0x00,L009010?
	ret
L009010?:
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:257: Timer3us(249);
	mov	dpl,#0xF9
	push	ar2
	push	ar3
	lcall	_Timer3us
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:258: Timer3us(249);
	mov	dpl,#0xF9
	lcall	_Timer3us
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:259: Timer3us(249);
	mov	dpl,#0xF9
	lcall	_Timer3us
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:260: Timer3us(250);
	mov	dpl,#0xFA
	lcall	_Timer3us
	pop	ar3
	pop	ar2
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:255: for(j=ms; j!=0; j--)
	dec	r2
	cjne	r2,#0xff,L009011?
	dec	r3
L009011?:
	sjmp	L009001?
;------------------------------------------------------------
;Allocation info for local variables in function 'LCD_pulse'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:263: void LCD_pulse (void)
;	-----------------------------------------
;	 function LCD_pulse
;	-----------------------------------------
_LCD_pulse:
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:265: LCD_E=1;
	setb	_P2_0
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:266: Timer3us(40);
	mov	dpl,#0x28
	lcall	_Timer3us
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:267: LCD_E=0;
	clr	_P2_0
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'LCD_byte'
;------------------------------------------------------------
;x                         Allocated to registers r2 
;------------------------------------------------------------
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:270: void LCD_byte (unsigned char x)
;	-----------------------------------------
;	 function LCD_byte
;	-----------------------------------------
_LCD_byte:
	mov	r2,dpl
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:273: ACC=x; //Send high nible
	mov	_ACC,r2
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:274: LCD_D7=ACC_7;
	mov	c,_ACC_7
	mov	_P1_0,c
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:275: LCD_D6=ACC_6;
	mov	c,_ACC_6
	mov	_P1_1,c
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:276: LCD_D5=ACC_5;
	mov	c,_ACC_5
	mov	_P1_2,c
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:277: LCD_D4=ACC_4;
	mov	c,_ACC_4
	mov	_P1_3,c
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:278: LCD_pulse();
	push	ar2
	lcall	_LCD_pulse
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:279: Timer3us(40);
	mov	dpl,#0x28
	lcall	_Timer3us
	pop	ar2
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:280: ACC=x; //Send low nible
	mov	_ACC,r2
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:281: LCD_D7=ACC_3;
	mov	c,_ACC_3
	mov	_P1_0,c
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:282: LCD_D6=ACC_2;
	mov	c,_ACC_2
	mov	_P1_1,c
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:283: LCD_D5=ACC_1;
	mov	c,_ACC_1
	mov	_P1_2,c
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:284: LCD_D4=ACC_0;
	mov	c,_ACC_0
	mov	_P1_3,c
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:285: LCD_pulse();
	ljmp	_LCD_pulse
;------------------------------------------------------------
;Allocation info for local variables in function 'WriteData'
;------------------------------------------------------------
;x                         Allocated to registers r2 
;------------------------------------------------------------
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:289: void WriteData (unsigned char x)
;	-----------------------------------------
;	 function WriteData
;	-----------------------------------------
_WriteData:
	mov	r2,dpl
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:291: LCD_RS=1;
	setb	_P1_7
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:292: LCD_byte(x);
	mov	dpl,r2
	lcall	_LCD_byte
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:293: waitms(2);
	mov	dptr,#0x0002
	ljmp	_waitms
;------------------------------------------------------------
;Allocation info for local variables in function 'WriteCommand'
;------------------------------------------------------------
;x                         Allocated to registers r2 
;------------------------------------------------------------
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:296: void WriteCommand (unsigned char x)
;	-----------------------------------------
;	 function WriteCommand
;	-----------------------------------------
_WriteCommand:
	mov	r2,dpl
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:298: LCD_RS=0;
	clr	_P1_7
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:299: LCD_byte(x);
	mov	dpl,r2
	lcall	_LCD_byte
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:300: waitms(5);
	mov	dptr,#0x0005
	ljmp	_waitms
;------------------------------------------------------------
;Allocation info for local variables in function 'LCD_4BIT'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:303: void LCD_4BIT (void)
;	-----------------------------------------
;	 function LCD_4BIT
;	-----------------------------------------
_LCD_4BIT:
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:305: LCD_E=0; // Resting state of LCD's enable is zero
	clr	_P2_0
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:307: waitms(20);
	mov	dptr,#0x0014
	lcall	_waitms
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:309: WriteCommand(0x33);
	mov	dpl,#0x33
	lcall	_WriteCommand
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:310: WriteCommand(0x33);
	mov	dpl,#0x33
	lcall	_WriteCommand
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:311: WriteCommand(0x32); // Change to 4-bit mode
	mov	dpl,#0x32
	lcall	_WriteCommand
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:314: WriteCommand(0x28);
	mov	dpl,#0x28
	lcall	_WriteCommand
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:315: WriteCommand(0x0c);
	mov	dpl,#0x0C
	lcall	_WriteCommand
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:316: WriteCommand(0x01); // Clear screen command (takes some time)
	mov	dpl,#0x01
	lcall	_WriteCommand
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:317: waitms(20); // Wait for clear screen command to finsih.
	mov	dptr,#0x0014
	ljmp	_waitms
;------------------------------------------------------------
;Allocation info for local variables in function 'LCDprint'
;------------------------------------------------------------
;line                      Allocated with name '_LCDprint_PARM_2'
;string                    Allocated to registers r2 r3 r4 
;j                         Allocated to registers r5 r6 
;------------------------------------------------------------
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:320: void LCDprint(char * string, unsigned char line, bit clear)
;	-----------------------------------------
;	 function LCDprint
;	-----------------------------------------
_LCDprint:
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:324: WriteCommand(line==2?0xc0:0x80);
	mov	a,#0x02
	cjne	a,_LCDprint_PARM_2,L015013?
	mov	r5,#0xC0
	sjmp	L015014?
L015013?:
	mov	r5,#0x80
L015014?:
	mov	dpl,r5
	push	ar2
	push	ar3
	push	ar4
	lcall	_WriteCommand
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:325: waitms(5);
	mov	dptr,#0x0005
	lcall	_waitms
	pop	ar4
	pop	ar3
	pop	ar2
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:326: for(j=0; string[j]!=0; j++)	WriteData(string[j]);// Write the message
	mov	r5,#0x00
	mov	r6,#0x00
L015003?:
	mov	a,r5
	add	a,r2
	mov	r7,a
	mov	a,r6
	addc	a,r3
	mov	r0,a
	mov	ar1,r4
	mov	dpl,r7
	mov	dph,r0
	mov	b,r1
	lcall	__gptrget
	mov	r7,a
	jz	L015006?
	mov	dpl,r7
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	ar6
	lcall	_WriteData
	pop	ar6
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	inc	r5
	cjne	r5,#0x00,L015003?
	inc	r6
	sjmp	L015003?
L015006?:
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:327: if(clear) for(; j<CHARS_PER_LINE; j++) WriteData(' '); // Clear the rest of the line
	jnb	_LCDprint_PARM_3,L015011?
	mov	ar2,r5
	mov	ar3,r6
L015007?:
	clr	c
	mov	a,r2
	subb	a,#0x10
	mov	a,r3
	xrl	a,#0x80
	subb	a,#0x80
	jnc	L015011?
	mov	dpl,#0x20
	push	ar2
	push	ar3
	lcall	_WriteData
	pop	ar3
	pop	ar2
	inc	r2
	cjne	r2,#0x00,L015007?
	inc	r3
	sjmp	L015007?
L015011?:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'TIMER0_Init'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:331: void TIMER0_Init(void)
;	-----------------------------------------
;	 function TIMER0_Init
;	-----------------------------------------
_TIMER0_Init:
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:333: TMOD&=0b_1111_0000; // Set the bits of Timer/Counter 0 to zero
	anl	_TMOD,#0xF0
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:334: TMOD|=0b_0000_0001; // Timer/Counter 0 used as a 16-bit timer
	orl	_TMOD,#0x01
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:335: TR0=0; // Stop Timer/Counter 0
	clr	_TR0
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'float_to_stringprintx'
;------------------------------------------------------------
;x                         Allocated with name '_float_to_stringprintx_PARM_2'
;line                      Allocated to registers r2 r3 
;------------------------------------------------------------
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:341: void float_to_stringprintx(int line, float x)
;	-----------------------------------------
;	 function float_to_stringprintx
;	-----------------------------------------
_float_to_stringprintx:
	mov	r2,dpl
	mov	r3,dph
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:343: sprintf(buffer, "pos x: %.2f", x); // print string to buffer
	push	ar2
	push	ar3
	push	_float_to_stringprintx_PARM_2
	push	(_float_to_stringprintx_PARM_2 + 1)
	push	(_float_to_stringprintx_PARM_2 + 2)
	push	(_float_to_stringprintx_PARM_2 + 3)
	mov	a,#__str_0
	push	acc
	mov	a,#(__str_0 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	mov	a,#_buffer
	push	acc
	mov	a,#(_buffer >> 8)
	push	acc
	mov	a,#0x40
	push	acc
	lcall	_sprintf
	mov	a,sp
	add	a,#0xf6
	mov	sp,a
	pop	ar3
	pop	ar2
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:344: LCDprint(buffer, line, 1); // print buffer to LCD
	mov	_LCDprint_PARM_2,r2
	setb	_LCDprint_PARM_3
	mov	dptr,#_buffer
	mov	b,#0x40
	ljmp	_LCDprint
;------------------------------------------------------------
;Allocation info for local variables in function 'float_to_stringprinty'
;------------------------------------------------------------
;x                         Allocated with name '_float_to_stringprinty_PARM_2'
;line                      Allocated to registers r2 r3 
;------------------------------------------------------------
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:349: void float_to_stringprinty(int line, float x)
;	-----------------------------------------
;	 function float_to_stringprinty
;	-----------------------------------------
_float_to_stringprinty:
	mov	r2,dpl
	mov	r3,dph
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:351: sprintf(buffer, "pos y: %.2f", x); // print string to buffer
	push	ar2
	push	ar3
	push	_float_to_stringprinty_PARM_2
	push	(_float_to_stringprinty_PARM_2 + 1)
	push	(_float_to_stringprinty_PARM_2 + 2)
	push	(_float_to_stringprinty_PARM_2 + 3)
	mov	a,#__str_1
	push	acc
	mov	a,#(__str_1 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	mov	a,#_buffer
	push	acc
	mov	a,#(_buffer >> 8)
	push	acc
	mov	a,#0x40
	push	acc
	lcall	_sprintf
	mov	a,sp
	add	a,#0xf6
	mov	sp,a
	pop	ar3
	pop	ar2
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:352: LCDprint(buffer, line, 1); // print buffer to LCD
	mov	_LCDprint_PARM_2,r2
	setb	_LCDprint_PARM_3
	mov	dptr,#_buffer
	mov	b,#0x40
	ljmp	_LCDprint
;------------------------------------------------------------
;Allocation info for local variables in function 'int_to_stringprintx'
;------------------------------------------------------------
;y                         Allocated with name '_int_to_stringprintx_PARM_2'
;lin                       Allocated to registers r2 r3 
;------------------------------------------------------------
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:356: void int_to_stringprintx(int lin, int y)
;	-----------------------------------------
;	 function int_to_stringprintx
;	-----------------------------------------
_int_to_stringprintx:
	mov	r2,dpl
	mov	r3,dph
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:358: sprintf(buffer, "x: %.1d", y); // print string to buffer
	push	ar2
	push	ar3
	push	_int_to_stringprintx_PARM_2
	push	(_int_to_stringprintx_PARM_2 + 1)
	mov	a,#__str_2
	push	acc
	mov	a,#(__str_2 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	mov	a,#_buffer
	push	acc
	mov	a,#(_buffer >> 8)
	push	acc
	mov	a,#0x40
	push	acc
	lcall	_sprintf
	mov	a,sp
	add	a,#0xf8
	mov	sp,a
	pop	ar3
	pop	ar2
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:359: LCDprint(buffer, lin, 1); // print buffer to LCD
	mov	_LCDprint_PARM_2,r2
	setb	_LCDprint_PARM_3
	mov	dptr,#_buffer
	mov	b,#0x40
	ljmp	_LCDprint
;------------------------------------------------------------
;Allocation info for local variables in function 'int_to_stringprinty'
;------------------------------------------------------------
;y                         Allocated with name '_int_to_stringprinty_PARM_2'
;lin                       Allocated to registers r2 r3 
;------------------------------------------------------------
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:362: void int_to_stringprinty(int lin, int y)
;	-----------------------------------------
;	 function int_to_stringprinty
;	-----------------------------------------
_int_to_stringprinty:
	mov	r2,dpl
	mov	r3,dph
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:364: sprintf(buffer, "y: %.1d", y); // print string to buffer
	push	ar2
	push	ar3
	push	_int_to_stringprinty_PARM_2
	push	(_int_to_stringprinty_PARM_2 + 1)
	mov	a,#__str_3
	push	acc
	mov	a,#(__str_3 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	mov	a,#_buffer
	push	acc
	mov	a,#(_buffer >> 8)
	push	acc
	mov	a,#0x40
	push	acc
	lcall	_sprintf
	mov	a,sp
	add	a,#0xf8
	mov	sp,a
	pop	ar3
	pop	ar2
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:365: LCDprint(buffer, lin, 1); // print buffer to LCD
	mov	_LCDprint_PARM_2,r2
	setb	_LCDprint_PARM_3
	mov	dptr,#_buffer
	mov	b,#0x40
	ljmp	_LCDprint
;------------------------------------------------------------
;Allocation info for local variables in function 'main'
;------------------------------------------------------------
;button                    Allocated with name '_main_button_1_107'
;x_pos                     Allocated to registers r4 r5 
;y_pos                     Allocated to registers r6 r7 
;real_x                    Allocated to registers r2 r3 
;real_y                    Allocated to registers r4 r5 
;------------------------------------------------------------
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:370: void main (void) 
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:377: TIMER0_Init(); // Initialize timer 0
	lcall	_TIMER0_Init
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:378: LCD_4BIT(); // Configure LCD in 4 bit mode
	lcall	_LCD_4BIT
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:379: InitADC(); // Initialize the ADC
	lcall	_InitADC
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:380: InitPinADC(2,6); // Initialize pin 2.6 as analog
	mov	_InitPinADC_PARM_2,#0x06
	mov	dpl,#0x02
	lcall	_InitPinADC
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:381: InitPinADC(2,5); // Initialize pin 2.5 as analog
	mov	_InitPinADC_PARM_2,#0x05
	mov	dpl,#0x02
	lcall	_InitPinADC
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:384: while(1) {
L021008?:
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:386: button = but_read;
	mov	c,_P2_4
	clr	a
	rlc	a
	mov	_main_button_1_107,a
	mov	(_main_button_1_107 + 1),#0x00
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:390: x_pos = ADC_at_Pin(QFP32_MUX_P2_6);
	mov	dpl,#0x13
	lcall	_ADC_at_Pin
	mov	r4,dpl
	mov	r5,dph
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:391: y_pos = ADC_at_Pin(QFP32_MUX_P2_5);
	mov	dpl,#0x12
	push	ar4
	push	ar5
	lcall	_ADC_at_Pin
	mov	r6,dpl
	mov	r7,dph
	pop	ar5
	pop	ar4
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:393: if(x_pos > 11730) {
	clr	c
	mov	a,#0xD2
	subb	a,r4
	mov	a,#(0x2D ^ 0x80)
	mov	b,r5
	xrl	b,#0x80
	subb	a,b
	jc	L021015?
	ljmp	L021002?
L021015?:
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:394: real_x =  11730 + 11730*((x_pos-11730)/4653.0);
	mov	a,r4
	add	a,#0x2e
	mov	dpl,a
	mov	a,r5
	addc	a,#0xd2
	mov	dph,a
	push	ar6
	push	ar7
	lcall	___sint2fs
	mov	r0,dpl
	mov	r1,dph
	mov	r2,b
	mov	r3,a
	clr	a
	push	acc
	mov	a,#0x68
	push	acc
	mov	a,#0x91
	push	acc
	mov	a,#0x45
	push	acc
	mov	dpl,r0
	mov	dph,r1
	mov	b,r2
	mov	a,r3
	lcall	___fsdiv
	mov	r2,dpl
	mov	r3,dph
	mov	r0,b
	mov	r1,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	push	ar2
	push	ar3
	push	ar0
	push	ar1
	mov	dptr,#0x4800
	mov	b,#0x37
	mov	a,#0x46
	lcall	___fsmul
	mov	r2,dpl
	mov	r3,dph
	mov	r0,b
	mov	r1,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	clr	a
	push	acc
	mov	a,#0x48
	push	acc
	mov	a,#0x37
	push	acc
	mov	a,#0x46
	push	acc
	mov	dpl,r2
	mov	dph,r3
	mov	b,r0
	mov	a,r1
	lcall	___fsadd
	mov	r2,dpl
	mov	r3,dph
	mov	r0,b
	mov	r1,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	dpl,r2
	mov	dph,r3
	mov	b,r0
	mov	a,r1
	lcall	___fs2sint
	mov	r2,dpl
	mov	r3,dph
	pop	ar7
	pop	ar6
	sjmp	L021003?
L021002?:
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:398: real_x = x_pos;
	mov	ar2,r4
	mov	ar3,r5
L021003?:
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:400: if(y_pos > 11796) {
	clr	c
	mov	a,#0x14
	subb	a,r6
	mov	a,#(0x2E ^ 0x80)
	mov	b,r7
	xrl	b,#0x80
	subb	a,b
	jc	L021016?
	ljmp	L021005?
L021016?:
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:401: real_y = 11796 + 11796*((y_pos-11796)/4587.0);
	mov	a,r6
	add	a,#0xec
	mov	dpl,a
	mov	a,r7
	addc	a,#0xd1
	mov	dph,a
	push	ar2
	push	ar3
	lcall	___sint2fs
	mov	r4,dpl
	mov	r5,dph
	mov	r0,b
	mov	r1,a
	clr	a
	push	acc
	mov	a,#0x58
	push	acc
	mov	a,#0x8F
	push	acc
	mov	a,#0x45
	push	acc
	mov	dpl,r4
	mov	dph,r5
	mov	b,r0
	mov	a,r1
	lcall	___fsdiv
	mov	r4,dpl
	mov	r5,dph
	mov	r0,b
	mov	r1,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	push	ar4
	push	ar5
	push	ar0
	push	ar1
	mov	dptr,#0x5000
	mov	b,#0x38
	mov	a,#0x46
	lcall	___fsmul
	mov	r4,dpl
	mov	r5,dph
	mov	r0,b
	mov	r1,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	clr	a
	push	acc
	mov	a,#0x50
	push	acc
	mov	a,#0x38
	push	acc
	mov	a,#0x46
	push	acc
	mov	dpl,r4
	mov	dph,r5
	mov	b,r0
	mov	a,r1
	lcall	___fsadd
	mov	r4,dpl
	mov	r5,dph
	mov	r0,b
	mov	r1,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	dpl,r4
	mov	dph,r5
	mov	b,r0
	mov	a,r1
	lcall	___fs2sint
	mov	r4,dpl
	mov	r5,dph
	pop	ar3
	pop	ar2
	sjmp	L021006?
L021005?:
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:405: real_y = y_pos;
	mov	ar4,r6
	mov	ar5,r7
L021006?:
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:407: int_to_stringprintx(1, real_x);
	mov	_int_to_stringprintx_PARM_2,r2
	mov	(_int_to_stringprintx_PARM_2 + 1),r3
	mov	dptr,#0x0001
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	lcall	_int_to_stringprintx
	pop	ar5
	pop	ar4
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:408: int_to_stringprinty(2, real_y);	
	mov	_int_to_stringprinty_PARM_2,r4
	mov	(_int_to_stringprinty_PARM_2 + 1),r5
	mov	dptr,#0x0002
	push	ar4
	push	ar5
	lcall	_int_to_stringprinty
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
;	C:\Users\Keega\Downloads\EFM8LB1-Project\Base Joystick + Signal.c:410: printf("x_pos: %d, y_pos: %d, button: %d\n", real_x, real_y, button);
	push	_main_button_1_107
	push	(_main_button_1_107 + 1)
	push	ar4
	push	ar5
	push	ar2
	push	ar3
	mov	a,#__str_4
	push	acc
	mov	a,#(__str_4 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	mov	a,sp
	add	a,#0xf7
	mov	sp,a
	ljmp	L021008?
	rseg R_CSEG

	rseg R_XINIT

	rseg R_CONST
__str_0:
	db 'pos x: %.2f'
	db 0x00
__str_1:
	db 'pos y: %.2f'
	db 0x00
__str_2:
	db 'x: %.1d'
	db 0x00
__str_3:
	db 'y: %.1d'
	db 0x00
__str_4:
	db 'x_pos: %d, y_pos: %d, button: %d'
	db 0x0A
	db 0x00

	CSEG

end
