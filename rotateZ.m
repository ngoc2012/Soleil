function [X,Y,Z] = rotateZ(X0,Y0,Z0,phi)
phi = radians( phi );
% Matrix de transformation
MT = [cos(phi) sin(phi) 0 0;
     -sin(phi) cos(phi) 0 0;
     0 0 1 0;
     0 0 0 1 ];
% Rotate la circle
for i=1:length(X0)
	abc = [X0(i) Y0(i) Z0(i) 1]*MT;
    X(i)=abc(1);
    Y(i)=abc(2);
    Z(i)=abc(3);
end