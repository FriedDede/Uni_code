%% Matlab ENV set
clear;
clc;
load('Problema_1.mat');
%% Proj ENV set
[righe, colonne] = size(s);
dt = 1/Fs;
Toss = righe/Fs - dt;
df = Fs/length(s);
f = -Fs/2 : df : (Fs/2)-df;
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
    x = s.*2.*cos(2*pi*f0*t+teta)';
    y = s.*2.*sin(2*pi*f0*t+teta)';

    h_fir1 = fir1(30,f0/Fs);

    yf = conv2(y,h_fir1(:),'same');
    subplot(4,1,1), plot(t,abs(yf)), grid
    xlabel('tempo [s]'), title('abs(y)')
    
    %file = filename('y.wav');
    %audiowrite(file,yf,Fs);

    xf = conv2(x,h_fir1(:),'same');
    subplot(4,1,2), plot(t,abs(xf)), grid
    xlabel('tempo [s]'), title('abs(x)')

%% Richiesta 3: Estrazione x e y con errore di fase dteta +-pi
    eteta = rand*(2*pi)-pi;

    xdteta = s.*2.*cos(2*pi*f0*t+teta+eteta)';
    ydteta = s.*2.*sin(2*pi*f0*t+teta+eteta)';

    h_fir1 = fir1(30,f0/Fs);

    yfdteta = conv2(ydteta,h_fir1(:),'same');
    subplot(4,1,3), plot(t,abs(yfdteta)), grid
    xlabel('tempo [s]'), title('abs(y) dteta')

    xfdteta = conv2(xdteta,h_fir1(:),'same');
    subplot(4,1,4), plot(t,abs(xfdteta)), grid
    xlabel('tempo [s]'), title('abs(x) dteta')

%% Richiesta 4: Estrazione x e y con errore di frequenza +-1Hz
    figure;
    ef = rand*(2)-1;

    xdfreq = s.*2.*cos(2*pi*(f0+ef)*t+teta)';
    ydfreq = s.*2.*sin(2*pi*(f0+ef)*t+teta)';  

    h_fir1 = fir1(30,f0/Fs);

    yfdfreq = conv2(ydfreq,h_fir1(:),'same');
    subplot(4,1,1), plot(t,abs(yfdfreq)), grid
    xlabel('tempo [s]'), title('abs(y) dfreq')

    xfdfreq = conv2(xdfreq,h_fir1(:),'same');
    subplot(4,1,2), plot(t,abs(xfdfreq)), grid
    xlabel('tempo [s]'), title('abs(x) dfreq')

%% analisi trasf freq

    S1 = fftshift(fft(s(:, 1), length(f)))*dt; %Trasformata primo canale
    S2 = fftshift(fft(s(:, 2), length(f)))*dt; %Trasformata secondo canale
    subplot(4,1,3), plot(f,abs(S1)), grid
    xlabel('f [Hz]'), title('S-canale1-FFT')
    subplot(4,1,4), plot(f,abs(S2)), grid
    xlabel('f [Hz]'), title('S-canale2-FFT')
    
%% approx S2 a media mobile

    %delta_f = 1000;
    %H = 1/delta_f*rectpuls(f(:)/delta_f);

    % Spettro filtrato
    %figure;
    %Sw = 1/Toss*abs(S2).^2;
    %Swf = conv2(Sw,H,'same')*df;
    %plot(f,Swf), xlabel('f [HZ]'), title('S-mediamobile [10 Hz]'), grid
    %max = max(Swf);
    %f0_mean = f(Swf == max)

