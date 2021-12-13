%% Matlab ENV set
clear;
clc;
load('Problema_1.mat');
%% Proj ENV set
[righe, colonne] = size(s);
dt = 1/Fs;
Toss = righe/Fs - dt;
df = 1/(5*Toss);
dt = 1/Fs;
f = -Fs/2 : df : Fs/2;
t = 0 :dt:Toss;

%% Richiesta 1: PSD
    Nf = size(f,2);
    S = fftshift(fft(s,Nf,1))*dt;

    % Stima dello spettro
    PSD = 1/Toss*abs(S).^2;
    plot(f,PSD), grid;
    xlabel('f [Hz]'), title('PSD(f)');

%% Richiesta 2: Estrazione x e y
    figure;
    x = s.*cos(pi*f0*t+teta)';
    y = s.*sin(pi*f0*t+teta)';

    h_fir1 = fir1(30,f0/Fs);

    yf = conv2(y,h_fir1(:),'same');
    subplot(4,1,1), plot(t,abs(yf)), grid
    xlabel('tempo [s]'), title('abs(y)')

    xf = conv2(x,h_fir1(:),'same');
    subplot(4,1,2), plot(t,abs(xf)), grid
    xlabel('tempo [s]'), title('abs(x)')

%% Richiesta 3: Estrazione x e y con errore di fase dteta +-pi
    dteta = rand*(2*pi)-pi;

    xdteta = s.*cos(pi*f0*t+teta+dteta)';
    ydteta = s.*sin(pi*f0*t+teta+dteta)';

    h_fir1 = fir1(30,f0/Fs);

    yfdteta = conv2(ydteta,h_fir1(:),'same');
    subplot(4,1,3), plot(t,abs(yfdteta)), grid
    xlabel('tempo [s]'), title('abs(y) dteta')

    xfdteta = conv2(xdteta,h_fir1(:),'same');
    subplot(4,1,4), plot(t,abs(xfdteta)), grid
    xlabel('tempo [s]'), title('abs(x) dteta')

%% Richiesta 4: Estrazione x e y con errore di frequenza +-1Hz
    figure;
    df = rand*(2)-1;

    xdfreq = s.*cos(pi*(f0+df)*t+teta)';
    ydfreq = s.*sin(pi*(f0+df)*t+teta)';

    h_fir1 = fir1(30,f0/Fs);

    yfdfreq = conv2(ydfreq,h_fir1(:),'same');
    subplot(4,1,1), plot(t,abs(yfdfreq)), grid
    xlabel('tempo [s]'), title('abs(y) dfreq')

    xfdfreq = conv2(xdfreq,h_fir1(:),'same');
    subplot(4,1,2), plot(t,abs(xfdfreq)), grid
    xlabel('tempo [s]'), title('abs(x) dfreq')

%% analisi trasf freq

    S1 = fftshift(fft(yf(:, 2), length(f)))*df; %Trasformata primo canale
    S2 = fftshift(fft(s(:, 2), length(f)))*df; %Trasformata secondo canale

    subplot(4,1,3), plot(f,(S1)), grid
    xlabel('f [Hz]'), title('Y-canale2-FFT')
    subplot(4,1,4), plot(f,(S2)), grid
    xlabel('f [Hz]'), title('S-canale2-FFT')
%% approx S2 a media mobile

    delta_f = 1000;
    H = 1/delta_f*rectpuls(f(:)/delta_f);

    % Spettro filtrato
    figure;
    Sw = 1/Toss*abs(S2).^2;
    Swf = conv2(Sw,H,'same')*df;
    plot(f,Swf), xlabel('f [HZ]'), title('S-mediamobile [10 Hz]'), grid

