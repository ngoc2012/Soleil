function [ A ] = findL( F )
x = min( F( :, 3 ) );
n = 0;
for i = 1 : 4
    if F( i, 3 ) == x
        n = n + 1;
        A( n ) = i;
    end
end