function [ E, Decl ] = EquaT1( Y, M, D );
JD = cd2jd( Y, M, D );
d = JD - 2451543.5;
% Longitude of perihelion
w = 282.9404 + 4.70935E-5 * d;
% eccentricity
e = 0.016709 - 1.151E-9 * d;
% mean anomaly
M = 356.0470 + 0.9856002585 * d;
% M = mod( abs( M ), 360 )
M = mod( M , 360 );
% Sun's mean longitude
L0 = w + M;
L0 = mod( L0 , 360 );
% Obliquity of the ecliptic
oblecl = 23.4393 - 3.563E-7 * d;

% Sun's equation of center C
T = ( JD - 2451545 ) / 36525;
C = ( 1.914600 - 0.004817 * T - 0.000014 * T * T ) * sin( radians( M ) )...
    + ( 0.019993 - 0.000101 * T ) * sin ( radians( 2 * M ) ) + 0.000290 * sin( radians( 3 * M ) );
% Sun's true longitude
ro = L0 + C;

% Declinaison
Decl = degrees( asin( sin( radians( oblecl ) ) * sin( radians( ro ) ) ) );

% Equation du temps:
y = tan( radians( oblecl / 2 ) ) ^ 2;

% Radians
E = y * sin( radians( 2 * L0 ) ) - 2 * e * sin( radians( M ) ) ...
    + 4 * e * y * sin( radians( M ) ) * cos( radians( 2 * L0 ) )...
    - 0.5 * y * y * sin( radians( 4 * L0 ) ) - 1.25 * e * e * sin( radians( 2 * M ) );