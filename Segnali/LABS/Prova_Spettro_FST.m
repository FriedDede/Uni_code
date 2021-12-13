clear, clc

% tempo di campionamento
dt = .1;

N = 1e3;
Toss = dt*N;

w = randn(N,1)+ 1i*randn(N,1); % processo CN di potenza 2
% Spettro teorico: processo bianco di potenza 2 e bandad 1/dt = 10
S2_th = 2*dt;

Nf = N;
W = fftshift(fft(w,Nf,1))*dt;
f = (-Nf/2:Nf/2-1)/Nf/dt;
df = f(2)-f(1);

% Stima dello spettro
Sw = 1/Toss*abs(W).^2;

figure, 
subplot(2,1,1), plot(f,Sw), grid

Pw_stim = sum(Sw)*df; % mean(abs(w).^2) stessa misura nel tempo


% media e dispersione della stima dello spettro
disp = sqrt(var(Sw));
med = mean(Sw);


% media mobile
delta_f = 1;
H = 1/delta_f*rectpuls(f(:)/delta_f);
sum(H)*df;

% Spettro filtrato
Swf = conv2(Sw,H,'same')*df;
subplot(2,1,2), plot(f,Swf), grid



