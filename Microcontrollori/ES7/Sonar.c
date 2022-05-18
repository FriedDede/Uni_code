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

unsigned int dist = 0;
unsigned int t_ccp = 0;
unsigned int t_ccp_prev = 0;
unsigned int ccp_finished = 0;
unsigned int dist_prev = 0;

void main() {
    char adc_lcd[7];
    char *adc_label_sonar = "ADC:";
    char *ccp_label_sonar = "CCP:";
    /*
    * 
    */
    ADCON0 = 0b00111101;
    ADCON1 = 0;

    ADCON2.ADFM = 0;
    ADCON2.ADCS0 = 1;
    ADCON2.ADCS1 = 0;
    ADCON2.ADCS2 = 0;
    ADCON2.ACQT0 = 0;
    ADCON2.ACQT1 = 0;
    ADCON2.ACQT2 = 1;
    // CCP1 Su RC2, sensibile al rising edge
    CCP1CON.CCP1M3 = 0;
    CCP1CON.CCP1M2 = 1;
    CCP1CON.CCP1M1 = 0;
    CCP1CON.CCP1M0 = 1;
    // timer 1 setup
    T1CON = 0b01110011;

    TRISD = 0;
    ANSELC.RC2 = 0;


    Lcd_Init();
    Lcd_Cmd(_LCD_CLEAR);
    Lcd_Cmd(_LCD_CURSOR_OFF);
    lcd_Out(1,1,adc_label_sonar);
    lcd_Out(2,1,ccp_label_sonar);

    PIE1.ADIE = 1;
    PIE1.CCP1IE = 1;
    PIE1.TMR1IE = 1;
    PIR1.ADIF = 0;
    PIR1.CCP1IF = 0;
    PIR1.TMR1IF = 0;
    INTCON.PEIE = 1;


    INTCON.GIE = 1;
    ADCON0.GO_NOT_DONE = 1;

    while (1)
    {
        if (dist != dist_prev)
        {
            dist_prev = dist;
            IntToStr(dist * 5,adc_lcd);
            Lcd_Out(1,11,adc_lcd);
        }
        if ((t_ccp != t_ccp_prev) && ccp_finished)
        {
            t_ccp_prev = t_ccp;
            IntToStr(t_ccp, adc_lcd);
            Lcd_Out(2,11,adc_lcd);
            ccp_finished = 0;
        }
    }
}

void interrupt() {
    if (PIR1.ADIF)
    {
        dist = (ADRESH << 2) + (ADRESL >> 6);
        PIR1.ADIF = 0;
    }
    if (PIR1.CCP1IF)
    {
        if (CCP1CON.CCP1M0)
        {
            t_ccp = (CCPR1H << 8) + CCPR1L;
            CCP1CON.CCP1M0 = 0;
           
        }
        else{
            t_ccp = ((CCPR1H << 8) + CCPR1L) - t_ccp;
            CCP1CON.CCP1M0 = 1;
            ccp_finished = 1;
        }
        PIR1.CCP1IF = 0;
    }
    if (PIR1.TMR1IF)
    {
        ADCON0.GO_NOT_DONE = 1;
        PIR1.TMR1IF = 0;
    }
}