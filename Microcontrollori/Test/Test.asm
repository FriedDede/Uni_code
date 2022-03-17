
_main:

;Test.c,2 :: 		void main() {
;Test.c,3 :: 		TRISA = 0b11111110;
	MOVLW       254
	MOVWF       TRISA+0 
;Test.c,4 :: 		ANSELD = 0b11111110;
	MOVLW       254
	MOVWF       ANSELD+0 
;Test.c,5 :: 		TRISD = 0b11111111;
	MOVLW       255
	MOVWF       TRISD+0 
;Test.c,7 :: 		LATA.RA0 = 1;
	BSF         LATA+0, 0 
;Test.c,8 :: 		while (1)
L_main0:
;Test.c,10 :: 		if(PORTD.RD0 == 1){
	BTFSS       PORTD+0, 0 
	GOTO        L_main2
;Test.c,11 :: 		LATA.RA0 = !LATA.RA0;
	BTG         LATA+0, 0 
;Test.c,12 :: 		}
	GOTO        L_main3
L_main2:
;Test.c,14 :: 		LATA.RA0 = 0;
	BCF         LATA+0, 0 
;Test.c,15 :: 		}
L_main3:
;Test.c,16 :: 		delay_ms(250);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_main4:
	DECFSZ      R13, 1, 1
	BRA         L_main4
	DECFSZ      R12, 1, 1
	BRA         L_main4
	DECFSZ      R11, 1, 1
	BRA         L_main4
	NOP
	NOP
;Test.c,17 :: 		}
	GOTO        L_main0
;Test.c,18 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
