#ifndef TIMER_H
#define TIMER_H

#define T0TIME_int 32
#define T0TIME_dec 768

void timer_add(unsigned int *timer_int, unsigned int *timer_dec);
void timer_delayUp(unsigned int *delay);
void timer_delayDown(unsigned int *delay);

#endif
