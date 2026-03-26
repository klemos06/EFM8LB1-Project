;--------------------------------------------------------
; File Created by C51
; Version 1.0.0 #1170 (Feb 16 2022) (MSVC)
; This file was generated Wed Mar 25 22:37:36 2026
;--------------------------------------------------------
$name WIP_IRCOMMS
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
	public _transmit_byte
	public _end_transmit
	public _start_transmit
	public _PCA_ISR
	public _fourteen_to_eight
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
	public __c51_external_startup
	public _LCDprint_PARM_3
	public _int_to_stringprinty_PARM_2
	public _int_to_stringprintx_PARM_2
	public _float_to_stringprinty_PARM_2
	public _float_to_stringprintx_PARM_2
	public _LCDprint_PARM_2
	public _bit_count
	public _ir_send
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
_ir_send:
	ds 2
_bit_count:
	ds 2
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
_main_button_1_128:
	ds 2
_main_real_x_1_128:
	ds 2
_main_eight_bitx_1_128:
	ds 1
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
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:42: int ir_send = 0; // this indicates if we need the ir to be on or off 
	clr	a
	mov	_ir_send,a
	mov	(_ir_send + 1),a
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:43: int bit_count = 8; // max number of bits in the buffer
	mov	_bit_count,#0x08
	clr	a
	mov	(_bit_count + 1),a
	; The linker places a 'ret' at the end of segment R_DINIT.
;--------------------------------------------------------
; code
;--------------------------------------------------------
	rseg R_CSEG
;------------------------------------------------------------
;Allocation info for local variables in function '_c51_external_startup'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:46: char _c51_external_startup (void)
;	-----------------------------------------
;	 function _c51_external_startup
;	-----------------------------------------
__c51_external_startup:
	using	0
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:49: SFRPAGE = 0x00;
	mov	_SFRPAGE,#0x00
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:50: WDTCN = 0xDE; //First key
	mov	_WDTCN,#0xDE
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:51: WDTCN = 0xAD; //Second key
	mov	_WDTCN,#0xAD
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:53: VDM0CN |= 0x80;
	orl	_VDM0CN,#0x80
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:54: RSTSRC = 0x02;
	mov	_RSTSRC,#0x02
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:61: SFRPAGE = 0x10;
	mov	_SFRPAGE,#0x10
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:62: PFE0CN  = 0x20; // SYSCLK < 75 MHz.
	mov	_PFE0CN,#0x20
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:63: SFRPAGE = 0x00;
	mov	_SFRPAGE,#0x00
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:84: CLKSEL = 0x00;
	mov	_CLKSEL,#0x00
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:85: CLKSEL = 0x00;
	mov	_CLKSEL,#0x00
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:86: while ((CLKSEL & 0x80) == 0);
L002001?:
	mov	a,_CLKSEL
	jnb	acc.7,L002001?
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:87: CLKSEL = 0x03;
	mov	_CLKSEL,#0x03
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:88: CLKSEL = 0x03;
	mov	_CLKSEL,#0x03
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:89: while ((CLKSEL & 0x80) == 0);
L002004?:
	mov	a,_CLKSEL
	jnb	acc.7,L002004?
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:95: P0MDOUT |= 0b10000000;
	orl	_P0MDOUT,#0x80
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:96: P1MDOUT|=0b_1111_1111;
	mov	a,_P1MDOUT
	mov	_P1MDOUT,#0xFF
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:97: P2MDOUT|=0b_0000_0001;
	orl	_P2MDOUT,#0x01
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:99: XBR0     = 0x01; // Enable UART0 on P0.4(TX) and P0.5(RX)                     
	mov	_XBR0,#0x01
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:100: XBR1     = 0X00;
	mov	_XBR1,#0x00
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:101: XBR2     = 0x40; // Enable crossbar and weak pull-ups
	mov	_XBR2,#0x40
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:107: SCON0 = 0x10;
	mov	_SCON0,#0x10
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:108: CKCON0 |= 0b_0000_0000 ; // Timer 1 uses the system clock divided by 12.
	mov	_CKCON0,_CKCON0
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:109: TH1 = 0x100-((SYSCLK/BAUDRATE)/(2L*12L));
	mov	_TH1,#0xE6
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:110: TL1 = TH1;      // Init Timer1
	mov	_TL1,_TH1
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:111: TMOD &= ~0xf0;  // TMOD: timer 1 in 8-bit auto-reload
	anl	_TMOD,#0x0F
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:112: TMOD |=  0x20;                       
	orl	_TMOD,#0x20
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:113: TR1 = 1; // START Timer1
	setb	_TR1
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:114: TI = 1;  // Indicate TX0 ready
	setb	_TI
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:117: SFRPAGE=0x0;
	mov	_SFRPAGE,#0x00
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:118: PCA0MD=0x00; // Disable and clear everything in the PCA
	mov	_PCA0MD,#0x00
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:119: PCA0L=0; // Initialize the PCA counter to zero
	mov	_PCA0L,#0x00
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:120: PCA0H=0;
	mov	_PCA0H,#0x00
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:121: PCA0MD=0b_0000_1000; // Configure PCA.  System CLK is the frequency input for the PCA
	mov	_PCA0MD,#0x08
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:123: PCA0CPM0=0b_0100_1001; // ECOM|MAT|ECCF;
	mov	_PCA0CPM0,#0x49
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:125: PCA0CPL0=(SYSCLK/(2*PCA_0_FREQ))%0x100; //Always write low byte first!
	mov	_PCA0CPL0,#0xB3
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:126: PCA0CPH0=(SYSCLK/(2*PCA_0_FREQ))/0x100;
	mov	_PCA0CPH0,#0x03
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:128: CR=1; // Enable PCA counter
	setb	_CR
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:129: EIE1|=0b_0001_0000; // Enable PCA interrupts
	orl	_EIE1,#0x10
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:131: EA=1; // Enable interrupts
	setb	_EA
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:133: return 0;
	mov	dpl,#0x00
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'InitADC'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:136: void InitADC (void)
;	-----------------------------------------
;	 function InitADC
;	-----------------------------------------
_InitADC:
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:138: SFRPAGE = 0x00;
	mov	_SFRPAGE,#0x00
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:139: ADEN=0; // Disable ADC
	clr	_ADEN
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:144: (0x0 << 0) ; // Accumulate n conversions: 0x0: 1, 0x1:4, 0x2:8, 0x3:16, 0x4:32
	mov	_ADC0CN1,#0x80
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:148: (0x0 << 2); // 0:SYSCLK ADCCLK = SYSCLK. 1:HFOSC0 ADCCLK = HFOSC0.
	mov	_ADC0CF0,#0x20
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:152: (0x1E << 0); // Conversion Tracking Time. Tadtk = ADTK / (Fsarclk)
	mov	_ADC0CF1,#0x1E
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:161: (0x0 << 0) ; // TEMPE. 0: Disable the Temperature Sensor. 1: Enable the Temperature Sensor.
	mov	_ADC0CN0,#0x00
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:166: (0x1F << 0); // ADPWR. Power Up Delay Time. Tpwrtime = ((4 * (ADPWR + 1)) + 2) / (Fadcclk)
	mov	_ADC0CF2,#0x3F
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:170: (0x0 << 0) ; // ADCM. 0x0: ADBUSY, 0x1: TIMER0, 0x2: TIMER2, 0x3: TIMER3, 0x4: CNVSTR, 0x5: CEX5, 0x6: TIMER4, 0x7: TIMER5, 0x8: CLU0, 0x9: CLU1, 0xA: CLU2, 0xB: CLU3
	mov	_ADC0CN2,#0x00
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:172: ADEN=1; // Enable ADC
	setb	_ADEN
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'InitPinADC'
;------------------------------------------------------------
;pin_num                   Allocated with name '_InitPinADC_PARM_2'
;portno                    Allocated to registers r2 
;mask                      Allocated to registers r3 
;------------------------------------------------------------
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:175: void InitPinADC (unsigned char portno, unsigned char pin_num)
;	-----------------------------------------
;	 function InitPinADC
;	-----------------------------------------
_InitPinADC:
	mov	r2,dpl
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:179: mask=1<<pin_num;
	mov	b,_InitPinADC_PARM_2
	inc	b
	mov	a,#0x01
	sjmp	L004013?
