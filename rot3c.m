function [X,Y,Z] = rot3c( R, phiX, phiZ, phiL, phiT, n )
[ X, Y, Z ] = circle( 0, 0, R*sin(phiT), R*cos(phiT) ,n );
[ X, Y, Z ] = rotateZ( X, Y, Z, phiL );
[ X, Y, Z ] = rotateY( X, Y, Z, phiX );
[ X, Y, Z ] = rotateZ( X, Y, Z, phiZ);