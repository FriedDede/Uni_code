#include "timer.h"
#define MAX_DELAY 2000
#define MIN_DELAY 100
#define ACCURANCY 50

void timer_add(unsigned int *timer_int, unsigned int *timer_dec){
    *timer_int += T0TIME_int;
    *timer_dec += T0TIME_dec;
    if (*timer_dec >= 1000)
    {
        *timer_int += 1;
        *timer_dec -= 1000;
    }
}

void timer_delayUp(unsigned int *delay){
    *delay += ACCURANCY;
    *delay = (*delay > MAX_DELAY) ? MAX_DELAY : *delay;
}

void timer_delayDown(unsigned int *delay){
    *delay -= ACCURANCY;
    *delay = (*delay < MIN_DELAY) ? MIN_DELAY : *delay;
}