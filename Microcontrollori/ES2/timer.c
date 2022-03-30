#include "timer.h"

void timer_add(unsigned int *timer_int, unsigned int *timer_dec){
    *timer_int += T0TIME_int;
    *timer_dec += T0TIME_dec;
    if (*timer_dec >= 1000)
    {
        *timer_int += 1;
        *timer_dec -= 1000;
    }
}