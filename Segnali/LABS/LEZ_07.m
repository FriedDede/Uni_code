%% V.C: correlate (Gaussiane)
Ntry = 9000;
% dipendenza lineare
k = 2; 
xax = [-3 3]; yline = k*xax;
% aggiungo rumore
snr = 0.001;
x = randn(1,Ntry);
w = randn(1,Ntry)/sqrt(snr);
y = k*(x + w); 
% scatter plot
figure(1)
plot(x,y,'o',xax,yline,'r'); xlabel('X'); ylabel('Y'); grid
% segnale
rho = 1/sqrt(1+1/snr)*sign(k);
rhoest = x*y' / sqrt( (x*x')*(y*y'));
title(['\rho:' num2str(rho), ', estimated:' num2str(rhoest)])
figure(2)
subplot(211); plot(1:Ntry,x,'-o'); ylabel('X')
subplot(212); plot(1:Ntry,y,'-+'); ylabel('Y')
figure(3)

h=histogram2(x',y',30);
