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