%commento

clear all;
close all;
clc;

%% code section: tempi

% vettore numeri da -2 a 2, distanti 0.01
% il ; sopprime gli output
t = -2 : 0.01 : 2; 
% primo elememto t, -2
t(1)
t(end) 

%% code section: sin plotting

a = 3;
f0 = 2;
phi = pi/10;

x1 = a*sin(2*pi*f0*t + phi);

figure;
plot(t, x1);
xlabel("Tempo [s]");
ylabel("Ampiezza [V]");
title("Sinusoide");
grid on;

%% code section: rettangolo

x2 = rectpulsFST(t);

figure;
plot(t, x2);
xlabel("Tempo [s]");
ylabel("Ampiezza [V]");
title("Sinusoide");
grid on;

%% code section: rettangolo traslato

t0 = 0.5;
x3 = rectpulsFST(t-t0);
plot(t, x3);
xlabel("Tempo [s]");
ylabel("Ampiezza [V]");
title("Sinusoide");
grid on;

%% code section: rettangolo traslato scalato

t0 = 0.5;
t_magnify = 1.5;
x4 = rectpulsFST((t-t0)/t_magnify);
plot(t, x4);
xlabel("Tempo [s]");
ylabel("Ampiezza [V]");
title("Sinusoide");
grid on;

%% code section: somma segnali e subplot

x6 = x3 + x4;

figure;
subplot(3,1,1)
plot(t,x4); title ("x4"); xlabel("Tempo"); ylabel(""); grid on;

subplot(3,1,2)
plot(t,x3); title ("x5"); xlabel("Tempo"); ylabel(""); grid on;

subplot(3,1,3)
plot(t,x6); title ("x6"); xlabel("Tempo"); ylabel(""); grid on;




