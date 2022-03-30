
_interrupt:

;ES2.c,17 :: 		void interrupt()
;ES2.c,19 :: 		if (INTCON.RBIF)
	BTFSS       INTCON+0, 0 
	GOTO        L_interrupt0
;ES2.c,21 :: 		if (PORTB.RB7){
	BTFSS       PORTB+0, 7 
	GOTO        L_interrupt1
;ES2.c,22 :: 		delay += ACCURANCY;
	MOVLW       50
	ADDWF       _delay+0, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _delay+1, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	MOVWF       _delay+0 
	MOVF        R2, 0 
	MOVWF       _delay+1 
;ES2.c,23 :: 		delay = (delay > MAX_DELAY) ? MAX_DELAY : delay;
	MOVF        R2, 0 
	SUBLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt18
	MOVF        R1, 0 
	SUBLW       208
L__interrupt18:
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt2
	MOVLW       208
	MOVWF       ?FLOC___interruptT4+0 
	MOVLW       7
	MOVWF       ?FLOC___interruptT4+1 
	GOTO        L_interrupt3
L_interrupt2:
	MOVF        _delay+0, 0 
	MOVWF       ?FLOC___interruptT4+0 
	MOVF        _delay+1, 0 
	MOVWF       ?FLOC___interruptT4+1 
L_interrupt3:
	MOVF        ?FLOC___interruptT4+0, 0 
	MOVWF       _delay+0 
	MOVF        ?FLOC___interruptT4+1, 0 
	MOVWF       _delay+1 
;ES2.c,24 :: 		}
L_interrupt1:
;ES2.c,25 :: 		if (PORTB.RB6){
	BTFSS       PORTB+0, 6 
	GOTO        L_interrupt4
;ES2.c,26 :: 		delay -= ACCURANCY;
	MOVLW       50
	SUBWF       _delay+0, 0 
	MOVWF       R1 
	MOVLW       0
	SUBWFB      _delay+1, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	MOVWF       _delay+0 
	MOVF        R2, 0 
	MOVWF       _delay+1 
;ES2.c,27 :: 		delay = (delay < MIN_DELAY) ? MIN_DELAY : delay;
	MOVLW       0
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt19
	MOVLW       100
	SUBWF       R1, 0 
L__interrupt19:
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt5
	MOVLW       100
	MOVWF       ?FLOC___interruptT8+0 
	MOVLW       0
	MOVWF       ?FLOC___interruptT8+1 
	GOTO        L_interrupt6
L_interrupt5:
	MOVF        _delay+0, 0 
	MOVWF       ?FLOC___interruptT8+0 
	MOVF        _delay+1, 0 
	MOVWF       ?FLOC___interruptT8+1 
L_interrupt6:
	MOVF        ?FLOC___interruptT8+0, 0 
	MOVWF       _delay+0 
	MOVF        ?FLOC___interruptT8+1, 0 
	MOVWF       _delay+1 
;ES2.c,28 :: 		}
L_interrupt4:
;ES2.c,30 :: 		INTCON.RBIF = 0;
	BCF         INTCON+0, 0 
;ES2.c,31 :: 		}
L_interrupt0:
;ES2.c,32 :: 		if (INTCON.TMR0IF)
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt7
;ES2.c,34 :: 		timer_add(&timer_time_int,&timer_time_dec);
	MOVLW       _timer_time_int+0
	MOVWF       FARG_timer_add_timer_int+0 
	MOVLW       hi_addr(_timer_time_int+0)
	MOVWF       FARG_timer_add_timer_int+1 
	MOVLW       _timer_time_dec+0
	MOVWF       FARG_timer_add_timer_dec+0 
	MOVLW       hi_addr(_timer_time_dec+0)
	MOVWF       FARG_timer_add_timer_dec+1 
	CALL        _timer_add+0, 0
;ES2.c,36 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;ES2.c,37 :: 		}
L_interrupt7:
;ES2.c,38 :: 		}
L_end_interrupt:
L__interrupt17:
	RETFIE      1
; end of _interrupt

_main:

;ES2.c,40 :: 		void main()
;ES2.c,43 :: 		short int up = 1;
	MOVLW       1
	MOVWF       main_up_L0+0 
;ES2.c,45 :: 		TRISD = 0b00000000;
	CLRF        TRISD+0 
;ES2.c,46 :: 		LATD = 0b00000001;
	MOVLW       1
	MOVWF       LATD+0 
;ES2.c,47 :: 		TRISB = 0b11000000;
	MOVLW       192
	MOVWF       TRISB+0 
;ES2.c,48 :: 		ANSELB = 0b00000000;
	CLRF        ANSELB+0 
;ES2.c,49 :: 		T0CON = 0b11000111;
	MOVLW       199
	MOVWF       T0CON+0 
;ES2.c,55 :: 		IOCB = 0b11000000;
	MOVLW       192
	MOVWF       IOCB+0 
;ES2.c,56 :: 		INTCON.RBIE = 1;
	BSF         INTCON+0, 3 
;ES2.c,57 :: 		INTCON.RBIF = 0;
	BCF         INTCON+0, 0 
;ES2.c,58 :: 		INTCON.TMR0IE = 1;
	BSF         INTCON+0, 5 
;ES2.c,59 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;ES2.c,62 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;ES2.c,65 :: 		while (1)
L_main8:
;ES2.c,67 :: 		if (timer_time_int > delay)
	MOVF        _timer_time_int+1, 0 
	SUBWF       _delay+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main21
	MOVF        _timer_time_int+0, 0 
	SUBWF       _delay+0, 0 
L__main21:
	BTFSC       STATUS+0, 0 
	GOTO        L_main10
;ES2.c,69 :: 		timer_time_int = 0;
	CLRF        _timer_time_int+0 
	CLRF        _timer_time_int+1 
;ES2.c,70 :: 		if (LATD == 0b10000000)
	MOVF        LATD+0, 0 
	XORLW       128
	BTFSS       STATUS+0, 2 
	GOTO        L_main11
;ES2.c,71 :: 		up = 0;
	CLRF        main_up_L0+0 
	GOTO        L_main12
L_main11:
;ES2.c,72 :: 		else if (LATD == 0b00000001)
	MOVF        LATD+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main13
;ES2.c,73 :: 		up = 1;
	MOVLW       1
	MOVWF       main_up_L0+0 
L_main13:
L_main12:
;ES2.c,74 :: 		if (up)
	MOVF        main_up_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main14
;ES2.c,75 :: 		LATD = LATD << 1;
	MOVF        LATD+0, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVF        R0, 0 
	MOVWF       LATD+0 
	GOTO        L_main15
L_main14:
;ES2.c,77 :: 		LATD = LATD >> 1;
	MOVF        LATD+0, 0 
	MOVWF       R0 
	RRCF        R0, 1 
	BCF         R0, 7 
	MOVF        R0, 0 
	MOVWF       LATD+0 
L_main15:
;ES2.c,78 :: 		}
L_main10:
;ES2.c,80 :: 		}
	GOTO        L_main8
;ES2.c,81 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