L004011?:
	add	a,acc
L004013?:
	djnz	b,L004011?
	mov	r3,a
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:181: SFRPAGE = 0x20;
	mov	_SFRPAGE,#0x20
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:182: switch (portno)
	cjne	r2,#0x00,L004014?
	sjmp	L004001?
L004014?:
	cjne	r2,#0x01,L004015?
	sjmp	L004002?
L004015?:
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:184: case 0:
	cjne	r2,#0x02,L004005?
	sjmp	L004003?
L004001?:
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:185: P0MDIN &= (~mask); // Set pin as analog input
	mov	a,r3
	cpl	a
	mov	r2,a
	anl	_P0MDIN,a
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:186: P0SKIP |= mask; // Skip Crossbar decoding for this pin
	mov	a,r3
	orl	_P0SKIP,a
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:187: break;
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:188: case 1:
	sjmp	L004005?
L004002?:
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:189: P1MDIN &= (~mask); // Set pin as analog input
	mov	a,r3
	cpl	a
	mov	r2,a
	anl	_P1MDIN,a
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:190: P1SKIP |= mask; // Skip Crossbar decoding for this pin
	mov	a,r3
	orl	_P1SKIP,a
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:191: break;
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:192: case 2:
	sjmp	L004005?
L004003?:
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:193: P2MDIN &= (~mask); // Set pin as analog input
	mov	a,r3
	cpl	a
	mov	r2,a
	anl	_P2MDIN,a
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:194: P2SKIP |= mask; // Skip Crossbar decoding for this pin
	mov	a,r3
	orl	_P2SKIP,a
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:198: }
L004005?:
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:199: SFRPAGE = 0x00;
	mov	_SFRPAGE,#0x00
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'ADC_at_Pin'
;------------------------------------------------------------
;pin                       Allocated to registers 
;------------------------------------------------------------
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:202: unsigned int ADC_at_Pin(unsigned char pin)
;	-----------------------------------------
;	 function ADC_at_Pin
;	-----------------------------------------
_ADC_at_Pin:
	mov	_ADC0MX,dpl
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:205: ADINT = 0;
	clr	_ADINT
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:206: ADBUSY = 1;     // Convert voltage at the pin
	setb	_ADBUSY
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:207: while (!ADINT); // Wait for conversion to complete
L005001?:
	jnb	_ADINT,L005001?
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:208: return (ADC0);
	mov	dpl,_ADC0
	mov	dph,(_ADC0 >> 8)
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Volts_at_Pin'
;------------------------------------------------------------
;pin                       Allocated to registers r2 
;------------------------------------------------------------
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:211: float Volts_at_Pin(unsigned char pin)
;	-----------------------------------------
;	 function Volts_at_Pin
;	-----------------------------------------
_Volts_at_Pin:
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:213: return ((ADC_at_Pin(pin)*VDD)/16383.0);
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
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:217: void Timer3us(unsigned char us)
;	-----------------------------------------
;	 function Timer3us
;	-----------------------------------------
_Timer3us:
	mov	r2,dpl
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:222: CKCON0|=0b_0100_0000;
	orl	_CKCON0,#0x40
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:224: TMR3RL = (-(SYSCLK)/1000000L); // Set Timer3 to overflow in 1us.
	mov	_TMR3RL,#0xB8
	mov	(_TMR3RL >> 8),#0xFF
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:225: TMR3 = TMR3RL;                 // Initialize Timer3 for first overflow
	mov	_TMR3,_TMR3RL
	mov	(_TMR3 >> 8),(_TMR3RL >> 8)
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:227: TMR3CN0 = 0x04;                 // Sart Timer3 and clear overflow flag
	mov	_TMR3CN0,#0x04
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:228: for (i = 0; i < us; i++)       // Count <us> overflows
	mov	r3,#0x00
