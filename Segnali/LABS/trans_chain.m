clear;
clc;
% Segnale sinc ideale in 2-PAM unipolare
%% Signal trasmission

% segnale e numero di punti
N = 10;
dt = 0.01;
signal = [1 0 0 1 0 0 1 0 1 1 ];
t = 0 : dt : 110;
% tempo di simbolo
Ts = 10;
subplot(4,1,1), plot(signal), grid
% sinc, rect
sinc = sincFST(t/Ts);
pulse = rectpulsFST(t/Ts);
subplot(4,1,2), plot(t, pulse), grid;
subplot(4,1,3), plot(t, sinc), grid;
%% banda canale e rumore bianco
N = 11001;
Toss = dt*N;
wnoise = randn(1,N); % processo N di potenza 1
% Spettro teorico: processo bianco di potenza 2 e bandad 1/dt = 10
S2_th = 2*dt;
Nf = N;
W = fftshift(fft(wnoise,Nf,1))*dt;
Bch = 20;
f_Hc = rectpulsFST(t/Bch);

wnoise = ifft(W*f_Hc')';

%% pulse gen
tx_sig = 0;
for n = 1  : length(signal)
    if signal(n) == 1
        tx_sig = tx_sig + sincFST((t-(n*Ts))/Ts);
    end  
end
subplot(4,1,4), plot(t,tx_sig), grid;
%% transmission

ch_sig = tx_sig + wnoise;
rx_sig = conv(ch_sig,conj(sincFST((-t)/Ts)),'same');
figure;
plot(t,ch_sig);
