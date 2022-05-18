#line 1 "C:/Users/posta/Src/Uni_code/Microcontrollori/ES5/ADC_Interrupt.c"

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


int adc_ra0;
int adc_prev_ra0;
int adc_ra1;
int adc_prev_ra1;


void main() {
 char adc_lcd[7];
 char *adc_label_RA0 = "RA0[mV]:";
 char *adc_label_RA1 = "RA1[mV]:";

 TRISC = 0;






 ADCON0.CHS0 = 0;
 ADCON0.CHS1 = 0;
 ADCON0.CHS2 = 0;
 ADCON0.CHS3 = 0;
 ADCON0.CHS4 = 0;
#line 55 "C:/Users/posta/Src/Uni_code/Microcontrollori/ES5/ADC_Interrupt.c"
 ADCON2.ADCS0 = 1;
 ADCON2.ADCS1 = 0;
 ADCON2.ADCS2 = 0;







 ADCON2.ACQT0 = 0;
 ADCON2.ACQT1 = 0;
 ADCON2.ACQT2 = 1;


 ADCON2.ADFM = 0;


 ADCON0.ADON = 1;
#line 90 "C:/Users/posta/Src/Uni_code/Microcontrollori/ES5/ADC_Interrupt.c"
 PIE1.ADIE = 1;
 PIR1.ADIF = 0;

 INTCON.PEIE = 1;

 INTCON.GIE = 1;


 ADCON0.GO_NOT_DONE = 1;


 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);

 Lcd_Out(1,1,adc_label_RA0);
 Lcd_Out(2,1,adc_label_RA1);
 while (1)
 {
 if (adc_ra0 != adc_prev_ra0)
 {

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
