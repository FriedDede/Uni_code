
_main:

;ES1_beta.c,2 :: 		void main() {
;ES1_beta.c,3 :: 		TRISA = 0b00000000;
	CLRF        TRISA+0 
;ES1_beta.c,4 :: 		TRISD = 0b11111111;
	MOVLW       255
	MOVWF       TRISD+0 
;ES1_beta.c,5 :: 		ANSELD = 0b00000000;
	CLRF        ANSELD+0 
;ES1_beta.c,6 :: 		while (1) {
L_main0:
;ES1_beta.c,7 :: 		if (PORTD.RD0==1) PORTA.RA0 = ~PORTA.RA0;
	BTFSS       PORTD+0, 0 
	GOTO        L_main2
	BTG         PORTA+0, 0 
	GOTO        L_main3
L_main2:
;ES1_beta.c,8 :: 		else PORTA.RA0=0;
	BCF         PORTA+0, 0 
L_main3:
;ES1_beta.c,9 :: 		delay_ms(250);
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
;ES1_beta.c,10 :: 		}
	GOTO        L_main0
;ES1_beta.c,11 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
