function [ n, F, phiF, L ] = ReadDXF()
clc
[ f0, fpath ] = uigetfile( '*.dxf', 'Choisissez votre DXF file *.dxf' );
filename = strcat( fpath, f0 );
fdxf = fopen( filename, 'r' );

[ n, F, phiF, nor, dis ] = ReadF( fdxf );

% CHANGER LES POSITIONS
F = orderF1( F );

for i = 1 : n
    F( i, 5, : ) = F( i, 1, : );
end

fclose( fdxf );

fdxf = fopen( filename, 'r' );
L = ReadL( fdxf );
fclose( fdxf );
% clear