L007004?:
	clr	c
	mov	a,r3
	subb	a,r2
	jnc	L007007?
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:230: while (!(TMR3CN0 & 0x80));  // Wait for overflow
L007001?:
	mov	a,_TMR3CN0
	jnb	acc.7,L007001?
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:231: TMR3CN0 &= ~(0x80);         // Clear overflow indicator
	anl	_TMR3CN0,#0x7F
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:228: for (i = 0; i < us; i++)       // Count <us> overflows
	inc	r3
	sjmp	L007004?
L007007?:
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:233: TMR3CN0 = 0 ;                   // Stop Timer3 and clear overflow flag
	mov	_TMR3CN0,#0x00
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'waitms'
;------------------------------------------------------------
;ms                        Allocated to registers r2 r3 
;j                         Allocated to registers r2 r3 
;------------------------------------------------------------
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:236: void waitms (unsigned int ms)
;	-----------------------------------------
;	 function waitms
;	-----------------------------------------
_waitms:
	mov	r2,dpl
	mov	r3,dph
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:239: for(j=ms; j!=0; j--)
L008001?:
	cjne	r2,#0x00,L008010?
	cjne	r3,#0x00,L008010?
	ret
L008010?:
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:241: Timer3us(249);
	mov	dpl,#0xF9
	push	ar2
	push	ar3
	lcall	_Timer3us
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:242: Timer3us(249);
	mov	dpl,#0xF9
	lcall	_Timer3us
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:243: Timer3us(249);
	mov	dpl,#0xF9
	lcall	_Timer3us
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:244: Timer3us(250);
	mov	dpl,#0xFA
	lcall	_Timer3us
	pop	ar3
	pop	ar2
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:239: for(j=ms; j!=0; j--)
	dec	r2
	cjne	r2,#0xff,L008011?
	dec	r3
L008011?:
	sjmp	L008001?
;------------------------------------------------------------
;Allocation info for local variables in function 'LCD_pulse'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:247: void LCD_pulse (void)
;	-----------------------------------------
;	 function LCD_pulse
;	-----------------------------------------
_LCD_pulse:
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:249: LCD_E=1;
	setb	_P2_0
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:250: Timer3us(40);
	mov	dpl,#0x28
	lcall	_Timer3us
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:251: LCD_E=0;
	clr	_P2_0
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'LCD_byte'
;------------------------------------------------------------
;x                         Allocated to registers r2 
;------------------------------------------------------------
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:254: void LCD_byte (unsigned char x)
;	-----------------------------------------
;	 function LCD_byte
;	-----------------------------------------
_LCD_byte:
	mov	r2,dpl
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:257: ACC=x; //Send high nible
	mov	_ACC,r2
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:258: LCD_D7=ACC_7;
	mov	c,_ACC_7
	mov	_P1_0,c
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:259: LCD_D6=ACC_6;
	mov	c,_ACC_6
	mov	_P1_1,c
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:260: LCD_D5=ACC_5;
	mov	c,_ACC_5
	mov	_P1_2,c
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:261: LCD_D4=ACC_4;
	mov	c,_ACC_4
	mov	_P1_3,c
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:262: LCD_pulse();
	push	ar2
	lcall	_LCD_pulse
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:263: Timer3us(40);
	mov	dpl,#0x28
	lcall	_Timer3us
	pop	ar2
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:264: ACC=x; //Send low nible
	mov	_ACC,r2
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:265: LCD_D7=ACC_3;
	mov	c,_ACC_3
	mov	_P1_0,c
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:266: LCD_D6=ACC_2;
	mov	c,_ACC_2
	mov	_P1_1,c
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:267: LCD_D5=ACC_1;
	mov	c,_ACC_1
	mov	_P1_2,c
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:268: LCD_D4=ACC_0;
	mov	c,_ACC_0
	mov	_P1_3,c
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:269: LCD_pulse();
	ljmp	_LCD_pulse
;------------------------------------------------------------
;Allocation info for local variables in function 'WriteData'
;------------------------------------------------------------
;x                         Allocated to registers r2 
;------------------------------------------------------------
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:273: void WriteData (unsigned char x)
;	-----------------------------------------
;	 function WriteData
;	-----------------------------------------
_WriteData:
	mov	r2,dpl
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:275: LCD_RS=1;
	setb	_P1_7
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:276: LCD_byte(x);
	mov	dpl,r2
	lcall	_LCD_byte
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:277: waitms(2);
	mov	dptr,#0x0002
	ljmp	_waitms
;------------------------------------------------------------
;Allocation info for local variables in function 'WriteCommand'
;------------------------------------------------------------
;x                         Allocated to registers r2 
;------------------------------------------------------------
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:280: void WriteCommand (unsigned char x)
;	-----------------------------------------
;	 function WriteCommand
;	-----------------------------------------
_WriteCommand:
	mov	r2,dpl
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:282: LCD_RS=0;
	clr	_P1_7
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:283: LCD_byte(x);
	mov	dpl,r2
	lcall	_LCD_byte
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:284: waitms(5);
	mov	dptr,#0x0005
	ljmp	_waitms
