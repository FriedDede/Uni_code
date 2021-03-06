clear all;
close all;
clc;

%% convoluzione exp negativi

dt = 0.01;
t = -20 : dt : 20;
a = 2;

x1 = exp(-a*t).*gradinoFST(t);

%figure; plot(t, x1); grid on; title("x1"); xlabel ("Tempi")

y = conv(x1,x1,'same')*dt;

figure; plot(t,y); grid on; title("conv");

%% convoluzione sinc

dt = 0.01;
t = -5 : dt : 5;
Bsig = 0.1/dt;
h = Bsig*sincFST(Bsig*t);
% in ex, Bfiltro << Bsig
Bfiltro = Bsig/3;
x2 = sincFST(Bfiltro*t);
y = conv(x2,h,'same')*dt;

figure; 
subplot(3,1,2); plot(t,h); title("filto"); grid on;
subplot(3,1,1); plot(t,x2); title("segnale"); grid on;
subplot(3,1,3); plot(t,y); title("uscita"); grid on;

%% trasformata Fourier

dt = 0.001;
T = 100;
%vettore tempi
t = -T/2 : dt : T/2;
%segnale
sig3 = cos(2*pi*2*t);
%vettore freq
freq = -10 : 0.01 : 10;
% ' per trasporre freq, per fare il prodotto esterno tra due vettori
W=exp(-1j*2*pi*freq'*t);
X=W*sig3'*(dt/T);

figure; plot(freq,abs(X)); grid on; title("X(f)");


