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
%% Calcolo dteta tramite massimizzazione dell'energia (BPS)
    Nteta = 1000;
    h_fir1 = fir1(60,f0/Fs);
    dteta = 0 : pi/Nteta : pi-pi/Nteta;
    Ex = zeros(length(dteta),1,2);
    Ey = zeros(length(dteta),1,2);
    %   Energy compute
    for i = 1:length(dteta)
        x = s.*2.*cos(2*pi*f0*t+dteta(i))';
        y = s.*2.*sin(2*pi*f0*t+dteta(i))';
        x = conv2(x,h_fir1(:),'same');
        y = conv2(y,h_fir1(:),'same');
        Ex(i,:,:) = sum(abs(x).^2)*dt;
        Ey(i,:,:) = sum(abs(y).^2)*dt;
    end
    %   Energy plotting
    subplot(2,2,1),plot(dteta,Ex(:,:,1)), grid
    xlabel('dteta'), title('EX-CH1')
    subplot(2,2,2),plot(dteta,Ex(:,:,2)), grid
    xlabel('dteta'), title('EX-CH2')
    subplot(2,2,3),plot(dteta,Ey(:,:,1)), grid
    xlabel('dteta'), title('EY-CH1')
    subplot(2,2,4),plot(dteta,Ey(:,:,2)), grid
    xlabel('dteta'), title('EY-CH2')
    %   media teta calcolata nei 4 canali
    teta1 = dteta(Ex(:,:,1) == max(Ex(:,:,1)));
    teta1 = teta1 +dteta(Ex(:,:,2) == max(Ex(:,:,2)));
    teta1 = teta1 +dteta(Ey(:,:,1) == min(Ey(:,:,1)));
    teta1 = teta1 +dteta(Ey(:,:,2) == min(Ey(:,:,2)));
    teta_decoder = teta1/4-pi