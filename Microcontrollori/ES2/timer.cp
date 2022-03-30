#line 1 "C:/Users/posta/Src/Uni_code/Microcontrollori/ES2/timer.c"
#line 1 "c:/users/posta/src/uni_code/microcontrollori/es2/timer.h"







void timer_add(unsigned int *timer_int, unsigned int *timer_dec);
#line 3 "C:/Users/posta/Src/Uni_code/Microcontrollori/ES2/timer.c"
void timer_add(unsigned int *timer_int, unsigned int *timer_dec){
 *timer_int +=  32 ;
 *timer_dec +=  768 ;
 if (*timer_dec <= 1000)
 {
 *timer_int += 1;
 *timer_dec -= 1000;
 }
}
