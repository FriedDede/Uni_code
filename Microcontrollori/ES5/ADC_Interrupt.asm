
_main:

;ADC_Interrupt.c,23 :: 		void main() {
;ADC_Interrupt.c,25 :: 		char *adc_label_RA0 = "RA0[mV]:";
	MOVLW       ?lstr1_ADC_Interrupt+0
	MOVWF       main_adc_label_RA0_L0+0 
	MOVLW       hi_addr(?lstr1_ADC_Interrupt+0)
	MOVWF       main_adc_label_RA0_L0+1 
	MOVLW       ?lstr2_ADC_Interrupt+0
	MOVWF       main_adc_label_RA1_L0+0 
	MOVLW       hi_addr(?lstr2_ADC_Interrupt+0)
	MOVWF       main_adc_label_RA1_L0+1 
;ADC_Interrupt.c,28 :: 		TRISC = 0;
	CLRF        TRISC+0 
;ADC_Interrupt.c,35 :: 		ADCON0.CHS0 = 0;
	BCF         ADCON0+0, 2 
;ADC_Interrupt.c,36 :: 		ADCON0.CHS1 = 0;
	BCF         ADCON0+0, 3 
;ADC_Interrupt.c,37 :: 		ADCON0.CHS2 = 0;
	BCF         ADCON0+0, 4 
;ADC_Interrupt.c,38 :: 		ADCON0.CHS3 = 0;
	BCF         ADCON0+0, 5 
;ADC_Interrupt.c,39 :: 		ADCON0.CHS4 = 0;
	BCF         ADCON0+0, 6 
;ADC_Interrupt.c,55 :: 		ADCON2.ADCS0 = 1;
	BSF         ADCON2+0, 0 
;ADC_Interrupt.c,56 :: 		ADCON2.ADCS1 = 0;
	BCF         ADCON2+0, 1 
;ADC_Interrupt.c,57 :: 		ADCON2.ADCS2 = 0;
	BCF         ADCON2+0, 2 
;ADC_Interrupt.c,65 :: 		ADCON2.ACQT0 = 0;
	BCF         ADCON2+0, 3 
;ADC_Interrupt.c,66 :: 		ADCON2.ACQT1 = 0;
	BCF         ADCON2+0, 4 
;ADC_Interrupt.c,67 :: 		ADCON2.ACQT2 = 1;
	BSF         ADCON2+0, 5 
;ADC_Interrupt.c,70 :: 		ADCON2.ADFM = 0;
	BCF         ADCON2+0, 7 
;ADC_Interrupt.c,73 :: 		ADCON0.ADON = 1;
	BSF         ADCON0+0, 0 
;ADC_Interrupt.c,90 :: 		PIE1.ADIE = 1;
	BSF         PIE1+0, 6 
;ADC_Interrupt.c,91 :: 		PIR1.ADIF = 0;
	BCF         PIR1+0, 6 
;ADC_Interrupt.c,93 :: 		INTCON.PEIE = 1;
	BSF         INTCON+0, 6 
;ADC_Interrupt.c,95 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;ADC_Interrupt.c,98 :: 		ADCON0.GO_NOT_DONE = 1;
	BSF         ADCON0+0, 1 
;ADC_Interrupt.c,101 :: 		Lcd_Init();
	CALL        _Lcd_Init+0, 0
;ADC_Interrupt.c,102 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;ADC_Interrupt.c,103 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;ADC_Interrupt.c,105 :: 		Lcd_Out(1,1,adc_label_RA0);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        main_adc_label_RA0_L0+0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVF        main_adc_label_RA0_L0+1, 0 
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;ADC_Interrupt.c,106 :: 		Lcd_Out(2,1,adc_label_RA1);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        main_adc_label_RA1_L0+0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVF        main_adc_label_RA1_L0+1, 0 
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;ADC_Interrupt.c,107 :: 		while (1)
L_main0:
;ADC_Interrupt.c,109 :: 		if (adc_ra0 != adc_prev_ra0)
	MOVF        _adc_ra0+1, 0 
	XORWF       _adc_prev_ra0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main8
	MOVF        _adc_prev_ra0+0, 0 
	XORWF       _adc_ra0+0, 0 
L__main8:
	BTFSC       STATUS+0, 2 
	GOTO        L_main2
;ADC_Interrupt.c,112 :: 		LATC = adc_ra0;
	MOVF        _adc_ra0+0, 0 
	MOVWF       LATC+0 
;ADC_Interrupt.c,113 :: 		InttoStr(adc_ra0,adc_lcd);
	MOVF        _adc_ra0+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _adc_ra0+1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       main_adc_lcd_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(main_adc_lcd_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;ADC_Interrupt.c,114 :: 		Lcd_Out(1,11,adc_lcd);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       11
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       main_adc_lcd_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(main_adc_lcd_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;ADC_Interrupt.c,115 :: 		}
L_main2:
;ADC_Interrupt.c,116 :: 		if (adc_ra1 != adc_prev_ra1)
	MOVF        _adc_ra1+1, 0 
	XORWF       _adc_prev_ra1+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main9
	MOVF        _adc_prev_ra1+0, 0 
	XORWF       _adc_ra1+0, 0 
L__main9:
	BTFSC       STATUS+0, 2 
	GOTO        L_main3
;ADC_Interrupt.c,118 :: 		InttoStr(adc_ra1,adc_lcd);
	MOVF        _adc_ra1+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _adc_ra1+1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       main_adc_lcd_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(main_adc_lcd_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;ADC_Interrupt.c,119 :: 		Lcd_Out(2,11,adc_lcd);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       11
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       main_adc_lcd_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(main_adc_lcd_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;ADC_Interrupt.c,120 :: 		}
L_main3:
;ADC_Interrupt.c,121 :: 		}
	GOTO        L_main0
;ADC_Interrupt.c,123 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_interrupt:

;ADC_Interrupt.c,126 :: 		void interrupt(){
;ADC_Interrupt.c,128 :: 		if (PIR1.ADIF)
	BTFSS       PIR1+0, 6 
	GOTO        L_interrupt4
;ADC_Interrupt.c,130 :: 		if (ADCON0.CHS0 == 0)
	BTFSC       ADCON0+0, 2 
	GOTO        L_interrupt5
;ADC_Interrupt.c,132 :: 		adc_prev_ra0 = adc_ra0;
	MOVF        _adc_ra0+0, 0 
	MOVWF       _adc_prev_ra0+0 
	MOVF        _adc_ra0+1, 0 
	MOVWF       _adc_prev_ra0+1 
;ADC_Interrupt.c,133 :: 		adc_ra0 = ((ADRESH << 2) + (ADRESL >> 6))*5;
	MOVF        ADRESH+0, 0 
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
	RLCF        R2, 1 
	BCF         R2, 0 
	RLCF        R3, 1 
	RLCF        R2, 1 
	BCF         R2, 0 
	RLCF        R3, 1 
	MOVLW       6
	MOVWF       R1 
	MOVF        ADRESL+0, 0 
	MOVWF       R0 
	MOVF        R1, 0 
L__interrupt12:
	BZ          L__interrupt13
	RRCF        R0, 1 
	BCF         R0, 7 
	ADDLW       255
	GOTO        L__interrupt12
L__interrupt13:
	MOVLW       0
	MOVWF       R1 
	MOVF        R2, 0 
	ADDWF       R0, 1 
	MOVF        R3, 0 
	ADDWFC      R1, 1 
	MOVLW       5
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       _adc_ra0+0 
	MOVF        R1, 0 
	MOVWF       _adc_ra0+1 
;ADC_Interrupt.c,134 :: 		ADCON0.GO_NOT_DONE = 1;
	BSF         ADCON0+0, 1 
;ADC_Interrupt.c,135 :: 		ADCON0.CHS0 = 1;
	BSF         ADCON0+0, 2 
;ADC_Interrupt.c,136 :: 		}
	GOTO        L_interrupt6
L_interrupt5:
;ADC_Interrupt.c,138 :: 		adc_prev_ra1 = adc_ra1;
	MOVF        _adc_ra1+0, 0 
	MOVWF       _adc_prev_ra1+0 
	MOVF        _adc_ra1+1, 0 
	MOVWF       _adc_prev_ra1+1 
;ADC_Interrupt.c,139 :: 		adc_ra1 = (ADRESH)*(5000/256);
	MOVF        ADRESH+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       19
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       _adc_ra1+0 
	MOVF        R1, 0 
	MOVWF       _adc_ra1+1 
;ADC_Interrupt.c,140 :: 		ADCON0.GO_NOT_DONE = 1;
	BSF         ADCON0+0, 1 
;ADC_Interrupt.c,141 :: 		ADCON0.CHS0 = 0;
	BCF         ADCON0+0, 2 
;ADC_Interrupt.c,142 :: 		}
L_interrupt6:
;ADC_Interrupt.c,143 :: 		PIR1.ADIF = 0;
	BCF         PIR1+0, 6 
;ADC_Interrupt.c,144 :: 		}
L_interrupt4:
;ADC_Interrupt.c,147 :: 		}
L_end_interrupt:
L__interrupt11:
	RETFIE      1
; end of _interrupt
