function sinc = sincFST(t)
%SINCFST Summary of this function goes here
%   sinc(t)
sinc = sin(pi*t)./(pi*t);
sinc(t==0)=1;
end

