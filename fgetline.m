function data_line = fgetline( fdxf, n )
for i = 1 : n
    data_line = fgetl( fdxf );
end