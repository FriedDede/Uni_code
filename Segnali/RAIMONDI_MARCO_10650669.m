clear, clc, close all;

load("Problema_1.mat");

[righe, ~] = size(s);
dt = 1/Fs;
Toss = righe/Fs - dt;
t = 0 : dt : righe/Fs - dt;

%% Spettro di Potenza

% I segnali x(t) ed y(t) sono campionati a frequenza Fs. Ciò implica che lo
% spettro del segnale s(t) campionato abbia periodo Fs. Moltiplicati per 
% sinusoidi e cosinusoidi a frequenza f0, il loro spettro verrà traslato 
% della stessa quantità sia a favore che contro il verso dell'asse delle 
% frequenze.

df = 1/(20*Toss);
% B = 1/dt;
f = -Fs/2 : df : Fs/2;

S1 = fftshift(fft(s(:, 1), length(f)))*dt; %Trasformata del primo canale
S2 = fftshift(fft(s(:, 2), length(f)))*dt; %Trasformata del secondo canale

spettro1 = 1/Toss*(abs(S1).^2); %Stima del primo spettro
spettro2 = 1/Toss*(abs(S2).^2); %Stima del secondo spettro

figure;
subplot(2, 1, 1),
plot(f, spettro1), grid on,
xlabel("Frequenza [Hz]"), title("Spettro di potenza del primo canale");

subplot(2, 1, 2),
plot(f, spettro2), grid on,
xlabel("Frequenza [Hz]"), title("Spettro di potenza del secondo canale");

%% Check potenza primo canale

potenzatempo = 1/Toss*sum(abs(s(:, 1)).^2)*dt;
potenzafrequenze = sum(spettro1)*df;

%% Estrazione di x

h_fir1 = fir1(30, f0/Fs); %wn = f0/Fs;
% h_fir1 = 4*f0*sinc(2*f0*t);

x(:, 1) = transpose(s(:, 1))*2.*cos(2*pi*f0*t + teta);
x(:, 2) = transpose(s(:, 2))*2.*cos(2*pi*f0*t + teta);

xf = conv2(x,h_fir1(:),'same');

% filename = 'x.wav';
% audiowrite(filename,xf,Fs);

% soundsc(xf, Fs);

%% Check trasformata segnale filtrato x

df = 1/(5*Toss);
f = -Fs/2 : df : Fs/2;

figure;
subplot(2, 1, 1),
plot(f, abs(fftshift(fft(xf(:, 1), length(f)))*dt)), grid on,
xlabel("Frequenza [Hz]"), title("Modulo trasformata primo canale demodulato e filtrato");

subplot(2, 1, 2),
plot(f, abs(fftshift(fft(xf(:, 2), length(f)))*dt)), grid on,
xlabel("Frequenza [Hz]"), title("Modulo trasformata secondo canale demodulato e filtrato");

sgtitle("x(t)");

%% Estrazione di y

h_fir1 = fir1(30, f0/Fs); %wn = f0/Fs;
% h_fir1 = 4*f0*sinc(2*f0*t);

y(:, 1) = transpose(s(:, 1))*2.*(-sin(2*pi*f0*t + teta));
y(:, 2) = transpose(s(:, 2))*2.*(-sin(2*pi*f0*t + teta));

yf = conv2(y,h_fir1(:),'same')*dt;

% filename = 'y.wav';
% audiowrite(filename,yf,Fs);

% soundsc(yf, Fs);

%% Check trasformata segnale filtrato y

df = 1/(5*Toss);
f = -Fs/2 : df : Fs/2;

figure;
subplot(2, 1, 1),
plot(f, abs(fftshift(fft(yf(:, 1), length(f)))*dt)), grid on,
xlabel("Frequenza [Hz]"), title("Modulo trasformata primo canale demodulato e filtrato");

subplot(2, 1, 2),
plot(f, abs(fftshift(fft(yf(:, 2), length(f)))*dt)), grid on,
xlabel("Frequenza [Hz]"), title("Modulo trasformata secondo canale demodulato e filtrato");

sgtitle("y(t)");

%% Estrazione di x - Errore di theta

h_fir1 = fir1(30, f0/Fs); %wn = f0/Fs;
% h_fir1 = 4*f0*sinc(2*f0*t);

dteta = pi;

x(:, 1) = transpose(s(:, 1))*2.*cos(2*pi*f0*t + teta + dteta);
x(:, 2) = transpose(s(:, 2))*2.*cos(2*pi*f0*t + teta + dteta);

xf = conv2(x,h_fir1(:),'same');

% filename = 'x.wav';
% audiowrite(filename,xf,Fs);

% soundsc(xf, Fs);

%% Estrazione di y - Errore di theta

h_fir1 = fir1(30, f0/Fs); %wn = f0/Fs;
% h_fir1 = 4*f0*sinc(2*f0*t);

dteta = pi/4;

y(:, 1) = transpose(s(:, 1))*2.*(-sin(2*pi*f0*t + teta + dteta));
y(:, 2) = transpose(s(:, 2))*2.*(-sin(2*pi*f0*t + teta + dteta));

