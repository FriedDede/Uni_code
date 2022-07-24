// Lcd module connections
sbit LCD_RS at LATB4_bit;
sbit LCD_EN at LATB5_bit;
sbit LCD_D4 at LATB0_bit;
sbit LCD_D5 at LATB1_bit;
sbit LCD_D6 at LATB2_bit;
sbit LCD_D7 at LATB3_bit;

sbit LCD_RS_Direction at TRISB4_bit;
sbit LCD_EN_Direction at TRISB5_bit;
sbit LCD_D4_Direction at TRISB0_bit;
sbit LCD_D5_Direction at TRISB1_bit;
sbit LCD_D6_Direction at TRISB2_bit;
sbit LCD_D7_Direction at TRISB3_bit;

struct timer
{
    unsigned int ms;
    unsigned int us;
};
unsigned int ccp_tmr = 0;
unsigned short sig_abrt = 0;

void main()
{
    unsigned short timer_value = 30;
    unsigned short porta_prec = 0b00000000;
    unsigned short timer_started = 0;
    char timer_str[4];

    TRISA = 0b00001111;
    ANSELA = 0b11110000;
    TRISC = 0b00000100;
    ANSELC = 0b00000100;
    TRISE.RE2 = 0;
    ANSELE.RE2 = 0;

    // CCP1 capture mode - rising edge triggered
    CCP1CON = 0b00000101;
    // CCP1 uses TIMER 1;
    CCPTMRS0 = 0b00000000;

    // TIMER 0 SETUP
    T0CON = 0b11000111;
    INTCON.TMR0IF = 0;
    // TIMER 1 SETUP
    // 8 Mhz freq (Fosc), 8PR 1 tick = 1us, 16bit mode 
    T1CON = 0b01110011;

    Lcd_Init();
    Lcd_Cmd(_LCD_CLEAR);
    Lcd_Cmd(_LCD_CURSOR_OFF);

    InttoStr(timer_str,timer_value);
    Lcd_Out(1,1,timer_str);

    PIE1.CCP1IE=1;
    INTCON.TMR0IE = 0;
    INTCON.PEIE = 1;
    INTCON.GIE = 1;

    while(1){
        if (sig_abrt)
        {
            INTCON.TMR0IE = 0;
            Lcd_Out(2,1,"Aborted");
        }
        if (timer.ms > 1000)
        {
            timer_value--;
            timer.ms -= 1000;
            InttoStr(timer_str,timer_value);
            Lcd_Out(1,1,timer_str);
        }
        if (PORTA.RA2 && !(porta_prec & 0b00000100))
        {
            timer_value += 5;
            InttoStr(timer_str,timer_value);
            Lcd_Out(1,1,timer_str);
            porta_prec |= 0b00000100;
        }
        if (!PORTA.RA2 && (porta_prec & 0b00000100))
        {
            porta_prec & 0b11111011;
        }
        if (PORTA.RA3 && !(porta_prec & 0b00001000))
        {
            timer_value += 5;
            InttoStr(timer_str,timer_value);
            Lcd_Out(1,1,timer_str);
            porta_prec |= 0b00001000;
        }
        if (!PORTA.RA3 && (porta_prec & 0b00001000))
        {
            porta_prec & 0b11110111;
        }
        if (PORTA.RA0)
        {
            timer_started = 1;
            INTCON.TMR0IE = 1;
        }
        if (PORTA.RA1)
        {
            timer_started = 0;
            INTCON.TMR0IE = 0;
        }
    }
    return 0;
}

void interrupt(){
    if (INTCON.TMROIF)
    {
        timer.ms += 32;
        timer.us += 768;
        if (timer.us > 1000)
        {
            timer.ms++;
            timer.us -= 1000;
        }
        INTCON.TMR0IF = 0;
    }
    if(PIR1.CCP1IF){
        if (CCP1CON.CCP1M0)
        {
            ccp_tmr = (CCPR1H << 8) | CCPR1L;
            CCP1CON.CCP1M0 = 0;
        }
        else
        {
            ccp_tmr = ((CCPR1H << 8) | CCPR1L) - ccp_tmr;
            if (ccp_tmr < 1000) sig_abrt = 1;
            CCP1CON.CCP1M0 = 1;
        }
        PIR1.CCP1IF = 0;
    }
}