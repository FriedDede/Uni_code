% init
    clear all;
    close all;
    clc;
    
%% metodo montecarlo
n_try = 10000;
d = randi(6,1,n_try);
ia = (d>2) & (d<6);
ib = (d>3);

iall = ia | ib;
pall = sum(iall)/n_try;
pall