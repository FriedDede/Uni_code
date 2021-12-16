function [alpha] = angolo(cosenoseno)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
if cosenoseno(2, 1) > 1
    cosenoseno(2, 1) = 1;
elseif cosenoseno(2, 1) < -1
    cosenoseno(2, 1) = -1;
end

if cosenoseno(1, 1) >= 0
    alpha = asin(cosenoseno(2, 1));
else
    alpha = pi-asin(cosenoseno(2, 1));
end    
end