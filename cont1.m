function [ Xb, Yb ] = cont1( Fo, phiX, phiZ, phiF, x1, y1, z1, z, YP2, ZP2, YP3, ZP3, VT )

feX = [];
feY = [];
VT1 = [ Fo( 1, 1 ) - x1 min( Fo( :, 2 ) ) - y1 0 ];
Zc1 = checkin( VT, VT1, 23.4394 );
if Zc1 == 1
    feX = [feX min( Fo( :, 2 ) )];
    feY = [feY z];
end
VT1 = [ Fo( 1, 1 ) - x1 min( Fo( :, 2 ) ) - y1 max( Fo( :, 3 ) ) - z1 ];
Zc1 = checkin( VT, VT1, 23.4394 );
if Zc1 == 1
    feX = [feX min( Fo( :, 2 ) )];
    feY = [feY max( Fo( :, 3 ) )];
end
VT1 = [ Fo( 1, 1 ) - x1 max( Fo( :, 2 ) ) - y1 max( Fo( :, 3 ) ) - z1 ];
Zc1 = checkin( VT, VT1, 23.4394 );
if Zc1 == 1
    feX = [feX max( Fo( :, 2 ) )];
    feY = [feY max( Fo( :, 3 ) )];
end
VT1 = [ Fo( 1, 1 ) - x1 max( Fo( :, 2 ) ) - y1 0 ];
Zc1 = checkin( VT, VT1, 23.4394 );
if Zc1 == 1
    feX = [feX max( Fo( :, 2 ) )];
    feY = [feY z];
end

Xbo = [YP2 fliplr(YP3) feX];
Ybo = [ZP2 fliplr(ZP3) feY];

k = convhull( Xbo, Ybo );

Xb = Xbo(k);
Yb = Ybo(k);