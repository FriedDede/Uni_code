#line 1 "C:/Users/posta/Src/Uni_code/Microcontrollori/ES2/ES2.c"
#line 1 "c:/users/posta/src/uni_code/microcontrollori/es2/timer.h"







void timer_add(unsigned int *timer_int, unsigned int *timer_dec);
#line 12 "C:/Users/posta/Src/Uni_code/Microcontrollori/ES2/ES2.c"
unsigned int delay = 500;
unsigned int timer_time_int = 0;
unsigned int timer_time_dec = 0;


void interrupt()
{
 if (INTCON.RBIF)
 {
 if (PORTB.RB7){
 delay +=  50 ;
 delay = (delay >  2000 ) ?  2000  : delay;
 }
 if (PORTB.RB6){
 delay -=  50 ;
 delay = (delay <  100 ) ?  100  : delay;
 }

 INTCON.RBIF = 0;
 }
 if (INTCON.TMR0IF)
 {
 timer_add(&timer_time_int,&timer_time_dec);

 INTCON.TMR0IF = 0;
 }
}

void main()
{

 short int up = 1;

 TRISD = 0b00000000;
 LATD = 0b00000001;
 TRISB = 0b11000000;
 ANSELB = 0b00000000;
 T0CON = 0b11000111;





 IOCB = 0b11000000;
 INTCON.RBIE = 1;
 INTCON.RBIF = 0;
 INTCON.TMR0IE = 1;
 INTCON.TMR0IF = 0;


 INTCON.GIE = 1;


 while (1)
 {
 if (timer_time_int > delay)
 {
 timer_time_int = 0;
 if (LATD == 0b10000000)
 up = 0;
 else if (LATD == 0b00000001)
 up = 1;
 if (up)
 LATD = LATD << 1;
 else
 LATD = LATD >> 1;
 }

 }
}
