function matrix3D = matrix2D3D ( matrix2D, n )
len = size( matrix2D );
for i = 1 : len( 1 )
    for j = 1 : len( 2 )
        matrix3D(  n, i, j ) = matrix2D( i, j );
    end
end