#include "timer.h"

// P18F45K22 Firmware

// Global Vars
unsigned int delay = 1000;
unsigned int timer_time_int = 0;
unsigned int timer_time_dec = 0;

// Global Interrupt Handler
void interrupt()
{
    if (INTCON.RBIF)
    {
        if (PORTB.RB7)
            timer_delayUp(&delay);
        if (PORTB.RB6)
            timer_delayDown(&delay);
        // clear port B interrupt flag, must be cleared by software
        INTCON.RBIF = 0;
    }
    if (INTCON.TMR0IF)
    {
        timer_add(&timer_time_int, &timer_time_dec);
        // clear TMR0 interrupt flag, must be cleared by software
        INTCON.TMR0IF = 0;
    }
}

void main()
{
    short int t = 1;
    short int up = 0;
    short int running = 1;
    // one cycle bit mirror is not implemented in hardware (afaik)
    short int timer_visual_lut[] = {
        0b00000000,
        0b10000001,
        0b11000011,
        0b11100111,
        0b11111111,
    } /* Register Setup */
    TRISA = 0b00011111;
    ANSELA = 0b00000000;
    TRISD = 0b00000000;
    LATD = 0b00000001;
    TRISB = 0b11000000;
    ANSELB = 0b00000000;
    T0CON = 0b11000111;
    // Interrupt Setup
    // IOCB -> pin I/O activation
    // GIE -> global interrupt enable
    // RBIE -> port B interrupt on change enable
    // RBIF -> port B interrupt flag, must be cleared
    IOCB = 0b11000000;
    INTCON.RBIE = 1;
    INTCON.RBIF = 0;
    INTCON.TMR0IE = 1;
    INTCON.TMR0IF = 0;

    // INTCON.GIE to be set after all interrupt registers are set
    INTCON.GIE = 1;

    while (1)
    {
        if (timer_time_int > delay && running)
        {
            timer_time_int = 0;
            if (t == 0)
                up = 1;
            else if (t == 5)
                up = 0;
            if (up)
            {
                LATD = timer_visual_lut[++t];
            }
            else
                LATD = timer_visual_lut[--t];
        }
        if (PORTA.RA3)
            timer_delayUp(&delay);
        if (PORTA.RA4)
            timer_delayDown(&delay);
        if (PORTA.RA2)
        {
            running = 0;
            t = 0;
        }
        if (PORTA.RA1)
            running = 0;
        if (PORTA.RA0)
            running = 1;
    }
}