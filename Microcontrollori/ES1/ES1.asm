
_main:

;ES1.c,1 :: 		void main(){
;ES1.c,2 :: 		TRISA = 0b11111110;
	MOVLW       254
	MOVWF       TRISA+0 
;ES1.c,3 :: 		ANSELD = 0b00000000;
	CLRF        ANSELD+0 
;ES1.c,4 :: 		TRISD = 0b11111111;
	MOVLW       255
	MOVWF       TRISD+0 
;ES1.c,6 :: 		LATA.RA0 = 1;
	BSF         LATA+0, 0 
;ES1.c,7 :: 		while (1)
L_main0:
;ES1.c,9 :: 		if(PORTD.RD0 == 1) LATA.RA0 = 1;
	BTFSS       PORTD+0, 0 
	GOTO        L_main2
	BSF         LATA+0, 0 
	GOTO        L_main3
L_main2:
;ES1.c,10 :: 		else if(PORTD.RD5 == 1){
	BTFSS       PORTD+0, 5 
	GOTO        L_main4
;ES1.c,11 :: 		LATA.RA0 = ~LATA.RA0;
	BTG         LATA+0, 0 
;ES1.c,12 :: 		delay_ms(67);
	MOVLW       175
	MOVWF       R12, 0
	MOVLW       5
	MOVWF       R13, 0
L_main5:
	DECFSZ      R13, 1, 1
	BRA         L_main5
	DECFSZ      R12, 1, 1
	BRA         L_main5
;ES1.c,13 :: 		}
	GOTO        L_main6
L_main4:
;ES1.c,14 :: 		else if(PORTD.RD4 == 1){
	BTFSS       PORTD+0, 4 
	GOTO        L_main7
;ES1.c,15 :: 		LATA.RA0 = ~LATA.RA0;
	BTG         LATA+0, 0 
;ES1.c,16 :: 		delay_ms(125);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       69
	MOVWF       R12, 0
	MOVLW       169
	MOVWF       R13, 0
L_main8:
	DECFSZ      R13, 1, 1
	BRA         L_main8
	DECFSZ      R12, 1, 1
	BRA         L_main8
	DECFSZ      R11, 1, 1
	BRA         L_main8
	NOP
	NOP
;ES1.c,17 :: 		}
	GOTO        L_main9
L_main7:
;ES1.c,18 :: 		else if(PORTD.RD3 == 1){
	BTFSS       PORTD+0, 3 
	GOTO        L_main10
;ES1.c,19 :: 		LATA.RA0 = ~LATA.RA0;
	BTG         LATA+0, 0 
;ES1.c,20 :: 		delay_ms(250);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_main11:
	DECFSZ      R13, 1, 1
	BRA         L_main11
	DECFSZ      R12, 1, 1
	BRA         L_main11
	DECFSZ      R11, 1, 1
	BRA         L_main11
	NOP
	NOP
;ES1.c,21 :: 		}
	GOTO        L_main12
L_main10:
;ES1.c,22 :: 		else if(PORTD.RD2 == 1){
	BTFSS       PORTD+0, 2 
	GOTO        L_main13
;ES1.c,23 :: 		LATA.RA0 = ~LATA.RA0;
	BTG         LATA+0, 0 
;ES1.c,24 :: 		delay_ms(500);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_main14:
	DECFSZ      R13, 1, 1
	BRA         L_main14
	DECFSZ      R12, 1, 1
	BRA         L_main14
	DECFSZ      R11, 1, 1
	BRA         L_main14
	NOP
	NOP
;ES1.c,25 :: 		}
	GOTO        L_main15
L_main13:
;ES1.c,26 :: 		else if(PORTD.RD1 == 1){
	BTFSS       PORTD+0, 1 
	GOTO        L_main16
;ES1.c,27 :: 		LATA.RA0 = ~LATA.RA0;
	BTG         LATA+0, 0 
;ES1.c,28 :: 		delay_ms(1000);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_main17:
	DECFSZ      R13, 1, 1
	BRA         L_main17
	DECFSZ      R12, 1, 1
	BRA         L_main17
	DECFSZ      R11, 1, 1
	BRA         L_main17
	NOP
	NOP
;ES1.c,29 :: 		}
	GOTO        L_main18
L_main16:
;ES1.c,31 :: 		LATA.RA0 = 0;
	BCF         LATA+0, 0 
;ES1.c,32 :: 		}
L_main18:
L_main15:
L_main12:
L_main9:
L_main6:
L_main3:
;ES1.c,33 :: 		}
	GOTO        L_main0
;ES1.c,34 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
