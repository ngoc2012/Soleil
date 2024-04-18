function [ n, F, phiF, nor, dis ] = ReadF( fdxf )

data_line = 'read codes';

% NOMBRE DES FENETRES
n = 0;
F = 0;
phiF = 0;

while strcmp( data_line, 'EOF' ) == 0
    data_line = fgetl( fdxf );
    % S'IL EST UN POLYLINE
    if strcmp( data_line, 'LWPOLYLINE' ) == 1
        
        % QUAND IL EST ENCORE DANS CE RECTANGLE
        while strcmp( data_line, '  0' ) == 0
            data_line = fgetl( fdxf );
            % S'IL EST UNE FENETRE
            if strcmp( data_line, '  8' ) == 1
                data_line = fgetl( fdxf );
                if strcmp( data_line, 'Fenetre' ) == 1
                    % QUAND IL EST ENCORE DANS CE RECTANGLE
                    while strcmp( data_line, '  0' ) == 0
                        data_line = fgetl( fdxf );
                        if strcmp( data_line, ' 38' ) == 1
                            n = n + 1;
                            % DISTANCE
                            data_line = fgetl( fdxf );
                            dis( n ) = round( 100 * str2double( data_line ) ) / 100;
                            % COORDINATES DES NOEUDS DE LA FENETRE
                            data_line = fgetline( fdxf, 2 );
                            F( n, 1, 1 ) = round( 100 * str2double( data_line ) ) / 100;
                            data_line = fgetline( fdxf, 2 );
                            F( n, 1, 2 ) = round( 100 * str2double( data_line ) ) / 100;
                            data_line = fgetline( fdxf, 2 );
                            F( n, 2, 1 ) = round( 100 * str2double( data_line ) ) / 100;
                            data_line = fgetline( fdxf, 2 );
                            F( n, 2, 2 ) = round( 100 * str2double( data_line ) ) / 100;
                            data_line = fgetline( fdxf, 2 );
                            F( n, 3, 1 ) = round( 100 * str2double( data_line ) ) / 100;
                            data_line = fgetline( fdxf, 2 );
                            F( n, 3, 2 ) = round( 100 * str2double( data_line ) ) / 100;
                            data_line = fgetline( fdxf, 2 );
                            F( n, 4, 1 ) = round( 100 * str2double( data_line ) ) / 100;
                            data_line = fgetline( fdxf, 2 );
                            F( n, 4, 2 ) = round( 100 * str2double( data_line ) ) / 100;
                            % VECTOR NORMALE DE LA SURFACE
                            data_line = fgetline( fdxf, 2 );
                            nor( n, 1 ) = str2double( data_line );
                            data_line = fgetline( fdxf, 2 );
                            nor( n, 2 ) = str2double( data_line );
                            data_line = fgetline( fdxf, 2 );
                            nor( n, 3 ) = str2double( data_line );
                        end
                    end
                end
            end
        end
    end
end

Wy = [ 0, 1, 0 ];
Wz = [ 0, 0, 1 ];
for i = 1 : n
    
    % Arbitrary Axis Algorithm
    
    if ( abs( nor( i, 1 ) ) < 1/64 ) & ( abs( nor( i, 2 ) ) < 1/64 )
        Ax = cross( Wy, nor( i, : ) );
    else 
        Ax = cross( Wz, nor( i, : ) );
    end
    Ax = ( 1/ norm( Ax ) ) * Ax;
    Ay = cross( nor( i, : ), Ax );
    Ay = ( 1/ norm( Ay ) ) * Ay;
    
    for j = 1 : 4
         X = F( i, j, 1 ) * Ax + F( i, j, 2 ) * Ay;
         for m = 1 : 3
            F( i, j, m ) = X( m );
         end
    end
    
    nor( i, : ) = ( dis( i ) / abs( dis( i ) ) ) * nor( i, : );
    phiF( i ) = degrees( atan2( nor( i, 2 ), nor( i, 1 ) ) );
    phiF( i ) = round( phiF( i ) );
    [ F( i, :, 1 ), F( i, :, 2 ), F( i, :, 3 ) ] = rotateZ( F( i, :, 1 ), F( i, :, 2 ), F( i, :, 3 ), -phiF( i ) );
    for j = 1 : 4
        F( i, j, 1 ) = abs( dis( i ) );
    end
end