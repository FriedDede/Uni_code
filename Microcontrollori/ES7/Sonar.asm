
_main:

;Sonar.c,22 :: 		void main() {
;Sonar.c,24 :: 		char *adc_label_sonar = "ADC:";
	MOVLW       ?lstr1_Sonar+0
	MOVWF       main_adc_label_sonar_L0+0 
	MOVLW       hi_addr(?lstr1_Sonar+0)
	MOVWF       main_adc_label_sonar_L0+1 
	MOVLW       ?lstr2_Sonar+0
	MOVWF       main_ccp_label_sonar_L0+0 
	MOVLW       hi_addr(?lstr2_Sonar+0)
	MOVWF       main_ccp_label_sonar_L0+1 
;Sonar.c,29 :: 		ADCON0 = 0b00111101;
	MOVLW       61
	MOVWF       ADCON0+0 
;Sonar.c,30 :: 		ADCON1 = 0;
	CLRF        ADCON1+0 
;Sonar.c,32 :: 		ADCON2.ADFM = 0;
	BCF         ADCON2+0, 7 
;Sonar.c,33 :: 		ADCON2.ADCS0 = 1;
	BSF         ADCON2+0, 0 
;Sonar.c,34 :: 		ADCON2.ADCS1 = 0;
	BCF         ADCON2+0, 1 
;Sonar.c,35 :: 		ADCON2.ADCS2 = 0;
	BCF         ADCON2+0, 2 
;Sonar.c,36 :: 		ADCON2.ACQT0 = 0;
	BCF         ADCON2+0, 3 
;Sonar.c,37 :: 		ADCON2.ACQT1 = 0;
	BCF         ADCON2+0, 4 
;Sonar.c,38 :: 		ADCON2.ACQT2 = 1;
	BSF         ADCON2+0, 5 
;Sonar.c,40 :: 		CCP1CON.CCP1M3 = 0;
	BCF         CCP1CON+0, 3 
;Sonar.c,41 :: 		CCP1CON.CCP1M2 = 1;
	BSF         CCP1CON+0, 2 
;Sonar.c,42 :: 		CCP1CON.CCP1M1 = 0;
	BCF         CCP1CON+0, 1 
;Sonar.c,43 :: 		CCP1CON.CCP1M0 = 1;
	BSF         CCP1CON+0, 0 
;Sonar.c,45 :: 		T1CON = 0b01110011;
	MOVLW       115
	MOVWF       T1CON+0 
;Sonar.c,47 :: 		TRISD = 0;
	CLRF        TRISD+0 
;Sonar.c,48 :: 		ANSELC.RC2 = 0;
	BCF         ANSELC+0, 2 
;Sonar.c,51 :: 		Lcd_Init();
	CALL        _Lcd_Init+0, 0
;Sonar.c,52 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Sonar.c,53 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Sonar.c,54 :: 		lcd_Out(1,1,adc_label_sonar);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        main_adc_label_sonar_L0+0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVF        main_adc_label_sonar_L0+1, 0 
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Sonar.c,55 :: 		lcd_Out(2,1,ccp_label_sonar);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        main_ccp_label_sonar_L0+0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVF        main_ccp_label_sonar_L0+1, 0 
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Sonar.c,57 :: 		PIE1.ADIE = 1;
	BSF         PIE1+0, 6 
;Sonar.c,58 :: 		PIE1.CCP1IE = 1;
	BSF         PIE1+0, 2 
;Sonar.c,59 :: 		PIE1.TMR1IE = 1;
	BSF         PIE1+0, 0 
;Sonar.c,60 :: 		PIR1.ADIF = 0;
	BCF         PIR1+0, 6 
;Sonar.c,61 :: 		PIR1.CCP1IF = 0;
	BCF         PIR1+0, 2 
;Sonar.c,62 :: 		PIR1.TMR1IF = 0;
	BCF         PIR1+0, 0 
;Sonar.c,63 :: 		INTCON.PEIE = 1;
	BSF         INTCON+0, 6 
;Sonar.c,66 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;Sonar.c,67 :: 		ADCON0.GO_NOT_DONE = 1;
	BSF         ADCON0+0, 1 
;Sonar.c,69 :: 		while (1)
L_main0:
;Sonar.c,71 :: 		if (dist != dist_prev)
	MOVF        _dist+1, 0 
	XORWF       _dist_prev+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main13
	MOVF        _dist_prev+0, 0 
	XORWF       _dist+0, 0 
L__main13:
	BTFSC       STATUS+0, 2 
	GOTO        L_main2
;Sonar.c,73 :: 		dist_prev = dist;
	MOVF        _dist+0, 0 
	MOVWF       _dist_prev+0 
	MOVF        _dist+1, 0 
	MOVWF       _dist_prev+1 
;Sonar.c,74 :: 		IntToStr(dist * 5,adc_lcd);
	MOVF        _dist+0, 0 
	MOVWF       R0 
	MOVF        _dist+1, 0 
	MOVWF       R1 
	MOVLW       5
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        R1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       main_adc_lcd_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(main_adc_lcd_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;Sonar.c,75 :: 		Lcd_Out(1,11,adc_lcd);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       11
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       main_adc_lcd_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(main_adc_lcd_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Sonar.c,76 :: 		}
L_main2:
;Sonar.c,77 :: 		if ((t_ccp != t_ccp_prev) && ccp_finished)
	MOVF        _t_ccp+1, 0 
	XORWF       _t_ccp_prev+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main14
	MOVF        _t_ccp_prev+0, 0 
	XORWF       _t_ccp+0, 0 
L__main14:
	BTFSC       STATUS+0, 2 
	GOTO        L_main5
	MOVF        _ccp_finished+0, 0 
	IORWF       _ccp_finished+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_main5
L__main11:
;Sonar.c,79 :: 		t_ccp_prev = t_ccp;
	MOVF        _t_ccp+0, 0 
	MOVWF       _t_ccp_prev+0 
	MOVF        _t_ccp+1, 0 
	MOVWF       _t_ccp_prev+1 
;Sonar.c,80 :: 		IntToStr(t_ccp, adc_lcd);
	MOVF        _t_ccp+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _t_ccp+1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       main_adc_lcd_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(main_adc_lcd_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;Sonar.c,81 :: 		Lcd_Out(2,11,adc_lcd);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       11
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       main_adc_lcd_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(main_adc_lcd_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Sonar.c,82 :: 		ccp_finished = 0;
	CLRF        _ccp_finished+0 
	CLRF        _ccp_finished+1 
;Sonar.c,83 :: 		}
L_main5:
;Sonar.c,84 :: 		}
	GOTO        L_main0
;Sonar.c,85 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_interrupt:

;Sonar.c,87 :: 		void interrupt() {
;Sonar.c,88 :: 		if (PIR1.ADIF)
	BTFSS       PIR1+0, 6 
	GOTO        L_interrupt6
;Sonar.c,90 :: 		dist = (ADRESH << 2) + (ADRESL >> 6);
	MOVF        ADRESH+0, 0 
	MOVWF       _dist+0 
	MOVLW       0
	MOVWF       _dist+1 
	RLCF        _dist+0, 1 
	BCF         _dist+0, 0 
	RLCF        _dist+1, 1 
	RLCF        _dist+0, 1 
	BCF         _dist+0, 0 
	RLCF        _dist+1, 1 
	MOVLW       6
	MOVWF       R1 
	MOVF        ADRESL+0, 0 
	MOVWF       R0 
	MOVF        R1, 0 
L__interrupt17:
	BZ          L__interrupt18
	RRCF        R0, 1 
	BCF         R0, 7 
	ADDLW       255
	GOTO        L__interrupt17
L__interrupt18:
	MOVF        R0, 0 
	ADDWF       _dist+0, 1 
	MOVLW       0
	ADDWFC      _dist+1, 1 
;Sonar.c,91 :: 		PIR1.ADIF = 0;
	BCF         PIR1+0, 6 
;Sonar.c,92 :: 		}
L_interrupt6:
;Sonar.c,93 :: 		if (PIR1.CCP1IF)
	BTFSS       PIR1+0, 2 
	GOTO        L_interrupt7
;Sonar.c,95 :: 		if (CCP1CON.CCP1M0)
	BTFSS       CCP1CON+0, 0 
	GOTO        L_interrupt8
;Sonar.c,97 :: 		t_ccp = (CCPR1H << 8) + CCPR1L;
	MOVF        CCPR1H+0, 0 
	MOVWF       _t_ccp+1 
	CLRF        _t_ccp+0 
	MOVF        CCPR1L+0, 0 
	ADDWF       _t_ccp+0, 1 
	MOVLW       0
	ADDWFC      _t_ccp+1, 1 
;Sonar.c,98 :: 		CCP1CON.CCP1M0 = 0;
	BCF         CCP1CON+0, 0 
;Sonar.c,100 :: 		}
	GOTO        L_interrupt9
L_interrupt8:
;Sonar.c,102 :: 		t_ccp = ((CCPR1H << 8) + CCPR1L) - t_ccp;
	MOVF        CCPR1H+0, 0 
	MOVWF       R1 
	CLRF        R0 
	MOVF        CCPR1L+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVF        _t_ccp+0, 0 
	SUBWF       R0, 0 
	MOVWF       _t_ccp+0 
	MOVF        _t_ccp+1, 0 
	SUBWFB      R1, 0 
	MOVWF       _t_ccp+1 
;Sonar.c,103 :: 		CCP1CON.CCP1M0 = 1;
	BSF         CCP1CON+0, 0 
;Sonar.c,104 :: 		ccp_finished = 1;
	MOVLW       1
	MOVWF       _ccp_finished+0 
	MOVLW       0
	MOVWF       _ccp_finished+1 
;Sonar.c,105 :: 		}
L_interrupt9:
;Sonar.c,106 :: 		PIR1.CCP1IF = 0;
	BCF         PIR1+0, 2 
;Sonar.c,107 :: 		}
L_interrupt7:
;Sonar.c,108 :: 		if (PIR1.TMR1IF)
	BTFSS       PIR1+0, 0 
	GOTO        L_interrupt10
;Sonar.c,110 :: 		ADCON0.GO_NOT_DONE = 1;
	BSF         ADCON0+0, 1 
;Sonar.c,111 :: 		PIR1.TMR1IF = 0;
	BCF         PIR1+0, 0 
;Sonar.c,112 :: 		}
L_interrupt10:
;Sonar.c,113 :: 		}
L_end_interrupt:
L__interrupt16:
	RETFIE      1
; end of _interrupt
