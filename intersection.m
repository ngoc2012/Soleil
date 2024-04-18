function inter = intersection( p1, p2, q1, q2 )
inter = 1;
[ ival, p ] = lines_exp_int_2d ( p1, p2, q1, q2 );
if isempty(p) == 0
    if dot( p-p1, p-p2 ) > 0
        inter = 0;
    end
end