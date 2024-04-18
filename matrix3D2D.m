function matrix2D = matrix3D2D ( matrix3D, n )
len = size( matrix3D );
for i = 1 : len( 2 )
    for j = 1 : len( 3 )
        matrix2D( i, j ) = matrix3D(  n, i, j );
    end
end