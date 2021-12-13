function vetout = mydec2bit(vetin,nb)
% function vetout = mydec2bit(vetin)
if nargin < 2
    nb = 8;
end
B = dec2bin(vetin,nb);
[Ns, Nc] = size(B);
Bs = B(:,Nc-nb+1:Nc)';
vetout = uint8(Bs-char('0'));
vetout = vetout(:);
end

