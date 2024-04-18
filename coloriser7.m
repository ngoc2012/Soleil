function coloriser7( Fo, phiX, phiZ, phiF, x, y, z, YP2, ZP2, YP3, ZP3 );

h = [];
for i = 1 : length(ZP2)
    if ZP2(i) < z
        h = [h i];
    end
end
ZP2( h ) = [];
YP2( h ) = [];

h = [];
for i = 1 : length(ZP3)
    if ZP3(i) < z
        h = [h i];
    end
end
ZP3( h ) = [];
YP3( h ) = [];

if length(YP2) > 1
    [ YP2(1) ZP2(1) ] = fenetre( Fo, z, YP2(1), ZP2(1) );
    [ YP2(length(YP2)) ZP2(length(YP2)) ] = fenetre( Fo, z, YP2(length(YP2)), ZP2(length(YP2)) );
end

if length(YP3) > 1
    [ YP3(1) ZP3(1) ] = fenetre( Fo, z, YP3(1), ZP3(1) );
    [ YP3(length(YP3)) ZP3(length(YP3)) ] = fenetre( Fo, z, YP3(length(YP3)), ZP3(length(YP3)) );
end

% FENETRE
[ x1, y1, z1 ] = rotateZ( x, y, z, -phiF );
%VECTEUR NORMAL A L'ORIGINE DE LA SURFACE DE L'EQUATION
[ VT(1) VT(2) VT(3) ] = rotateY( 0, 0, 1, phiX );
[ VT(1) VT(2) VT(3) ] = rotateZ( VT(1), VT(2), VT(3), phiZ );
[ VT(1) VT(2) VT(3) ] = rotateZ( VT(1), VT(2), VT(3), -phiF );

[ Xb, Yb ] = cont1( Fo, phiX, phiZ, phiF, x1, y1, z1, z, YP2, ZP2, YP3, ZP3, VT );

fin = 0.5;
[ Xc, Yc ] = meshgrid( min(Fo(:,2)) : fin : max(Fo(:,2)), z : fin : max(Fo(:,3)) );
    
ind = inpolygon( Xc, Yc, Xb, Yb );

Xcp = Xc(ind);
Ycp = Yc(ind);

% CHERCHER LES POINTS HORS DE JEU
h = [];
for i = 1 : length(Xcp)    
    VT1 = [ Fo( 1, 1 )-x1 Xcp( i )-y1 Ycp( i )-z1 ];
    Zcc1 = checkin( VT, VT1, 23.4394 );
    if Zcc1 == 0
        h = [h i];
    end
end
Xcp( h,: ) = [];
Ycp( h,: ) = [];

% LIER LES CONTOURS
if length(YP3) == 1,
    YP3 = [];
    ZP3 = [];
end
if length(YP2) == 1,
    YP2 = [];
    ZP2 = [];
end
Xcp = [ Xcp' YP2 YP3 ]';
Ycp = [ Ycp' ZP2 ZP3 ]';

tri = delaunay( Xcp, Ycp );

len = size(tri);
lenX = size(Xcp);
h = [];
for i = 1 : len(1)
    for j = 1 : len(2)
        cot(j) = floor( tri(i,j) / lenX(1) ) + 1;
        hang(j) = mod( tri(i,j), lenX(1) );
        if hang(j) == 0
            hang(j) = lenX(1);
        end
        if cot(j) > lenX(2)
            cot(j) = lenX(2);
        end 
    end
    VT1 = [ Fo( 1, 1 )-x1 Xcp( hang(1), cot(1) )/3+Xcp( hang(2), cot(2) )/3+Xcp( hang(3), cot(3) )/3-y1 Ycp( hang(1), cot(1) )/3+Ycp( hang(2), cot(2) )/3+Ycp( hang(3), cot(3) )/3-z1 ];
    Zcc1 = checkin( VT, VT1, 23.4394 );
    if Zcc1 == 0
        h = [h i];
    end
    
end

tri( h,: ) = [];
    
len = length(Xcp);
V1 = [ ( Fo(1,1) - x1 ) 0 0 ];
for i = 1 : length(Xcp)   
    V2 = [ ( Fo(1,1) - x1 ) ( Xcp( i ) - y1 ) ( Ycp( i ) - z1 ) ];
    Zc( i ) = 1 - dot( V1, V2 ) / ( norm(V1) * norm(V2) );
end

triplot( tri, Xcp, Ycp, 'r' )

trisurf( tri, Xcp, Ycp, Zc, 'Tag', 'chaleur' )
chaleur = findobj( gcf, 'tag', 'chaleur' );
alpha( chaleur, 0.6 )
colormap(autumn)
shading interp