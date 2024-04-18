function [ E, xequat, yequat, zequat, Decl ] = EquaT( Y, M, D );
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

% The eccentric anomaly
E0 = M + ( 180 / pi ) * e * sin ( radians( M ) ) * ( 1 + e * cos( radians( M ) ) );

x = cos( radians( E0 ) ) - e;
y = sin( radians( E0 ) ) * sqrt( 1 - e * e );

% Distance and true anomaly
r = sqrt( x * x + y * y );
v = degrees( atan( y/x ) );
v = mod( v, 180 );

lon = v + w;
lon = mod( lon, 360 );

% Rectangular coordinates in the plane of the ecliptic
x = r * cos( radians( lon ) );
y = r * sin( radians( lon ) );
z = 0;

% Rectangular coordinates in the equatorial coordinates
xequat = x;
yequat = y * cos ( radians( oblecl ) );
zequat = y * sin ( radians( oblecl ) );

% Declinaison
Decl = degrees( asin( zequat / r ) );

% The eccentric anomaly
E0 = M + ( 180 / pi ) * e * sin ( radians( M ) ) * ( 1 + e * cos( radians( M ) ) );

% Equation du temps:
y = tan( radians( oblecl / 2 ) ) ^ 2;

% Radians
E = y * sin( radians( 2 * L0 ) ) - 2 * e * sin( radians( M ) ) ...
    + 4 * e * y * sin( radians( M ) ) * cos( radians( 2 * L0 ) )...
    - 0.5 * y * y * sin( radians( 4 * L0 ) ) - 1.25 * e * e * sin( radians( 2 * M ) );