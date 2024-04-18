function phi = atan2( y, x )
phi = round( degrees( atan( y / x ) ) );
if x == 0 && y < 0, phi = -90; , end
if x == 0 && y > 0, phi = 90; , end
if y == 0 && x < 0, phi = 180; , end
if y == 0 && x > 0, phi = 0; , end