% ROTATION AUTOUR DE L'AXE X A L'ORIGIN
function [ X, Y, Z ] = rotateX( X0, Y0, Z0, phi )
phi = pi * phi / 180; 
% Matrix de transformation
MT = [cos(phi) 0 -sin(phi) 0;
      0 1 0 0;
      sin(phi) 0 cos(phi) 0;
      0 0 0 1];
% Rotate la circle
for i=1:length(X0)
	abc=[X0(i) Y0(i) Z0(i) 1]*MT;
    X(i) = abc(1);
    Y(i) = abc(2);
    Z(i) = abc(3);
end