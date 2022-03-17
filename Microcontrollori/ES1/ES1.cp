#line 1 "C:/Users/posta/Src/Uni_code/Microcontrollori/ES1/ES1.c"
void main(){
 TRISA = 0b11111110;
 ANSELD = 0b00000000;
 TRISD = 0b11111111;

 LATA.RA0 = 1;
 while (1)
 {
 if(PORTD.RD0 == 1) LATA.RA0 = 1;
 else if(PORTD.RD5 == 1){
 LATA.RA0 = ~LATA.RA0;
 delay_ms(67);
 }
 else if(PORTD.RD4 == 1){
 LATA.RA0 = ~LATA.RA0;
 delay_ms(125);
 }
 else if(PORTD.RD3 == 1){
 LATA.RA0 = ~LATA.RA0;
 delay_ms(250);
 }
 else if(PORTD.RD2 == 1){
 LATA.RA0 = ~LATA.RA0;
 delay_ms(500);
 }
 else if(PORTD.RD1 == 1){
 LATA.RA0 = ~LATA.RA0;
 delay_ms(1000);
 }
 else{
 LATA.RA0 = 0;
 }
 }
}
