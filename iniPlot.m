function R = iniPlot( phiX, phiZ, phiT, F, phiF, n, nF, L );

% AXIS DE LA FIGURE
XMAX = 0;
YMAX = 0;
ZMAX = 0;
XMIN = 0;
YMIN = 0;
ZMIN = 0;
for i = 1 : nF
    XMAX = max( max( F( i, :, 1 ) ), XMAX );
    YMAX = max( max( F( i, :, 2 ) ), YMAX );
    ZMAX = max( max( F( i, :, 3 ) ), ZMAX );
    XMIN = min( min( -F( i, :, 1 ) ), XMIN );
    YMIN = min( min( F( i, :, 2 ) ), YMIN );
    ZMIN = min( min( F( i, :, 3 ) ), ZMIN );
end
len = size( L );
for i = 1 : len( 1 )
    XMAX = max( max( L( i, :, 1 ) ), XMAX );
    YMAX = max( max( L( i, :, 2 ) ), YMAX );
    ZMAX = max( max( L( i, :, 3 ) ), ZMAX );
    XMIN = min( min( -L( i, :, 1 ) ), XMIN );
    YMIN = min( min( L( i, :, 2 ) ), YMIN );
    ZMIN = min( min( L( i, :, 3 ) ), ZMIN );
end

R =  min( [ XMAX - XMIN, YMAX - YMIN, ZMAX - ZMIN ] )  / 10;

% CIRCLE DE L'EQUATEUR
[ X1, Y1, Z1 ] = rot3c( R, phiX, phiZ, 0, 0, n );
plot3(X1,Y1,Z1,'k','tag','Equa');
axis equal
axis([XMIN XMAX YMIN YMAX ZMIN ZMAX]);
% axis auto
% grid on
hold;

% PLOT LES DROITE DE LA MAISON
for i = 1 : len(1)
    plot3( L( i, :, 1 ), L( i, :, 2 ), L( i, :, 3 ), 'Color', [0.5019607843137255 0.25098039215686274 0.25098039215686274] );
end

% CIRCLE DU TROPIQUE DE CANCER
[X2,Y2,Z2] = rot3c( R, phiX, phiZ, 0, phiT, n );
plot3(X2,Y2,Z2,'tag','Cancer');

% CIRCLE DU TROPIQUE DE CAPICONE
[X3,Y3,Z3] = rot3c( R, phiX, phiZ, 0, -phiT, n );
plot3(X3,Y3,Z3,'m','tag','Capi');

% LES ARROWS DE 4 DIRECTIONS
Arrows( 2*R, 0, 0, 0, phiZ );
for i = 1 : nF
    F2D = matrix3D2D ( F, i ); %------------------------
    % PROJECTION DES CIRCLES SUR LA FENETRE
    P = pEquateur( R, phiX, phiZ , F2D, phiF( i ) );
    [ XP2, YP2, ZP2, LP2 ] = pTropique( X2, Y2, Z2, F2D, phiF ( i ) );
    [ XP3, YP3, ZP3, LP3 ] = pTropique ( X3, Y3, Z3, F2D, phiF( i ) );
    if length(P(:,1))>1
        str = strcat( 'pEqua', num2str( i ) );
        plot3( P(:,1), P(:,2), P(:,3), 'k', 'tag', str );
    end
    if length( XP2 ) > 1
        str = strcat( 'pCancer', num2str( i ) );
        plot3( XP2, YP2, ZP2, 'tag', str );
    end
    if length( XP3 ) > 1
        str = strcat( 'pCapi', num2str( i ) );
        plot3( XP3, YP3, ZP3, 'm', 'tag', str);
    end

    % PROJECTION DES MERIDIAN SUR LA FENETRE
    [Xh,Yh,Zh,Lh] = pMeridian(X2,Y2,Z2,X3,Y3,Z3,XP2,YP2,ZP2,LP2,XP3,YP3,ZP3,LP3,phiF( i ), F2D, P );
    str = strcat( 'pMeridian', num2str( i ) );
    line( Xh, Yh, Zh, 'color', 'g', 'tag', str );

    % PLOT DES FENETRES
    FB = [ F2D( 1, 1 ) min( F2D( :, 2 ) ) 0 ; F2D( 1, 1 ) max( F2D( :, 2 ) ) 0 ];
    [ F2D( :, 1 ), F2D( :, 2 ), F2D( :, 3 ) ] = rotateZ( F2D( :, 1 ), F2D( :, 2 ), F2D( :, 3 ), phiF( i ) );
    [ FB( :, 1 ), FB( :, 2 ), FB( :, 3 )] = rotateZ( FB( :, 1 ), FB( :, 2 ), FB( :, 3 ), phiF( i ) );
    plot3( F2D( :, 1 ), F2D( :, 2 ), F2D( :, 3 ), 'k' );
    str = strcat( 'FenetreP', num2str( i ) ); % TAG DE LA FENETRE
    PatchF( F2D, FB, str );
    
    % NOM DE LA FENETRE
    txtF = ( F2D( 2, : ) + F2D( 3, : ) ) / 2;
    str = strcat( 'Fenetre - ', num2str( i ) ); 
    text( txtF( 1 ), txtF( 2 ), txtF( 3 ), str )
end
gca;
axis off