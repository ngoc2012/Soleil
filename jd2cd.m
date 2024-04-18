function [ Day, M, Y ] = jd2cd( JD )
Z = floor( JD + 0.5 );
F = mod( JD + 0.5, 1 );
if Z < 2299161
    A = Z;
else
    alpha = floor( ( Z - 1867216.25 ) / 36524.25 );
    A = Z + 1 + alpha - floor ( alpha / 4 );
end
B = A + 1524;
C = floor( ( B - 122.1 ) / 365.25 );
D = floor( 365.25 * C );
E = floor( ( B - D ) / 30.6001 );
Day = B - D - floor( 30.6001 * E ) + F;
if E < 14
    M = E - 1;
else
    M = E - 13;
end
if M > 2
    Y = C - 4716;
else
    Y = C - 4715;
end