;------------------------------------------------------------
;Allocation info for local variables in function 'LCD_4BIT'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:287: void LCD_4BIT (void)
;	-----------------------------------------
;	 function LCD_4BIT
;	-----------------------------------------
_LCD_4BIT:
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:289: LCD_E=0; // Resting state of LCD's enable is zero
	clr	_P2_0
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:291: waitms(20);
	mov	dptr,#0x0014
	lcall	_waitms
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:293: WriteCommand(0x33);
	mov	dpl,#0x33
	lcall	_WriteCommand
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:294: WriteCommand(0x33);
	mov	dpl,#0x33
	lcall	_WriteCommand
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:295: WriteCommand(0x32); // Change to 4-bit mode
	mov	dpl,#0x32
	lcall	_WriteCommand
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:298: WriteCommand(0x28);
	mov	dpl,#0x28
	lcall	_WriteCommand
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:299: WriteCommand(0x0c);
	mov	dpl,#0x0C
	lcall	_WriteCommand
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:300: WriteCommand(0x01); // Clear screen command (takes some time)
	mov	dpl,#0x01
	lcall	_WriteCommand
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:301: waitms(20); // Wait for clear screen command to finsih.
	mov	dptr,#0x0014
	ljmp	_waitms
;------------------------------------------------------------
;Allocation info for local variables in function 'LCDprint'
;------------------------------------------------------------
;line                      Allocated with name '_LCDprint_PARM_2'
;string                    Allocated to registers r2 r3 r4 
;j                         Allocated to registers r5 r6 
;------------------------------------------------------------
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:304: void LCDprint(char * string, unsigned char line, bit clear)
;	-----------------------------------------
;	 function LCDprint
;	-----------------------------------------
_LCDprint:
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:308: WriteCommand(line==2?0xc0:0x80);
	mov	a,#0x02
	cjne	a,_LCDprint_PARM_2,L014013?
	mov	r5,#0xC0
	sjmp	L014014?
L014013?:
	mov	r5,#0x80
L014014?:
	mov	dpl,r5
	push	ar2
	push	ar3
	push	ar4
	lcall	_WriteCommand
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:309: waitms(5);
	mov	dptr,#0x0005
	lcall	_waitms
	pop	ar4
	pop	ar3
	pop	ar2
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:310: for(j=0; string[j]!=0; j++)	WriteData(string[j]);// Write the message
	mov	r5,#0x00
	mov	r6,#0x00
L014003?:
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
	jz	L014006?
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
	cjne	r5,#0x00,L014003?
	inc	r6
	sjmp	L014003?
L014006?:
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:311: if(clear) for(; j<CHARS_PER_LINE; j++) WriteData(' '); // Clear the rest of the line
	jnb	_LCDprint_PARM_3,L014011?
	mov	ar2,r5
	mov	ar3,r6
L014007?:
	clr	c
	mov	a,r2
	subb	a,#0x10
	mov	a,r3
	xrl	a,#0x80
	subb	a,#0x80
	jnc	L014011?
	mov	dpl,#0x20
	push	ar2
	push	ar3
	lcall	_WriteData
	pop	ar3
	pop	ar2
	inc	r2
	cjne	r2,#0x00,L014007?
	inc	r3
	sjmp	L014007?
L014011?:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'TIMER0_Init'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:315: void TIMER0_Init(void)
;	-----------------------------------------
;	 function TIMER0_Init
;	-----------------------------------------
_TIMER0_Init:
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:317: TMOD&=0b_1111_0000; // Set the bits of Timer/Counter 0 to zero
	anl	_TMOD,#0xF0
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:318: TMOD|=0b_0000_0001; // Timer/Counter 0 used as a 16-bit timer
	orl	_TMOD,#0x01
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:319: TR0=0; // Stop Timer/Counter 0
	clr	_TR0
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'float_to_stringprintx'
;------------------------------------------------------------
;x                         Allocated with name '_float_to_stringprintx_PARM_2'
;line                      Allocated to registers r2 r3 
;------------------------------------------------------------
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:325: void float_to_stringprintx(int line, float x)
;	-----------------------------------------
;	 function float_to_stringprintx
;	-----------------------------------------
_float_to_stringprintx:
	mov	r2,dpl
	mov	r3,dph
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:327: sprintf(buffer, "pos x: %.2f", x); // print string to buffer
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
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:328: LCDprint(buffer, line, 1); // print buffer to LCD
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
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:333: void float_to_stringprinty(int line, float x)
;	-----------------------------------------
;	 function float_to_stringprinty
;	-----------------------------------------
_float_to_stringprinty:
	mov	r2,dpl
	mov	r3,dph
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:335: sprintf(buffer, "pos y: %.2f", x); // print string to buffer
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
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:336: LCDprint(buffer, line, 1); // print buffer to LCD
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
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:340: void int_to_stringprintx(int lin, int y)
;	-----------------------------------------
;	 function int_to_stringprintx
;	-----------------------------------------
_int_to_stringprintx:
	mov	r2,dpl
	mov	r3,dph
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:342: sprintf(buffer, "x: %.1d", y); // print string to buffer
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
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:343: LCDprint(buffer, lin, 1); // print buffer to LCD
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
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:346: void int_to_stringprinty(int lin, int y)
;	-----------------------------------------
;	 function int_to_stringprinty
;	-----------------------------------------
_int_to_stringprinty:
	mov	r2,dpl
	mov	r3,dph
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:348: sprintf(buffer, "y: %.1d", y); // print string to buffer
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
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:349: LCDprint(buffer, lin, 1); // print buffer to LCD
	mov	_LCDprint_PARM_2,r2
	setb	_LCDprint_PARM_3
	mov	dptr,#_buffer
	mov	b,#0x40
	ljmp	_LCDprint
