#include "timer.h"

// P18F45K22 Firmware
#define MAX_DELAY 2000
#define MIN_DELAY 100
#define ACCURANCY 50

// Register definition
#define INTCON(packing,GIE,PEIE,TMR0IE,INT0IE,RBIE,TMR0IF,INT0IF,RBIF) \
    packing ## GIE ## PEIE ## TMR0IE ## INT0IE ## RBIE ## TMR0IF ## INT0IF ## RBIF
// Global Vars
unsigned int delay = 500;
unsigned int timer_time_int = 0;
unsigned int timer_time_dec = 0;

// Global Interrupt Handler
void interrupt()
{
    if (INTCON.RBIF)
    {
        if (PORTB.RB7){
            delay += ACCURANCY;
            delay = (delay > MAX_DELAY) ? MAX_DELAY : delay;
        }
        if (PORTB.RB6){
            delay -= ACCURANCY;
            delay = (delay < MIN_DELAY) ? MIN_DELAY : delay;
        }
        // clear port B interrupt flag, must be cleared by software
        INTCON.RBIF = 0;
    }
    if (INTCON.TMR0IF)
    {
        timer_add(&timer_time_int,&timer_time_dec);
        // clear TMR0 interrupt flag, must be cleared by software
        INTCON.TMR0IF = 0;
    }
}

void main()
{
    // ANSI c mandates variable at the beginning
    short int up = 1;
    /* Register Setup */
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

    /* INTCON.GIE to be set after all interrupt registers are set  */
    INTCON.GIE = 1;
    /* ------------  */

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