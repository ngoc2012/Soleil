function sPlot = sPlot(R, F, phiX, phiZ, phiL, phiT, phiF, x, y, z, n, nF)

% LES CIRCLES AVANT TRANSLATION
[X1, Y1, Z1] = rot3c( R, phiX, phiZ, phiL, 0, n );
[X2, Y2, Z2] = rot3c( R, phiX, phiZ, phiL, phiT, n );
[X3, Y3, Z3] = rot3c( R, phiX, phiZ, phiL, -phiT, n );

% LES ARROWS DE 4 DIRECTIONS
Arrows ( 2 * R, x, y, z, phiZ );

for i = 1 : nF
    F2D = matrix3D2D ( F, i );
    
    % TRANSLATION DES FENETRES -X, -Y, -Z
    [ x1, y1, z1 ] = rotateZ( -x, -y, -z, -phiF( i ) );
    [ F2D(:,1), F2D(:,2), F2D(:,3) ] = transXYZ( F2D(:,1), F2D(:,2), F2D(:,3), x1, y1, z1 );

    % PROJECTION DES CIRCLES SUR LA 2EME FENETRE
    P = pEquateur( R, phiX, phiZ , F2D, phiF( i ) );
    [XP2, YP2, ZP2, LP2] = pTropique( X2, Y2, Z2, F2D, phiF( i ) );
    [XP3, YP3, ZP3, LP3] = pTropique ( X3, Y3, Z3, F2D, phiF( i ) );

    % PROJECTION DES MERIDIANS SUR LA 2EME FENETRE
    [Xh, Yh, Zh, Lh] = pMeridian(X2,Y2,Z2,X3,Y3,Z3,XP2,YP2,ZP2,LP2,XP3,YP3,ZP3,LP3,phiF( i ), F2D, P );

    % DEPLACER LES PROJECTIONS DES CIRCLES X, Y, Z ET PLOT
    str = strcat( 'pEqua', num2str( i ) );
    pEqua = findobj(gcf,'tag', str );
    if length(P)>1
        [ P(:,1), P(:,2), P(:,3) ] = transXYZ( P(:,1), P(:,2), P(:,3), x, y, z );
        if isempty(pEqua)==1
            plot3( P(:,1), P(:,2), P(:,3), 'k', 'tag', str );
        else
            set( pEqua, 'Xdata', P(:,1), 'Ydata', P(:,2), 'Zdata', P(:,3) );
        end
    else delete(pEqua);
    end
    
    str = strcat( 'pCancer', num2str( i ) );
    pCancer = findobj(gcf,'tag', str );
    if length(XP2)>1
        [ XP2, YP2, ZP2 ] = transXYZ( XP2, YP2, ZP2, x, y, z );
        if isempty(pCancer)==1
            plot3( XP2, YP2, ZP2, 'b', 'tag', str );
        else
            set(pCancer,'Xdata',XP2,'Ydata',YP2,'Zdata',ZP2);
        end
    else delete(pCancer);
    end
    
    str = strcat( 'pCapi', num2str( i ) );
    pCapi = findobj( gcf, 'tag', str );
    if length(XP3)>1
        [ XP3, YP3, ZP3 ] = transXYZ( XP3, YP3, ZP3, x, y, z );
        if isempty(pCapi)==1
            plot3( XP3, YP3, ZP3, 'm', 'tag', str );
        else
            set(pCapi,'Xdata',XP3,'Ydata',YP3,'Zdata',ZP3);
        end
    else delete(pCapi);
    end

    % DEPLACER LES PROJECTIONS DES MERIDIANS X, Y, Z ET PLOT
    str = strcat( 'pMeridian', num2str( i ) );
    pMeridian2 = findobj( gcf, 'tag', str );
    delete(pMeridian2);
    len = size(Xh);
    if len(2)>1
        for j = 1:length(Zh)
            [ Xh(:,j), Yh(:,j), Zh(:,j) ] = transXYZ( Xh(:,j), Yh(:,j), Zh(:,j), x, y, z );
        end
        line( Xh, Yh, Zh, 'color', 'g', 'tag', str );
    end

end
% -----------------------  LES CIRCLES  ----------------------------------
% DEPLACER LES CIRCLES X, Y ,Z ET PLOT
[ X1, Y1, Z1 ] = transXYZ( X1, Y1, Z1, x, y, z );
[ X2, Y2, Z2 ] = transXYZ( X2, Y2, Z2, x, y, z );
[ X3, Y3, Z3 ] = transXYZ( X3, Y3, Z3, x, y, z );
Equa = findobj(gcf,'tag','Equa');
set(Equa,'Xdata',X1,'Ydata',Y1,'Zdata',Z1);
Cancer = findobj(gcf,'tag','Cancer');
set(Cancer,'Xdata',X2,'Ydata',Y2,'Zdata',Z2);
Capi = findobj(gcf,'tag','Capi');
set(Capi,'Xdata',X3,'Ydata',Y3,'Zdata',Z3);