function [ X, Y, Z ] = transZ( X0, Y0, Z0, z )
X = X0;
Y = Y0;
for i = 1:length(Z0)
    Z(i) = Z0(i) + z;
end