;------------------------------------------------------------
;Allocation info for local variables in function 'fourteen_to_eight'
;------------------------------------------------------------
;val                       Allocated to registers r2 r3 
;------------------------------------------------------------
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:355: int fourteen_to_eight(int val){
;	-----------------------------------------
;	 function fourteen_to_eight
;	-----------------------------------------
_fourteen_to_eight:
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:356: return ((val*255.0)/65535.0);
	lcall	___sint2fs
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	dptr,#0x0000
	mov	b,#0x7F
	mov	a,#0x43
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
	mov	a,#0xFF
	push	acc
	mov	a,#0x7F
	push	acc
	mov	a,#0x47
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
	ljmp	___fs2sint
;------------------------------------------------------------
;Allocation info for local variables in function 'PCA_ISR'
;------------------------------------------------------------
;j                         Allocated to registers r2 r3 
;------------------------------------------------------------
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:360: void PCA_ISR (void) interrupt INTERRUPT_PCA0
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
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:364: SFRPAGE=0x0;
	mov	_SFRPAGE,#0x00
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:366: if (CCF0)
	jnb	_CCF0,L021005?
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:369: j=(PCA0CPH0*0x100+PCA0CPL0)+(SYSCLK/(2L*PCA_0_FREQ));
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
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:370: PCA0CPL0=j%0x100; //Always write low byte first!
	mov	ar4,r2
	mov	r5,#0x00
	mov	_PCA0CPL0,r4
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:371: PCA0CPH0=j/0x100;
	mov	ar2,r3
	mov	r3,#0x00
	mov	_PCA0CPH0,r2
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:372: CCF0=0;
	clr	_CCF0
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:374: if (ir_send == 1){
	mov	a,#0x01
	cjne	a,_ir_send,L021011?
	clr	a
	cjne	a,(_ir_send + 1),L021011?
	sjmp	L021012?
L021011?:
	sjmp	L021002?
L021012?:
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:375: PCA_OUT_0=!PCA_OUT_0; // if the IR send is 1 --> turn on the pin 
	cpl	_P0_7
	sjmp	L021005?
L021002?:
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:379: PCA_OUT_0 = 0; // if the IR send is 0 --> turn off the pin even if the interrupt is generated 
	clr	_P0_7
L021005?:
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:382: CF=0;
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
;Allocation info for local variables in function 'start_transmit'
;------------------------------------------------------------
;start_bit                 Allocated to registers r2 r3 
;i                         Allocated to registers r2 r3 
;------------------------------------------------------------
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:387: int start_transmit (int start_bit){
;	-----------------------------------------
;	 function start_transmit
;	-----------------------------------------
_start_transmit:
	mov	r2,dpl
	mov	r3,dph
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:388: if (start_bit){
	mov	a,r2
	orl	a,r3
	jnz	L022021?
	ljmp	L022002?
L022021?:
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:391: for (i = 0;i<3;i++){ 
	mov	r2,#0x00
	mov	r3,#0x00
L022004?:
	clr	c
	mov	a,r2
	subb	a,#0x03
	mov	a,r3
	xrl	a,#0x80
	subb	a,#0x80
	jnc	L022007?
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:392: ir_send = 1;
	mov	_ir_send,#0x01
	clr	a
	mov	(_ir_send + 1),a
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:393: Timer3us(560);
	mov	dpl,#0x30
	push	ar2
	push	ar3
	lcall	_Timer3us
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:394: Timer3us(560);
	mov	dpl,#0x30
	lcall	_Timer3us
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:395: Timer3us(560);
	mov	dpl,#0x30
	lcall	_Timer3us
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:396: Timer3us(560);
	mov	dpl,#0x30
	lcall	_Timer3us
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:397: ir_send = 0;
	clr	a
	mov	_ir_send,a
	mov	(_ir_send + 1),a
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:398: Timer3us(560);
	mov	dpl,#0x30
	lcall	_Timer3us
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:399: Timer3us(560);
	mov	dpl,#0x30
	lcall	_Timer3us
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:400: Timer3us(560);
	mov	dpl,#0x30
	lcall	_Timer3us
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:401: Timer3us(560);
	mov	dpl,#0x30
	lcall	_Timer3us
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:402: Timer3us(560);
	mov	dpl,#0x30
	lcall	_Timer3us
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:403: Timer3us(560);
	mov	dpl,#0x30
	lcall	_Timer3us
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:404: Timer3us(560);
	mov	dpl,#0x30
	lcall	_Timer3us
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:405: Timer3us(560);
	mov	dpl,#0x30
	lcall	_Timer3us
	pop	ar3
	pop	ar2
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:391: for (i = 0;i<3;i++){ 
	inc	r2
	cjne	r2,#0x00,L022004?
	inc	r3
	sjmp	L022004?
L022007?:
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:408: for (i=0;i<2; i++){
	mov	r2,#0x00
	mov	r3,#0x00
L022008?:
	clr	c
	mov	a,r2
	subb	a,#0x02
	mov	a,r3
	xrl	a,#0x80
	subb	a,#0x80
	jnc	L022011?
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:409: ir_send = 1; 
	mov	_ir_send,#0x01
	clr	a
	mov	(_ir_send + 1),a
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:410: Timer3us(560);
	mov	dpl,#0x30
	push	ar2
	push	ar3
	lcall	_Timer3us
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:411: Timer3us(560);
	mov	dpl,#0x30
	lcall	_Timer3us
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:412: Timer3us(560);
	mov	dpl,#0x30
	lcall	_Timer3us
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:413: Timer3us(560);
	mov	dpl,#0x30
	lcall	_Timer3us
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:414: ir_send = 0;
	clr	a
	mov	_ir_send,a
	mov	(_ir_send + 1),a
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:415: Timer3us(560);
	mov	dpl,#0x30
	lcall	_Timer3us
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:416: Timer3us(560);
	mov	dpl,#0x30
	lcall	_Timer3us
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:417: Timer3us(560);
	mov	dpl,#0x30
	lcall	_Timer3us
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:418: Timer3us(560);
	mov	dpl,#0x30
	lcall	_Timer3us
	pop	ar3
	pop	ar2
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:408: for (i=0;i<2; i++){
	inc	r2
	cjne	r2,#0x00,L022008?
	inc	r3
	sjmp	L022008?
L022011?:
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:422: return 0; 
	mov	dptr,#0x0000
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:425: return -1;
	ret
L022002?:
	mov	dptr,#0xFFFF
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'end_transmit'
;------------------------------------------------------------
;end_bit                   Allocated to registers r2 r3 
;i                         Allocated to registers r2 r3 
;------------------------------------------------------------
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:429: int end_transmit (int end_bit){			// 10000
;	-----------------------------------------
;	 function end_transmit
;	-----------------------------------------
_end_transmit:
	mov	r2,dpl
	mov	r3,dph
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:430: if (end_bit){
	mov	a,r2
	orl	a,r3
	jnz	L023021?
	ljmp	L023002?
L023021?:
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:433: for (i = 0;i<1;i++){ 
	mov	r2,#0x00
	mov	r3,#0x00
L023004?:
	clr	c
	mov	a,r2
	subb	a,#0x01
	mov	a,r3
	xrl	a,#0x80
	subb	a,#0x80
	jnc	L023007?
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:434: ir_send = 1;
	mov	_ir_send,#0x01
	clr	a
	mov	(_ir_send + 1),a
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:435: Timer3us(560);
	mov	dpl,#0x30
	push	ar2
	push	ar3
	lcall	_Timer3us
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:436: Timer3us(560);
	mov	dpl,#0x30
	lcall	_Timer3us
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:437: Timer3us(560);
	mov	dpl,#0x30
	lcall	_Timer3us
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:438: Timer3us(560);
	mov	dpl,#0x30
	lcall	_Timer3us
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:439: ir_send = 0;
	clr	a
	mov	_ir_send,a
	mov	(_ir_send + 1),a
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:440: Timer3us(560);
	mov	dpl,#0x30
	lcall	_Timer3us
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:441: Timer3us(560);
	mov	dpl,#0x30
	lcall	_Timer3us
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:442: Timer3us(560);
	mov	dpl,#0x30
	lcall	_Timer3us
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:443: Timer3us(560);
	mov	dpl,#0x30
	lcall	_Timer3us
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:444: Timer3us(560);
	mov	dpl,#0x30
	lcall	_Timer3us
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:445: Timer3us(560);
	mov	dpl,#0x30
	lcall	_Timer3us
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:446: Timer3us(560);
	mov	dpl,#0x30
	lcall	_Timer3us
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:447: Timer3us(560);
	mov	dpl,#0x30
	lcall	_Timer3us
	pop	ar3
	pop	ar2
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:433: for (i = 0;i<1;i++){ 
	inc	r2
	cjne	r2,#0x00,L023004?
	inc	r3
	sjmp	L023004?
L023007?:
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:450: for (i=0;i<4; i++){
	mov	r2,#0x00
	mov	r3,#0x00
L023008?:
	clr	c
	mov	a,r2
	subb	a,#0x04
	mov	a,r3
	xrl	a,#0x80
	subb	a,#0x80
	jnc	L023011?
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:451: ir_send = 1; 
	mov	_ir_send,#0x01
	clr	a
	mov	(_ir_send + 1),a
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:452: Timer3us(560);
	mov	dpl,#0x30
	push	ar2
	push	ar3
	lcall	_Timer3us
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:453: Timer3us(560);
	mov	dpl,#0x30
	lcall	_Timer3us
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:454: Timer3us(560);
	mov	dpl,#0x30
	lcall	_Timer3us
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:455: Timer3us(560);
	mov	dpl,#0x30
	lcall	_Timer3us
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:456: ir_send = 0;
	clr	a
	mov	_ir_send,a
	mov	(_ir_send + 1),a
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:457: Timer3us(560);
	mov	dpl,#0x30
	lcall	_Timer3us
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:458: Timer3us(560);
	mov	dpl,#0x30
	lcall	_Timer3us
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:459: Timer3us(560);
	mov	dpl,#0x30
	lcall	_Timer3us
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:460: Timer3us(560);
	mov	dpl,#0x30
	lcall	_Timer3us
	pop	ar3
	pop	ar2
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:450: for (i=0;i<4; i++){
	inc	r2
	cjne	r2,#0x00,L023008?
	inc	r3
	sjmp	L023008?
L023011?:
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:463: return 0; 
	mov	dptr,#0x0000
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:466: return -1;
	ret
L023002?:
	mov	dptr,#0xFFFF
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'transmit_byte'
;------------------------------------------------------------
;input                     Allocated to registers r2 
;i                         Allocated to registers r3 r4 
;------------------------------------------------------------
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:471: void transmit_byte(uint8_t input){
;	-----------------------------------------
;	 function transmit_byte
;	-----------------------------------------
_transmit_byte:
	mov	r2,dpl
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:474: for (i = 7; i >= 0; i--){
	mov	r3,#0x07
	mov	r4,#0x00
L024004?:
	mov	a,r4
	jnb	acc.7,L024014?
	ret
L024014?:
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:475: if ((input >> i) & 1) {			// this shifts the first bit to the right and ands it with 1 --> if this is one, this means the bit is supposed to be a one  
	mov	b,r3
	inc	b
	mov	a,r2
	sjmp	L024016?
L024015?:
	clr	c
	rrc	a
L024016?:
	djnz	b,L024015?
	jnb	acc.0,L024002?
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:476: ir_send = 1; 
	mov	_ir_send,#0x01
	clr	a
	mov	(_ir_send + 1),a
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:477: Timer3us(560);
	mov	dpl,#0x30
	push	ar2
	push	ar3
	push	ar4
	lcall	_Timer3us
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:478: Timer3us(560);
	mov	dpl,#0x30
	lcall	_Timer3us
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:479: Timer3us(560);				// 2240 us high
	mov	dpl,#0x30
	lcall	_Timer3us
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:480: Timer3us(560);
	mov	dpl,#0x30
	lcall	_Timer3us
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:481: ir_send = 0; 
	clr	a
	mov	_ir_send,a
	mov	(_ir_send + 1),a
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:482: Timer3us(560);				// 4480 us low 
	mov	dpl,#0x30
	lcall	_Timer3us
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:483: Timer3us(560);
	mov	dpl,#0x30
	lcall	_Timer3us
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:484: Timer3us(560);
	mov	dpl,#0x30
	lcall	_Timer3us
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:485: Timer3us(560);
	mov	dpl,#0x30
	lcall	_Timer3us
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:486: Timer3us(560);
	mov	dpl,#0x30
	lcall	_Timer3us
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:487: Timer3us(560);
	mov	dpl,#0x30
	lcall	_Timer3us
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:488: Timer3us(560);
	mov	dpl,#0x30
	lcall	_Timer3us
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:489: Timer3us(560);
	mov	dpl,#0x30
	lcall	_Timer3us
	pop	ar4
	pop	ar3
	pop	ar2
	sjmp	L024006?
L024002?:
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:493: ir_send = 1; 
	mov	_ir_send,#0x01
	clr	a
	mov	(_ir_send + 1),a
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:494: Timer3us(560);			// 2240 us high and low 
	mov	dpl,#0x30
	push	ar2
	push	ar3
	push	ar4
	lcall	_Timer3us
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:495: Timer3us(560);
	mov	dpl,#0x30
	lcall	_Timer3us
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:496: Timer3us(560);
	mov	dpl,#0x30
	lcall	_Timer3us
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:497: Timer3us(560);
	mov	dpl,#0x30
	lcall	_Timer3us
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:498: ir_send = 0; 
	clr	a
	mov	_ir_send,a
	mov	(_ir_send + 1),a
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:499: Timer3us(560);
	mov	dpl,#0x30
	lcall	_Timer3us
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:500: Timer3us(560);
	mov	dpl,#0x30
	lcall	_Timer3us
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:501: Timer3us(560);
	mov	dpl,#0x30
	lcall	_Timer3us
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:502: Timer3us(560);
	mov	dpl,#0x30
	lcall	_Timer3us
	pop	ar4
	pop	ar3
	pop	ar2
L024006?:
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:474: for (i = 7; i >= 0; i--){
	dec	r3
	cjne	r3,#0xff,L024018?
	dec	r4
L024018?:
	ljmp	L024004?
;------------------------------------------------------------
;Allocation info for local variables in function 'main'
;------------------------------------------------------------
;button                    Allocated with name '_main_button_1_128'
;x_pos                     Allocated to registers r4 r5 
;y_pos                     Allocated to registers r6 r7 
;real_x                    Allocated with name '_main_real_x_1_128'
;real_y                    Allocated to registers r2 r3 
;eight_bitx                Allocated with name '_main_eight_bitx_1_128'
;eight_bity                Allocated to registers r1 
;end_sequence              Allocated to registers 
;------------------------------------------------------------
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:509: void main (void) 
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:518: TIMER0_Init(); // Initialize timer 0
	lcall	_TIMER0_Init
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:519: LCD_4BIT(); // Configure LCD in 4 bit mode
	lcall	_LCD_4BIT
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:520: InitADC(); // Initialize the ADC
	lcall	_InitADC
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:521: InitPinADC(2,2); // Initialize pin 2.5 as analog
	mov	_InitPinADC_PARM_2,#0x02
	mov	dpl,#0x02
	lcall	_InitPinADC
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:522: InitPinADC(2,3); // Initialize pin 2.6 as analog
	mov	_InitPinADC_PARM_2,#0x03
	mov	dpl,#0x02
	lcall	_InitPinADC
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:525: while(1) {
L025008?:
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:527: button = but_read;
	mov	c,_P2_4
	clr	a
	rlc	a
	mov	_main_button_1_128,a
	mov	(_main_button_1_128 + 1),#0x00
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:531: x_pos = ADC_at_Pin(QFP32_MUX_P2_3);
	mov	dpl,#0x10
	lcall	_ADC_at_Pin
	mov	r4,dpl
	mov	r5,dph
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:532: y_pos = ADC_at_Pin(QFP32_MUX_P2_2);
	mov	dpl,#0x0F
	push	ar4
	push	ar5
	lcall	_ADC_at_Pin
	mov	r6,dpl
	mov	r7,dph
	pop	ar5
	pop	ar4
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:534: if(x_pos > 11730) {
	clr	c
	mov	a,#0xD2
	subb	a,r4
	mov	a,#(0x2D ^ 0x80)
	mov	b,r5
	xrl	b,#0x80
	subb	a,b
	jc	L025015?
	ljmp	L025002?
L025015?:
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:535: real_x =  11730 + 11730*((x_pos-11730)/4653.0);
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
	mov	_main_real_x_1_128,dpl
	mov	(_main_real_x_1_128 + 1),dph
	pop	ar7
	pop	ar6
	sjmp	L025003?
L025002?:
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:539: real_x = x_pos;
	mov	_main_real_x_1_128,r4
	mov	(_main_real_x_1_128 + 1),r5
L025003?:
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:541: if(y_pos > 11796) {
	clr	c
	mov	a,#0x14
	subb	a,r6
	mov	a,#(0x2E ^ 0x80)
	mov	b,r7
	xrl	b,#0x80
	subb	a,b
	jc	L025016?
	ljmp	L025005?
L025016?:
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:542: real_y = 11796 + 11796*((y_pos-11796)/4587.0);
	mov	a,r6
	add	a,#0xec
	mov	dpl,a
	mov	a,r7
	addc	a,#0xd1
	mov	dph,a
	lcall	___sint2fs
	mov	r0,dpl
	mov	r1,dph
	mov	r2,b
	mov	r3,a
	clr	a
	push	acc
	mov	a,#0x58
	push	acc
	mov	a,#0x8F
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
	mov	dptr,#0x5000
	mov	b,#0x38
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
	mov	a,#0x50
	push	acc
	mov	a,#0x38
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
	sjmp	L025006?
L025005?:
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:546: real_y = y_pos;
	mov	ar2,r6
	mov	ar3,r7
L025006?:
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:571: eight_bitx = fourteen_to_eight(real_x);
	mov	dpl,_main_real_x_1_128
	mov	dph,(_main_real_x_1_128 + 1)
	push	ar2
	push	ar3
	lcall	_fourteen_to_eight
	mov	r0,dpl
	pop	ar3
	pop	ar2
	mov	_main_eight_bitx_1_128,r0
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:572: eight_bity = fourteen_to_eight(real_y);
	mov	dpl,r2
	mov	dph,r3
	push	ar2
	push	ar3
	lcall	_fourteen_to_eight
	mov	r1,dpl
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:606: start_transmit(1);
	mov	dptr,#0x0001
	push	ar1
	lcall	_start_transmit
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:607: transmit_byte(eight_bitx);
	mov	dpl,_main_eight_bitx_1_128
	lcall	_transmit_byte
	pop	ar1
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:608: transmit_byte(eight_bity);
	mov	dpl,r1
	lcall	_transmit_byte
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:609: end_transmit(1);
	mov	dptr,#0x0001
	lcall	_end_transmit
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:613: ir_send =1;
	mov	_ir_send,#0x01
	clr	a
	mov	(_ir_send + 1),a
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:614: Timer3us(560);
	mov	dpl,#0x30
	lcall	_Timer3us
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:615: Timer3us(560);
	mov	dpl,#0x30
	lcall	_Timer3us
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:616: Timer3us(560);				
	mov	dpl,#0x30
	lcall	_Timer3us
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:617: Timer3us(560);
	mov	dpl,#0x30
	lcall	_Timer3us
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:618: Timer3us(560);
	mov	dpl,#0x30
	lcall	_Timer3us
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:619: Timer3us(560);
	mov	dpl,#0x30
	lcall	_Timer3us
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:620: Timer3us(560);
	mov	dpl,#0x30
	lcall	_Timer3us
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:621: Timer3us(560);
	mov	dpl,#0x30
	lcall	_Timer3us
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:622: Timer3us(560);
	mov	dpl,#0x30
	lcall	_Timer3us
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:623: Timer3us(560);
	mov	dpl,#0x30
	lcall	_Timer3us
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:624: ir_send = 0; 
	clr	a
	mov	_ir_send,a
	mov	(_ir_send + 1),a
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:626: waitms(100); 
	mov	dptr,#0x0064
	lcall	_waitms
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:628: int_to_stringprintx(1, real_x);
	mov	_int_to_stringprintx_PARM_2,_main_real_x_1_128
	mov	(_int_to_stringprintx_PARM_2 + 1),(_main_real_x_1_128 + 1)
	mov	dptr,#0x0001
	lcall	_int_to_stringprintx
	pop	ar3
	pop	ar2
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:629: int_to_stringprinty(2, real_y);	
	mov	_int_to_stringprinty_PARM_2,r2
	mov	(_int_to_stringprinty_PARM_2 + 1),r3
	mov	dptr,#0x0002
	push	ar2
	push	ar3
	lcall	_int_to_stringprinty
	pop	ar3
	pop	ar2
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:631: printf("x_pos: %d, y_pos: %d, button: %d\n", real_x, real_y, button);
	push	_main_button_1_128
	push	(_main_button_1_128 + 1)
	push	ar2
	push	ar3
	push	_main_real_x_1_128
	push	(_main_real_x_1_128 + 1)
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
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:637: x_pos = Volts_at_Pin(QFP32_MUX_P2_6);
	mov	dpl,#0x13
	lcall	_Volts_at_Pin
	lcall	___fs2sint
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:638: float_to_stringprintx(1, x_pos);
	lcall	___sint2fs
	mov	_float_to_stringprintx_PARM_2,dpl
	mov	(_float_to_stringprintx_PARM_2 + 1),dph
	mov	(_float_to_stringprintx_PARM_2 + 2),b
	mov	(_float_to_stringprintx_PARM_2 + 3),a
	mov	dptr,#0x0001
	lcall	_float_to_stringprintx
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:640: y_pos = Volts_at_Pin(QFP32_MUX_P2_5);
	mov	dpl,#0x12
	lcall	_Volts_at_Pin
	lcall	___fs2sint
;	C:\ELEC 291\EFM8LB1-Project\WIP_IRCOMMS.c:641: float_to_stringprinty(2, y_pos);
	lcall	___sint2fs
	mov	_float_to_stringprinty_PARM_2,dpl
	mov	(_float_to_stringprinty_PARM_2 + 1),dph
	mov	(_float_to_stringprinty_PARM_2 + 2),b
	mov	(_float_to_stringprinty_PARM_2 + 3),a
	mov	dptr,#0x0002
	lcall	_float_to_stringprinty
	ljmp	L025008?
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
