function vetout = mybit2dec(vetin,nbits)
% function vetout = mybit2dec2(vetin[,nbits])
if nargin < 2 
    nbits = 8;
end
Nt = numel(vetin);
tmp = reshape(vetin,[nbits, Nt/nbits]);
tmp1 = tmp>0;
C = reshape(char(tmp1+'0'),size(tmp1))';
vetout=uint8(bin2dec(C));
end