%% Phase Detector - from reference correctly demodulated, unfiltered signals
    x_ref = x(1 : 100);
    y_ref = y(1 : 100);
    s_ref = s(1 : 100);
    t_ref = t(1 : 100);
    T_oss_ref = t(100);
    df_ref = 1/(20*T_oss_ref);
    f_ref = -Fs/2 : df_ref : (Fs/2)-df_ref;
    
    cos_ref = x_ref./s_ref/2;
    sin_ref = -y_ref./s_ref/2;
    teta_dect_unfiltered = asin(sin_ref(1))
    acos(cos_ref());
    COS_ref = fft(cos_ref',size(f_ref,2),1);
    %figure;
    %subplot(3,1,1), plot(f_ref,abs(COS_ref));
    %xlabel('f [Hz]'), title('COS ref(f)');
    %subplot(3,1,2), plot(t_ref,cos_ref);
    %xlabel('t [dt]'), title('cos ref(t)');
    %subplot(3,1,3), plot(f_ref,angle(COS_ref));
    %xlabel('rad'), title('angle COS_ref(rad)');
%% Frequency detector - from signal
    %figure;
    S_pos = PSD(length(f)/2 : length(f));
    f_pos = f(length(f)/2 : length(f));
    %PSD_pos = 1/Toss*abs(S_pos).^2;
    %subplot(2,1,1), plot(f_pos,PSD_pos), grid;
    %xlabel('f [Hz]'), title('PSD-ch1 positiva(f)');
    f0_dec = sum(abs(S_pos).*abs(f_pos))/sum(abs(S_pos))
    
    S_pos = S2(length(f)/2 : length(f))';
    %PSD_pos = 1/Toss*abs(S_pos).^2;
    %subplot(2,1,2), plot(f_pos,PSD_pos), grid;
    %xlabel('f [Hz]'), title('PSD-ch2 positiva(f)');
    f0_dec = (f0_dec+sum(abs(S_pos).*abs(f_pos))/sum(abs(S_pos)))/2
    %fase_dec = angle(S_pos((f0_dec-mod(f0_dec,df))/df))
    
%% PSDs
    S1 = fftshift(fft(s(:, 1), length(f)))*df; %Trasformata primo canale
    Y1 = fftshift(fft(y(:, 1), length(f)))*df; %Trasformata secondo canale
    YF1 = fftshift(fft(yf(:, 1), length(f)))*df; %Trasformata primo canale
    figure;
    subplot(3,1,1), plot(f,1/Toss*abs(S1).^2), grid
    xlabel('f Hz]'), title('S-canale1-FFT')
    subplot(3,1,2), plot(f,1/Toss*abs(Y1).^2), grid
    xlabel('f [Hz]'), title('Y-canale1-FFT')
    subplot(3,1,3), plot(f,1/Toss*abs(YF1).^2), grid
    xlabel('f [Hz]'), title('YF1-canale1-FFT')
    
    Yfreq = fftshift(fft(ydfreq(:, 1), length(f)))*df; %Trasformata primo canale
    Yteta = fftshift(fft(ydteta(:, 1), length(f)))*df; %Trasformata secondo canale
    figure;
    subplot(3,1,1), plot(f,1/Toss*abs(Y1).^2), grid
    xlabel('f Hz]'), title('Y-canale1-FFT')
    subplot(3,1,2), plot(f,1/Toss*abs(Yteta).^2), grid
    xlabel('f [Hz]'), title('Ydteta-canale1-FFT')
    subplot(3,1,3), plot(f,1/Toss*abs(Yfreq).^2), grid
    xlabel('f [Hz]'), title('Ydfreq-canale1-FFT')
    
%%  Richiesta 5:
    figure;
    s_ref = s(1 : 100);
    xdemod = s_ref.*2.*cos(2*pi*(f0+ef)*t_ref+teta+eteta);
    ydemod = s_ref.*2.*sin(2*pi*(f0+ef)*t_ref+teta+eteta);
    x_ref = xf(1 : 100)';
    y_ref = yf(1 : 100)';
    YDEM = fft(ydemod(:,1),length(f_ref))*df_ref;
    YREF = fft(y_ref(:,1),length(f_ref))*df_ref;
    S_demod = YDEM.*conj(YREF);
    R_demod = ifft(S_demod,length(t_ref));
    subplot(2,2,1), plot(f_ref,abs(S_demod)), grid
    xlabel('f [Hz]'), title('S(ref,demod)')
    subplot(2,2,2), plot(t_ref,abs(R_demod)), grid
    xlabel('t [sec]'), title('R(ref,demod)')
    S_ref = YREF.*conj(YREF);
    R_ref = ifft(S_ref,length(t_ref));
    subplot(2,2,3), plot(f_ref,abs(S_ref)), grid
    xlabel('f [Hz]'), title('S(ref,ref)')
    subplot(2,2,4), plot(t_ref,abs(R_ref)), grid
    xlabel('t [sec]'), title('R(ref,ref)')
%% 
   figure;
   Xdteta = (fft(xdteta(:, 1), length(f)))*df;
   S=Yteta.*conj(Xdteta);
   R=ifft(S,length(t));
   %plot(f,S)
    
%%
    figure;
    plot(f,2*real(S)+2*imag(S))
