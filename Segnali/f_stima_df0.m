function [df0stim] = f_stima_df0(x, y, xR, yR, t, df0max, dthetastim, tempo, canale)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
cosenoseno = [x(tempo,canale), y(tempo,canale); y(tempo,canale), -x(tempo,canale)]\[xR(tempo,canale); yR(tempo,canale)];

if tempo - 1 < 1
    tempocfr = tempo + 1;
else
    tempocfr = tempo - 1;
end


if t(tempo) > 1/df0max
    df0stim1 = (angolo(cosenoseno) - dthetastim)/(2*pi*t(tempo));
    df0stim2 = -2*pi + df0stim1;
    df0stim3 = 2*pi + df0stim1;

    if xR(tempo,canale) - x(tempo,canale)*cos(2*pi*df0stim1*t(tempo) + dthetastim) - y(tempo,canale)*sin(2*pi*df0stim1*t(tempo) + dthetastim) < 1e-4
        df0stim = df0stim1;
    elseif xR(tempo,canale) - x(tempo,canale)*cos(2*pi*df0stim2*t(tempo) + dthetastim) - y(tempo,canale)*sin(2*pi*df0stim2*t(tempo) + dthetastim) < 1e-4
        df0stim = df0stim2;
    else
        df0stim = df0stim3;
    end
    
elseif dthetastim < -pi + 2*pi*df0max*t(tempo)
    df0stim1 = 1/(2*pi*t(tempo))*(angolo(cosenoseno) - dthetastim);
    df0stim2 = -2*pi + df0stim1;

    if xR(tempocfr,canale) - x(tempocfr,canale)*cos(2*pi*df0stim1*t(tempocfr) + dthetastim) - y(tempocfr,canale)*sin(2*pi*df0stim1*t(tempocfr) + dthetastim) < 1e-4
        df0stim = df0stim1;
    else
        df0stim = df0stim2;
    end

elseif dthetastim > pi - 2*pi*df0max*t(tempo)
    df0stim1 = 1/(2*pi*t(tempo))*(angolo(cosenoseno) - dthetastim);
    df0stim2 = 2*pi + df0stim1;

    if xR(tempocfr,canale) - x(tempocfr,canale)*cos(2*pi*df0stim1*t(tempocfr) + dthetastim) - y(tempocfr,canale)*sin(2*pi*df0stim1*t(tempocfr) + dthetastim) < 1e-4
        df0stim = df0stim1;
    else
        df0stim = df0stim2;
    end

else
    df0stim = (angolo(cosenoseno) - dthetastim)/(2*pi*t(tempo));
end
end