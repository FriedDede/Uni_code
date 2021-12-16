%% initial

clc;
clear;

load('Problema_1');

N=length(s);

dt = 1/Fs;
df=Fs/N;

Toss=dt*N;

t = (0:dt:Toss-dt);
f = (-Fs/2:df:Fs/2);

sl = s(:,1);
sr = s(:,2);

%soundsc(s,Fs)

%%

% Fourier transformation of the signal


Sl = fftshift(fft(sl, length(f),1))*dt; 
Sr = fftshift(fft(sr, length(f),1))*dt; 

% Power spectral density

Sxl = (1/Toss).*(abs(Sl)).^2;

Sxr = (1/Toss).*(abs(Sr)).^2;

figure;

subplot (2,1,1)
plot(f,Sxl);
xlabel('Frequence [Hz]');
grid on;
title('Left channel power spectral density');

subplot (2,1,2);
plot(f,Sxr);
xlabel('Frequence [Hz]');
grid on;
title('Right channel power spectral density');


% Demodulation

demod_filter_order = 30;   %demodulating filter order
demod_filter_cutoff = f0;%[Hertz]demodulating frequency
sxdemod= zeros(N,2);
sydemod= zeros(N,2);

h_fir1 = fir1(demod_filter_order, f0/(Fs));

for jj = 1:N
    for k = 1:2
        sxdemod(jj,k) = s(jj,k) .*2*cos(2*pi*f0*t(jj) + teta);
        sydemod(jj,k) = s(jj,k) .*2*sin(2*pi*f0*t(jj) + teta);
    end
end

sxdemod_filt = conv2(sxdemod,h_fir1(:),'same');
sydemod_filt = conv2(sydemod,h_fir1(:),'same');

%soundsc(sydemod_filt,Fs)

%% Phase error teta1=teta+dteta dteta = [-pi,pi]

dteta = rand*(2*pi)-pi;

sxdemod_perror= zeros(N,2);
sydemod_perror= zeros(N,2);

teta1 = teta+dteta;

for jj = 1:N
    for k = 1:2
        sxdemod_perror(jj,k) = s(jj,k) .*2*cos(2*pi*f0*t(jj) + teta1);
        sydemod_perror(jj,k) = s(jj,k) .*2*sin(2*pi*f0*t(jj) + teta1);
    end
end

sxdemod_perror_filt = conv2(sxdemod_perror,h_fir1(:),'same');
sydemod_perror_filt = conv2(sydemod_perror,h_fir1(:),'same');

%soundsc(sxdemod_perror_filt,Fs)

%% carrier frequency error fc=f0+deltaf deltaf = [-1,1]

deltaf = rand*(2)-1;

fc = f0+deltaf;

sxdemod_ferror= zeros(N,2);
sydemod_ferror= zeros(N,2);

for jj = 1:N
    for k = 1:2
        sxdemod_ferror(jj,k) = s(jj,k) .*2*cos(2*pi*fc*t(jj) + teta);
        sydemod_ferror(jj,k) = s(jj,k) .*2*sin(2*pi*fc*t(jj) + teta);
    end
end

sxdemod_ferror_filt = conv2(sxdemod_ferror,h_fir1(:),'same');
sydemod_ferror_filt = conv2(sydemod_ferror,h_fir1(:),'same');

%soundsc(sxdemod_ferror_filt,Fs)


%% Signal modulated with errors

sx_mod_errors= zeros(N,2);
sy_mod_errors= zeros(N,2);

for jj = 1:N
    for k = 1:2
        sx_mod_errors(jj,k) = sxdemod_filt(jj,k).*cos(2*pi*fc*t(jj) + teta1);
        sy_mod_errors(jj,k) = sydemod_filt(jj,k).*sin(2*pi*fc*t(jj) + teta1);
    end
end

s_errors = sx_mod_errors - sy_mod_errors;

%soundsc(s_errors,Fs)

%% Find carrier frequency shift

%execute Fourier transform
[F_s,f] = dft(s_errors, t, Fs);

%shrinks down spectrum to just positive frequencies
Transform_axis_temp = F_s((length(F_s) ./ 2):length(F_s));
freq_axis_temp = f((length(f) ./ 2):length(f));

%half transform plot
 figure, plot(freq_axis_temp,abs(Transform_axis_temp)), grid
 xlabel('frequenza [Hz]'), title('abs(Transform_axis_temp)')

%initialize result array
f_result = zeros(2,1); 
for jj = 1:2
    %find max peak
    [max_peak_value,max_peak_pos] = max(abs(Transform_axis_temp));
    %save found frequency peak
    f_result(jj) = freq_axis_temp(max_peak_pos);
    %after saving peak, delete it so next peak can be found
    Transform_axis_temp(max_peak_pos) = 0; 
end
%select half distance between the two peaks
f1 = ( f_result(1) + f_result(2) ) ./2;
disp('%%%%%%%%%%%%%%');
disp('modulating frequency found:')
disp(f1);
disp('%%%%%%%%%%%%%%');


%% Find Phase shift

theta_start = teta*180/pi - 180;  %degrees, 
theta_end   = teta*180/pi + 180;  %degrees, 
theta_res   = 10;  %num of samples per degree, 


theta_iter_num = floor( ( theta_end - theta_start ) .* theta_res  +1);
theta_step = 1 ./ theta_res;

%DEMOD AND ENERGY CALCULATION
demod_s = zeros (N,1);
energy_iter = zeros(theta_iter_num,1);
energy_iter_axis = zeros(theta_iter_num,1);

demod_cos= zeros(N,2);

for theta_iter = 1:theta_iter_num
    %%demod by multiplying with cos or sin (filtering is not essential to theta)
    for jj = 1:N
            demod_cos(jj,1) = s_errors(jj,1) .*2*cos(2*pi*fc*t(jj) + (((theta_start + ( theta_iter -1) .* theta_step )* pi) ./180));
    end 

    %calculate energy then save it to array
    energy_iter(theta_iter,1) = sum((abs(demod_cos(:,1)).^2));
    energy_iter_axis (theta_iter)= (theta_start + ( theta_iter -1) .* theta_step );
end
[energy_out,theta_max] = max(energy_iter(:,1));%use min to find lowest energy theta
theta_max_out = theta_start +( theta_max - 1) .* theta_step;
disp('found theta:')
disp(theta_max_out);


%% Demodulation with new phase and frequency

tetan = theta_max_out*pi/180;

sxdemod_errors_new= zeros(N,2);
sydemod_errors_new= zeros(N,2);

for jj = 1:N
    for k = 1:2
        sxdemod_errors_new(jj,k) = s_errors(jj,k) .*2*cos(2*pi*f1*t(jj) + tetan);
        sydemod_errors_new(jj,k) = s_errors(jj,k) .*2*sin(2*pi*f1*t(jj) + tetan);
    end
end

hn_fir1 = fir1(demod_filter_order, f1/(Fs));

sxdemod_errors_filt_new = conv2(sxdemod_errors_new,hn_fir1(:),'same');
sydemod_errors_filt_new = conv2(sydemod_errors_new,hn_fir1(:),'same');

soundsc(sxdemod_errors_filt_new,Fs)



