
_main:

;PWM.c,19 :: 		void main() {
;PWM.c,21 :: 		char *adc_label_RA0 = "RA0:";
	MOVLW       ?lstr1_PWM+0
	MOVWF       main_adc_label_RA0_L0+0 
	MOVLW       hi_addr(?lstr1_PWM+0)
	MOVWF       main_adc_label_RA0_L0+1 
;PWM.c,24 :: 		TRISC = 0;
	CLRF        TRISC+0 
;PWM.c,25 :: 		ADCON0 = 0b00000000;
	CLRF        ADCON0+0 
;PWM.c,26 :: 		ADCON2.ADCS0 = 1;
	BSF         ADCON2+0, 0 
;PWM.c,27 :: 		ADCON2.ADCS1 = 0;
	BCF         ADCON2+0, 1 
;PWM.c,28 :: 		ADCON2.ADCS2 = 0;
	BCF         ADCON2+0, 2 
;PWM.c,29 :: 		ADCON2.ACQT0 = 0;
	BCF         ADCON2+0, 3 
;PWM.c,30 :: 		ADCON2.ACQT1 = 0;
	BCF         ADCON2+0, 4 
;PWM.c,31 :: 		ADCON2.ACQT2 = 1;
	BSF         ADCON2+0, 5 
;PWM.c,32 :: 		ADCON2.ADFM = 0;
	BCF         ADCON2+0, 7 
;PWM.c,33 :: 		ADCON0.ADON = 1;
	BSF         ADCON0+0, 0 
;PWM.c,34 :: 		PIE1.ADIE = 1;
	BSF         PIE1+0, 6 
;PWM.c,35 :: 		PIR1.ADIF = 0;
	BCF         PIR1+0, 6 
;PWM.c,36 :: 		INTCON.PEIE = 1;
	BSF         INTCON+0, 6 
;PWM.c,37 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;PWM.c,38 :: 		ADCON0.GO_NOT_DONE = 1;
	BSF         ADCON0+0, 1 
;PWM.c,44 :: 		TRISE.RE2 = 1;
	BSF         TRISE+0, 2 
;PWM.c,46 :: 		CCPTMRS1.C5TSEL1 = 0;
	BCF         CCPTMRS1+0, 3 
;PWM.c,47 :: 		CCPTMRS1.C5TSEL0 = 1;
	BSF         CCPTMRS1+0, 2 
;PWM.c,49 :: 		PR4 = 255;
	MOVLW       255
	MOVWF       PR4+0 
;PWM.c,53 :: 		CCP5CON = 0b00001100;
	MOVLW       12
	MOVWF       CCP5CON+0 
;PWM.c,58 :: 		CCPR5L = 0;
	CLRF        CCPR5L+0 
;PWM.c,62 :: 		T4CON = 0b00000111;
	MOVLW       7
	MOVWF       T4CON+0 
;PWM.c,64 :: 		TRISE.RE2 = 0;
	BCF         TRISE+0, 2 
;PWM.c,67 :: 		Lcd_Init();
	CALL        _Lcd_Init+0, 0
;PWM.c,68 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;PWM.c,69 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;PWM.c,70 :: 		Lcd_Out(1,1,adc_label_RA0);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        main_adc_label_RA0_L0+0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVF        main_adc_label_RA0_L0+1, 0 
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;PWM.c,71 :: 		while(1){
L_main0:
;PWM.c,72 :: 		if (CCPR5L != adc_prev_ra0)
	MOVLW       0
	XORWF       _adc_prev_ra0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main5
	MOVF        _adc_prev_ra0+0, 0 
	XORWF       CCPR5L+0, 0 
L__main5:
	BTFSC       STATUS+0, 2 
	GOTO        L_main2
;PWM.c,74 :: 		LATC = CCPR5L;
	MOVF        CCPR5L+0, 0 
	MOVWF       LATC+0 
;PWM.c,75 :: 		InttoStr(CCPR5L,adc_lcd);
	MOVF        CCPR5L+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVLW       0
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       main_adc_lcd_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(main_adc_lcd_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;PWM.c,76 :: 		Lcd_Out(1,11,adc_lcd);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       11
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       main_adc_lcd_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(main_adc_lcd_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;PWM.c,77 :: 		}
L_main2:
;PWM.c,78 :: 		}
	GOTO        L_main0
;PWM.c,79 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_interrupt:

;PWM.c,81 :: 		void interrupt(){
;PWM.c,82 :: 		if (PIR1.ADIF)
	BTFSS       PIR1+0, 6 
	GOTO        L_interrupt3
;PWM.c,84 :: 		adc_prev_ra0 = CCPR5L;
	MOVF        CCPR5L+0, 0 
	MOVWF       _adc_prev_ra0+0 
	MOVLW       0
	MOVWF       _adc_prev_ra0+1 
;PWM.c,85 :: 		CCPR5L = ADRESH;
	MOVF        ADRESH+0, 0 
	MOVWF       CCPR5L+0 
;PWM.c,86 :: 		ADCON0.GO_NOT_DONE = 1;
	BSF         ADCON0+0, 1 
;PWM.c,87 :: 		PIR1.ADIF = 0;
	BCF         PIR1+0, 6 
;PWM.c,88 :: 		}
L_interrupt3:
;PWM.c,89 :: 		}
L_end_interrupt:
L__interrupt7:
	RETFIE      1
; end of _interrupt
