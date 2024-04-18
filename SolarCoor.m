function SolarCoor = SolarCoor( JD )
% Le temps de 1.5 Janvier 2000 ( an centaire )
T = ( JD - 2451545 ) / 36525
% The geometric mean longitude of the Sun referred to the mean equinox of
% the date:
L0 = 280.46645 + 36000.76983 * T + 0.0003032 * T * T
% The mean nomaly of the Sun
M = 357.52910 + 35999.05030 * T + 0.0001559 * T * T - 0.00000048 * T * T * T
% The eccentricity of the Earth's orbit
e = 0.016708617 - 0.000042037 * T - 0.0000001236 * T * T
% Sun's equation of center C
C = ( 1.914600 - 0.004817 * T - 0.000014 * T * T ) * sin( radians( M ) )...
    + ( 0.019993 - 0.000101 * T ) * sin ( radians( 2 * M ) ) + 0.000290 * sin( radians( 3 * M ) )
% The Sun's true longitude
ro = L0 + C
% The Sun's true anomaly
v = M + C;
% The Sun's radius vector
R = 1.000001018 * ( 1 - e * e ) / ( 1 + e * cos( radians ( v ) );
% The apparent longitude of the Sun
gamma = 125.04 - 1934.136261 * T + 0.0020708 * T * T + T * T * T / 450000;
landa = ro - 0.00569 - 0.00478 * sin( radians( gamma ) );
% The mean obliquity of the ecliptic ( in seconde )
epxi0 = - 46.8150 * T - 0.00059 * T * T + 0.001813 * T * T * T;
% depxi
L = 280.4665 + 36000.7698 * T;
Lp = 218.3165 + 481267.8813 * T;
depxi = 9.20 * cos( radians( gamma ) ) + 0.57 * cos( radians( 2 * L ) )...
    + 0.1 
% ( in degrees)
epxi = epxi0 / 3600 + 23 + 26 / 60 + 21.448 / 3600;
