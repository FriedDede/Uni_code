
void main() {
	TRISA = 0b00000000;
	TRISD = 0b11111111;
	ANSELD = 0b00000000;
	while (1) {
		if (PORTD.RD0==1) PORTA.RA0 = ~PORTA.RA0;
		else PORTA.RA0=0;
		delay_ms(250);
	}
}
