function F = orderF1( F0 )
len = size( F0 );
for j = 1 : len( 1 )
    CY = sum( F0( j, :, 2 ) ) / 4;
    CZ = sum( F0( j, :, 3 ) ) / 4;

for i = 1 : len( 2 )
    if F0( j, i, 2 ) > CY && F0( j, i, 3 ) < CZ
        F( j, 1, : ) = F0( j, i, : );
    end
    if F0( j, i, 2 ) > CY && F0( j, i, 3 ) > CZ
        F( j, 2, : ) = F0( j, i, : );
    end
    if F0( j, i, 2 ) < CY && F0( j, i, 3 ) > CZ
        F( j, 3, : ) = F0( j, i, : );
    end
    if F0( j, i, 2 ) < CY && F0( j, i, 3 ) < CZ
        F( j, 4, : ) = F0( j, i, : );
    end
end

end