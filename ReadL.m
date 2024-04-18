function L = ReadL( fdxf )
data_line = 'read codes';

n = 0;
L = 0;

while strcmp( data_line, 'EOF' ) == 0
    data_line = fgetl( fdxf );
    % S'IL EST UN POLYLINE
    if strcmp( data_line, 'LINE' ) == 1
        
        % QUAND IL EST ENCORE DANS CE RECTANGLE
        while strcmp( data_line, '  0' ) == 0
            data_line = fgetl( fdxf );
            % S'IL EST UNE DROITE
            if strcmp( data_line, '  8' ) == 1
                data_line = fgetl( fdxf );
                if strcmp( data_line, '0' ) == 1
                    % QUAND IL EST ENCORE DANS CETTE DROITE
                    while strcmp( data_line, '  0' ) == 0
                        data_line = fgetl( fdxf );
                        if strcmp( data_line, ' 10' ) == 1
                            n = n + 1;
                            % COORDINATES DES NOEUDS DE LA DROITE
                            data_line = fgetl( fdxf );
                            L( n, 1, 1 ) = str2double( data_line );
                            data_line = fgetline( fdxf, 2 );
                            L( n, 1, 2 ) = str2double( data_line );
                            data_line = fgetline( fdxf, 2 );
                            L( n, 1, 3 ) = str2double( data_line );
                            data_line = fgetline( fdxf, 2 );
                            L( n, 2, 1 ) = str2double( data_line );
                            data_line = fgetline( fdxf, 2 );
                            L( n, 2, 2 ) = str2double( data_line );
                            data_line = fgetline( fdxf, 2 );
                            L( n, 2, 3 ) = str2double( data_line );
                            data_line = fgetline( fdxf, 2 );
                        end
                    end
                end
            end
        end
    end
end