yf = conv2(y,h_fir1(:),'same');

% filename = 'mix.wav';
% audiowrite(filename,yf,Fs);

% soundsc(yf, Fs);

%% Estrazione di x - Errore di f0

h_fir1 = fir1(30, f0/Fs); %wn = f0/Fs;
% h_fir1 = 4*f0*sinc(2*f0*t);

df0 = 0.5;

x(:, 1) = transpose(s(:, 1))*2.*cos(2*pi*(f0 + df0)*t + teta);
x(:, 2) = transpose(s(:, 2))*2.*cos(2*pi*(f0 + df0)*t + teta);

xf = conv2(x,h_fir1(:),'same');

% filename = 'erroreinportante.wav';
% audiowrite(filename,xf,Fs);

% soundsc(xf, Fs);

%% Estrazione di y - Errore di f0

h_fir1 = fir1(30, f0/Fs); %wn = f0/Fs;
% h_fir1 = 4*f0*sinc(2*f0*t);

df0 = 0.5;

y(:, 1) = transpose(s(:, 1))*2.*(-sin(2*pi*(f0 + df0)*t + teta));
y(:, 2) = transpose(s(:, 2))*2.*(-sin(2*pi*(f0 + df0)*t + teta));

yf = conv2(y,h_fir1(:),'same');

% filename = 'erroreinportante.wav';
% audiowrite(filename,xf,Fs);

% soundsc(yf, Fs);

%% Estrazione di x e y con errori di fase e di portante

% Riparto da 0

clear, clc, close all;
load("Problema_1.mat");
[righe, colonne] = size(s);
dt = 1/Fs;
Toss = righe/Fs - dt;
t = 0 : dt : righe/Fs - dt;
df0max = 1;

h_fir1 = fir1(60, f0/Fs);
x(:, 1) = transpose(s(:, 1))*2.*cos(2*pi*f0*t + teta);
x(:, 2) = transpose(s(:, 2))*2.*cos(2*pi*f0*t + teta);
xf = conv2(x,h_fir1(:),'same');
y(:, 1) = transpose(s(:, 1))*2.*(-sin(2*pi*f0*t + teta));
y(:, 2) = transpose(s(:, 2))*2.*(-sin(2*pi*f0*t + teta));
yf = conv2(y,h_fir1(:),'same');

x = xf(1:100, :);
y = yf(1:100, :);
clear xf yf;

%Genero casualmente dei valori errati di portante (tra -1 Hz e 1 Hz) e fase
f0primo = f0 + 2*df0max*(rand([1, 1])-0.5);
df0 = f0primo - f0;
thetaprimo = teta + 2*pi*(rand([1, 1])-0.5);
dtheta = thetaprimo - teta;

condizione = 1 > 0;

while condizione

    %Demodulo e filtro con gli errori
    h_fir1 = fir1(60, f0primo/Fs);
    xnf(:, 1) = transpose(s(:, 1))*2.*cos(2*pi*f0primo*t + thetaprimo);
    xnf(:, 2) = transpose(s(:, 2))*2.*cos(2*pi*f0primo*t + thetaprimo);
    xR = conv2(xnf,h_fir1(:),'same');
    ynf(:, 1) = transpose(s(:, 1))*2.*(-sin(2*pi*f0primo*t + thetaprimo));
    ynf(:, 2) = transpose(s(:, 2))*2.*(-sin(2*pi*f0primo*t + thetaprimo));
    yR = conv2(ynf,h_fir1(:),'same');
    
    %Stima dtheta
    cosenoseno = [x(1, 1), y(1, 1); y(1, 1), -x(1, 1)]\[xR(1, 1); yR(1, 1)];
    dthetastim = angolo(cosenoseno);
    
    %Stima df0
    
    % somma = 0;
    % for tempo = 2:100
    %     for canale = 1:2
    %         somma = somma + tempo*f_stima_df0(x, y, xR, yR, t, df0max, dthetastim, tempo, canale);
    %     end
    % end
    % 
    % df0stimsomma = somma/10098;
    
    df0stim = f_stima_df0(x, y, xR, yR, t, df0max, dthetastim, 100, 1);
    
    f0primo = f0primo - df0stim;
    thetaprimo = thetaprimo - dthetastim;

    condizione = sum(abs(xR(1:100, 1) - x(:, 1))) > 1e-5;

end

%Demodulo correttamente
h_fir1 = fir1(60, (f0primo-df0stim)/Fs);
xnf(:, 1) = transpose(s(:, 1))*2.*cos(2*pi*f0primo*t + thetaprimo);
xnf(:, 2) = transpose(s(:, 2))*2.*cos(2*pi*(2*pi*f0primo*t + thetaprimo));
xcorretto = conv2(xnf,h_fir1(:),'same');
ynf(:, 1) = transpose(s(:, 1))*2.*(-sin(2*pi*f0primo*t + thetaprimo));
ynf(:, 2) = transpose(s(:, 2))*2.*(-sin((2*pi*f0primo*t + thetaprimo)));
ycorretto = conv2(ynf,h_fir1(:),'same');

% soundsc(ycorretto, Fs);