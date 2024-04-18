function X = cd2jd( Y, M, D )
if M < 3
   M = M + 12;
   Y = Y - 1; 
end
A = floor( Y / 100 );
B = 2 - A + floor( A / 4 );
X = floor( 365.25 * ( Y + 4716) ) + floor( 30.6 * ( M + 1 ) ) + D + B - 1524.5;