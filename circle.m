function [X, Y, Z] = circle(x,y,z,r,n)

T = 0:2*pi/n:2*pi;
R=r*ones(1,length(T));

[X,Y]=pol2cart(T,R);

for i=1:length(X)
    X(i) = X(i) + x;
    Y(i) = Y(i) + y;
end

Z = z*ones(1,length(X));