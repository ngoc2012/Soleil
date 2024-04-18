function [ YP, ZP, LP, ival ] = projectX ( X, Y, Z, F, R, n, i )
ival = 0;
LP = 0;
YP = R*Y/X;
ZP = R*Z/X;
if mod(i-1,n) == 0
    if i-1 ~= 0
        LP = (i-1)/n;
    end
else
    LP = 0;
end
if YP <= max(F(:,2)) && YP >= min(F(:,2)) && ZP <= max(F(:,3)) && ZP >= min(F(:,3))
    ival = 1;
end