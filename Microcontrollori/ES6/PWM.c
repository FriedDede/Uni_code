#define X 0
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

int adc_prev_ra0 = 0;

void main() {
    char adc_lcd[7];
    char *adc_label_RA0 = "RA0:";

    // ADC SETUP:
    TRISC = 0;
    ADCON0 = 0b00000000;
    ADCON2.ADCS0 = 1;
    ADCON2.ADCS1 = 0;
    ADCON2.ADCS2 = 0;
    ADCON2.ACQT0 = 0;
    ADCON2.ACQT1 = 0;
    ADCON2.ACQT2 = 1;
    ADCON2.ADFM = 0;
    ADCON0.ADON = 1;
    PIE1.ADIE = 1;
    PIR1.ADIF = 0;
    INTCON.PEIE = 1;
    INTCON.GIE = 1;
    ADCON0.GO_NOT_DONE = 1;
    // ----------

    // - Disable CCP (Capture/Compare/PWM)
    //      Out to prevent spikes during PWM init
    // - Output will be reenabled after initialization
    TRISE.RE2 = 1;
    // --- TMR4 - CCP5 ---
    CCPTMRS1.C5TSEL1 = 0;
    CCPTMRS1.C5TSEL0 = 1;
    // --- Set Period ----
    PR4 = 255;
    // --- PWM on CCP5 ---
    //  bit 5-4: LSBs of PWM duty cycle, in PWM mode only
    //  bit 3-0: mode select, 11XX for PWM mode
    CCP5CON = 0b00001100;
    //CCP5CON.CCP5M3 = 1;
    //CCP5CON.CCP5M2 = 1;
    // ---- Set Ton ------
    // duty_cycle = CCPR5L /(PR4 +1)
    CCPR5L = 0;
    // ---- Set TMR2 -----
    // bit 5: TMR2 ON
    // bit 6-7: Max Prescaler (16)
    T4CON = 0b00000111;
    // - Output Reenable
    TRISE.RE2 = 0;


    Lcd_Init();
    Lcd_Cmd(_LCD_CLEAR);
    Lcd_Cmd(_LCD_CURSOR_OFF);
    Lcd_Out(1,1,adc_label_RA0);
    while(1){
        if (CCPR5L != adc_prev_ra0)
        {
            LATC = CCPR5L;
            InttoStr(CCPR5L,adc_lcd);
            Lcd_Out(1,11,adc_lcd);
        }
    }
}

void interrupt(){
    if (PIR1.ADIF)
    {
        adc_prev_ra0 = CCPR5L;
        CCPR5L = ADRESH;
        ADCON0.GO_NOT_DONE = 1;
        PIR1.ADIF = 0;
    }
}
