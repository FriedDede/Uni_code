
_timer_add:

;timer.c,3 :: 		void timer_add(unsigned int *timer_int, unsigned int *timer_dec){
;timer.c,4 :: 		*timer_int += T0TIME_int;
	MOVFF       FARG_timer_add_timer_int+0, FSR0L+0
	MOVFF       FARG_timer_add_timer_int+1, FSR0H+0
	MOVLW       32
	ADDWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      POSTINC0+0, 0 
	MOVWF       R1 
	MOVFF       FARG_timer_add_timer_int+0, FSR1L+0
	MOVFF       FARG_timer_add_timer_int+1, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;timer.c,5 :: 		*timer_dec += T0TIME_dec;
	MOVFF       FARG_timer_add_timer_dec+0, FSR0L+0
	MOVFF       FARG_timer_add_timer_dec+1, FSR0H+0
	MOVFF       FARG_timer_add_timer_dec+0, FSR1L+0
	MOVFF       FARG_timer_add_timer_dec+1, FSR1H+0
	MOVLW       0
	ADDWF       POSTINC1+0, 1 
	MOVLW       3
	ADDWFC      POSTINC1+0, 1 
;timer.c,6 :: 		if (*timer_dec <= 1000)
	MOVFF       FARG_timer_add_timer_dec+0, FSR0L+0
	MOVFF       FARG_timer_add_timer_dec+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	SUBLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L__timer_add2
	MOVF        R1, 0 
	SUBLW       232
L__timer_add2:
	BTFSS       STATUS+0, 0 
	GOTO        L_timer_add0
;timer.c,8 :: 		*timer_int += 1;
	MOVFF       FARG_timer_add_timer_int+0, FSR0L+0
	MOVFF       FARG_timer_add_timer_int+1, FSR0H+0
	MOVLW       1
	ADDWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      POSTINC0+0, 0 
	MOVWF       R1 
	MOVFF       FARG_timer_add_timer_int+0, FSR1L+0
	MOVFF       FARG_timer_add_timer_int+1, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;timer.c,9 :: 		*timer_dec -= 1000;
	MOVFF       FARG_timer_add_timer_dec+0, FSR0L+0
	MOVFF       FARG_timer_add_timer_dec+1, FSR0H+0
	MOVFF       FARG_timer_add_timer_dec+0, FSR1L+0
	MOVFF       FARG_timer_add_timer_dec+1, FSR1H+0
	MOVLW       232
	SUBWF       POSTINC1+0, 1 
	MOVLW       3
	SUBWFB      POSTINC1+0, 1 
;timer.c,10 :: 		}
L_timer_add0:
;timer.c,11 :: 		}
L_end_timer_add:
	RETURN      0
; end of _timer_add
