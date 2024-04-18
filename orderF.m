function F = orderF( F0 )
len = size( F0 );
for j = 1 : len( 1 )
    
minYF = min( F0( j, :, 2 ) );
minZF = min( F0( j, :, 3 ) );
maxYF = max( F0( j, :, 2 ) );
maxZF = max( F0( j, :, 3 ) );

for i = 1 : len( 2 )
    if F0( j, i, 2 ) == maxYF && F0( j, i, 3 ) == minZF 
        F( j, 1, : ) = F0( j, i, : );
    end
    if F0( j, i, 2 ) == maxYF && F0( j, i, 3 ) == maxZF
        F( j, 2, : ) = F0( j, i, : );
    end
    if F0( j, i, 2 ) == minYF && F0( j, i, 3 ) == maxZF
        F( j, 3, : ) = F0( j, i, : );
    end
    if F0( j, i, 2 ) == minYF && F0( j, i, 3 ) == minZF
        F( j, 4, : ) = F0( j, i, : );
    end
end

end