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
// End Lcd module connections

int adc_ra0;
int adc_prev_ra0;
int adc_ra1;
int adc_prev_ra1;


void main() {
    char adc_lcd[7];
    char *adc_label_RA0 = "RA0[mV]:";
    char *adc_label_RA1 = "RA1[mV]:";
    // ----- Output ------
    TRISC = 0;
    // -------------------
    // ---- AN0 = RA0 ----
    // Default is aalog input; i.e., digital input buffer off
    // ANSELA.RA0 = 1;
    // -------------------
    // -- Set CHS (AN0) --
    ADCON0.CHS0 = 0;
    ADCON0.CHS1 = 0;
    ADCON0.CHS2 = 0;
    ADCON0.CHS3 = 0;
    ADCON0.CHS4 = 0;
    // -------------------
    // ----- Set TAD -----
    // TAD (1;25) us
    // set TAD min = 1us

    // Fosc = 32MHz
    // Fosc/32
    // ADCS = 010
    // ADCON2.ADCS0 = 0;
    // ADCON2.ADCS1 = 1;
    // ADCON2.ADCS2 = 0;
    // -------------------
    //Fosc = 8MHz TAD 
    // Fosc/8
    // ADCS = 001
    ADCON2.ADCS0 = 1;
    ADCON2.ADCS1 = 0;
    ADCON2.ADCS2 = 0;
    // -------------------
    // -- Set +/- Vref ---
    //ADCON1 = 0;
    // -------------------
    // --- Set ACQT -----
    // TACQ = 7.45 us
    // TACQTmin = 8 TAD
    ADCON2.ACQT0 = 0;
    ADCON2.ACQT1 = 0;
    ADCON2.ACQT2 = 1;
    // -------------------
    // --- Just. Left ---
    ADCON2.ADFM = 0;
    // -------------------
    // ----- ADC ON -------
    ADCON0.ADON = 1;
    // -------------------

    /*
    // Fast ADC Settings 
    Fosc = 32MHz
    ADCON2 = 0b00100001;
    //ADCON1 = 0;
    ADCON0=0b00000001;
    Fosc = 8MHz
    ADCON2 = 0b00100010;
    //ADCON1 = 0;
    ADCON0=0b00000001;
    */

    // --- Interrupt -----
    // ADC
    PIE1.ADIE = 1;
    PIR1.ADIF = 0;
    // ADC is a periferal
    INTCON.PEIE = 1;
    // Global befor starting
    INTCON.GIE = 1;
    // --------------------
    // Start Conv.
    ADCON0.GO_NOT_DONE = 1;
    // -----------LCD Initialization---------
    // Init the display library (This will set also the PORTB Configuration)
    Lcd_Init();
    Lcd_Cmd(_LCD_CLEAR);
    Lcd_Cmd(_LCD_CURSOR_OFF);
    
    Lcd_Out(1,1,adc_label_RA0);
    Lcd_Out(2,1,adc_label_RA1);
    while (1)
    {
        if (adc_ra0 != adc_prev_ra0)
        {
         // Print 8 MSBs on PORTC
            LATC = adc_ra0;
            InttoStr(adc_ra0,adc_lcd);
            Lcd_Out(1,11,adc_lcd);
        }
        if (adc_ra1 != adc_prev_ra1)
        {
            InttoStr(adc_ra1,adc_lcd);
            Lcd_Out(2,11,adc_lcd);
        }
    }

}

// ISR
void interrupt(){

    if (PIR1.ADIF)
    {
        if (ADCON0.CHS0 == 0)
        {
            adc_prev_ra0 = adc_ra0;
            adc_ra0 = ((ADRESH << 2) + (ADRESL >> 6))*5;
            ADCON0.GO_NOT_DONE = 1;
            ADCON0.CHS0 = 1;
        }
        else{
            adc_prev_ra1 = adc_ra1;
            adc_ra1 = (ADRESH)*(5000/256);
            ADCON0.GO_NOT_DONE = 1;
            ADCON0.CHS0 = 0;
        }
        PIR1.ADIF = 0;
    }


}