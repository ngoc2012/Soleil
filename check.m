function [ival,n] = check(A,b)
ival = 0;
n = 0;
for i = 1:length(A)
    if b==A(i)
        ival = 1;
        n = i;
        break;
    end
end