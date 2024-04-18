function [ X, Y, Z ] = transXYZ( X0, Y0, Z0, x, y, z )
X = X0;
Y = Y0;
Z = Z0;
if x ~= 0 || y ~= 0 || z ~= 0
    for i = 1:length(X0)
        if x ~= 0, X(i) = X0(i) + x;, end
        if y ~= 0, Y(i) = Y0(i) + y;, end
        if z ~= 0, Z(i) = Z0(i) + z;, end
    end
end