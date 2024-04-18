function x = remeshgrid( X )
n=0;
for i = 1 : size(X,1)
    for j = 1 : size(X,2)
        n = n + 1;
        x(n) = X(i,j);
    end
end