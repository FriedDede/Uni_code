
void main() {
     TRISA = 0b11111110;
     ANSELD = 0b11111110;
     TRISD = 0b11111111;

     LATA.RA0 = 1;
     while (1)
     {
          if(PORTD.RD0 == 1){
               LATA.RA0 = !LATA.RA0;
          }
          else{
               LATA.RA0 = 0;
          }
          delay_ms(250);
     }
}
