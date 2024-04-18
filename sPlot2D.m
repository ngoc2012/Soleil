function sPlot2D = sPlot2D ( Y, M, D, R, F, phiX, phiZ, phiL, phiT, phiF, x, y, z, n )
Fo = F;
XMIN = min( F( :, 2 ) );
XMAX = max( F( :, 2 ) );
YMIN = min( F( :, 3 ) );
YMAX = max( F( :, 3 ) );
DX = XMAX - XMIN;
DY = YMAX - YMIN;

str = datestr( datenum( Y, M, D ), 'dd-mmm-yyyy' );
str = strcat( 'Soleil le :', str );
str = strcat( str, ' (' );
str = strcat( str, ' Fenêtre à: ' );
str1 = direction( phiF - phiZ );
str = strcat( str, str1 );
str = strcat( str, ' )' );
% fig = figure('position',[100 100 800 ( DY * 800 / DX ) ],'color',[0 0.19
% 0.45], 'Name', str);
fig = figure('color',[1 1 1]);

subplot(1,3,[1 2]);

% LES CIRCLES AVANT TRANSLATION
[X1, Y1, Z1] = rot3c( R, phiX, phiZ, phiL, 0, n );
[X2, Y2, Z2] = rot3c( R, phiX, phiZ, phiL, phiT, n );
[X3, Y3, Z3] = rot3c( R, phiX, phiZ, phiL, -phiT, n );

% LA CIRCLE DU JOUR EXAMINE
[ E, Decl ] = EquaT1( Y, M, D );
[X4, Y4, Z4] = rot3c( R, phiX, phiZ, phiL, radians( - Decl ), n );

% TRANSLATION DES FENETRES -X, -Y, -Z
[ x1, y1, z1 ] = rotateZ( -x, -y, -z, -phiF );
[ F(:,1), F(:,2), F(:,3) ] = transXYZ( F(:,1), F(:,2), F(:,3), x1, y1, z1 );

% PROJECTION DES CIRCLES SUR LA FENETRE
P = pEquateur( R, phiX, phiZ , F, phiF );
[ XP2, YP2, ZP2, LP2 ] = pTropique( X2, Y2, Z2, F, phiF );
[ XP3, YP3, ZP3, LP3 ] = pTropique( X3, Y3, Z3, F, phiF );

% PROJECTION DE LA CIRCLE D'AUJOURD'HUI
[ XP4, YP4, ZP4, LP4 ] = pTropique( X4, Y4, Z4, F, phiF );

% PROJECTION DES MERIDIANS SUR LA FENETRE
[ Xh, Yh, Zh, Lh ] = pMeridian(X2,Y2,Z2,X3,Y3,Z3,XP2,YP2,ZP2,LP2,XP3,YP3,ZP3,LP3,phiF,F,P);

% subplot(2,3,[1 2 3]);
% DEPLACER LES PROJECTIONS DES CIRCLES X, Y, Z ET PLOT
if length(P)>1
    [ P(:,1), P(:,2), P(:,3) ] = transXYZ( P(:,1), P(:,2), P(:,3), x, y, z );
    [ P(:,1), P(:,2), P(:,3) ] = rotateZ( P(:,1), P(:,2), P(:,3), -phiF );
    plot(P(:,2),P(:,3),'k');
end
axis equal;
axis([XMIN XMAX YMIN YMAX]);
% axis([XMIN XMAX+abs((XMAX - XMIN)/2) YMIN YMAX]);
% axis([XMIN XMAX min([YMIN x1-F(1,1)]) max([YMAX x1-F(1,1)])]);

grid off
hold;
% if phiF >= 0
    set(gca,'XDir','reverse');
% end


if length(XP2)>1
    [ XP2, YP2, ZP2 ] = transXYZ( XP2, YP2, ZP2, x, y, z );
    [ XP2, YP2, ZP2 ] = rotateZ( XP2, YP2, ZP2, -phiF );
    plot( YP2, ZP2, 'b' );
end

if length(XP3)>1
    [ XP3, YP3, ZP3 ] = transXYZ( XP3, YP3, ZP3, x, y, z );
    [ XP3, YP3, ZP3 ] = rotateZ( XP3, YP3, ZP3, -phiF );
    plot( YP3, ZP3, 'm' );
end

coloriser7( Fo, phiX, phiZ, phiF, x, y, z, YP2, ZP2, YP3, ZP3 );

% DEPLACER LA PROJECTION DE LA CIRCLE DU JOUR CHOISI ET PLOT
if length(XP4)>1
    [ XP4, YP4, ZP4 ] = transXYZ( XP4, YP4, ZP4, x, y, z );
    [ XP4, YP4, ZP4 ] = rotateZ( XP4, YP4, ZP4, -phiF );
    plot( YP4, ZP4, 'r' );
end

% DEPLACER LES PROJECTIONS DES MERIDIANS X, Y, Z ET PLOT
len = size(Xh);
if len(2)>1
    for i = 1:length(Zh)
        [ Xh(:,i), Yh(:,i), Zh(:,i) ] = transXYZ( Xh(:,i), Yh(:,i), Zh(:,i), x, y, z );
        [ Xh(:,i), Yh(:,i), Zh(:,i) ] = rotateZ( Xh(:,i), Yh(:,i), Zh(:,i), -phiF );
    end
    line(Yh, Zh,'color','g');
    for i=1:length(Xh)
        text( sum(Yh(:,i))/2, sum(Zh(:,i))/2, strcat( num2str(Lh(i)) , 'h' ));
    end
end

% PROJECTION DES ANALEMMES
for i = 1 : length(Lh)
    [ Xa, Ya, Za ] = pAnalemme( Lh(i), R, phiX, phiZ, phiL, F, phiF );
    [ Xa, Ya, Za ] = transXYZ( Xa, Ya, Za, x, y, z );
    [ Xa, Ya, Za ] = rotateZ( Xa, Ya, Za, -phiF );
    plot( Ya, Za );
end

% PROJECTION DU SOLEIL AUX HEURES DU JOUR CHOISI
[ Xaj, Yaj, Zaj ] = jAnalemme( Y, M, D, R, phiX, phiZ, phiL, F, phiF );
[ Xaj, Yaj, Zaj ] = transXYZ( Xaj, Yaj, Zaj, x, y, z );
[ Xaj, Yaj, Zaj ] = rotateZ( Xaj, Yaj, Zaj, -phiF );
if length( Yaj ) > 1
    plot( Yaj, Zaj, 'ro' );
end

% PLOT LA FENETRE
[ F(:,1), F(:,2), F(:,3) ] = transXYZ( F(:,1), F(:,2), F(:,3), -x1, -y1, -z1 );
FB = [F(1,1) min(F(:,2)) z; F(1,1) max(F(:,2)) z ];
plot( F(:,2), F(:,3), 'k', 'LineWidth', 3 );
plot( FB(:,2), FB(:,3), 'k' );

tcolor = [ .5 .5 .5 ];
vertex_matrix = [ FB( 1, 2 ) FB( 1, 3 ) FB( 1, 1 );...
                  FB( 2, 2 ) FB( 2, 3 ) FB( 2, 1 );...
                  F( 1, 2 ) F( 1, 3 ) F( 1, 1 );...
                  F( 4, 2 ) F( 4, 3 ) F( 4, 1 ) ];
faces_matrix = [ 1 2 3 4 ];
patch( 'Vertices', vertex_matrix, 'Faces', faces_matrix, 'FaceColor', tcolor, 'tag', 'lanuit' )
lanuit = findobj( gcf, 'tag', 'lanuit' );
alpha( lanuit, 0.5 )


% Sous-routine calcule le jour le plus tôt et le plus tard du soleil:
clear Xa Ya Za k AD
Zo = 10;
Mo = 0;
Do = 0;
Zv = 10;
Mv = 0;
Dv = 0;
Date = clock;
Y = Date( 1 );

% number of days in each month
% numdays = [31 28 31 30 31 30 31 31 30 31 30 31];
% if mod( Y, 4 ) == 0 && mod( Y, 400 ) ~= 0
%     numdays = [31 29 31 30 31 30 31 31 30 31 30 31];
% end
% 
% for i = 1 : 12
%     M = i;                                  % Mois de cette anne
%     for j = 1 : numdays(i)
%         
%         for n = 9 : 9
%         D = j + n / 24;                    % Jour + heure examinees
%         [ E, Decl ] = EquaT1( Y, M, D );    % Equation du temps et declinaison
%         Xa = R * cos( radians( Decl ) );
%         Ya = 0;
%         Za = R * sin( - radians( Decl ) );
%         
%         AD = phiL + n * 15 + degrees( E );
%         [ Xa, Ya, Za ] = rotateZ( Xa, Ya, Za, AD );
%         [ Xa, Ya, Za ] = rotateX( Xa, Ya, Za, phiX );
%         [ Xa, Ya, Za ] = rotateZ( Xa, Ya, Za, phiZ );
% 
%             if Za < Zo
%                 Zo = Za;
%                 Mo = M;
%                 Do = D;
%             end
%         end
%         
%         for n = 16 : 17
%         D = j + n / 24;                    % Jour + heure examinees
%         [ E, Decl ] = EquaT1( Y, M, D );    % Equation du temps et declinaison
%         Xa = R * cos( radians( Decl ) );
%         Ya = 0;
%         Za = R * sin( - radians( Decl ) );
%         
%         AD = phiL + n * 15 + degrees( E );
%         [ Xa, Ya, Za ] = rotateZ( Xa, Ya, Za, AD );
%         [ Xa, Ya, Za ] = rotateX( Xa, Ya, Za, phiX );
%         [ Xa, Ya, Za ] = rotateZ( Xa, Ya, Za, phiZ );
% 
%             if Za < Zv
%                 Zv = Za;
%                 Mv = M;
%                 Dv = D;
%             end
%         end
%         
%     end
% end
% disp('Le jour le plus tard : ');
% Mo
% Do
% disp('Le jour le plus tôt : ');
% Mv
% Dv

% h = gca;
title(gca,str);
set(get(gca,'Title'),'VerticalAlignment','bottom', 'Color', 'b' );
axis off

subplot(1,3,3);
% if phiF >= 0
%     set(gca,'XDir','reverse');
% end

plot( FB(:,2), FB(:,3), 'k', 'LineWidth', 2 );
axis equal;
% plot( 0, FB(:,3)/2, 'k' );
hold;
plot(  y1, -x1-F(1,1) , 'r+' );
plot([FB(1,2) y1],[FB(1,3) -x1-F(1,1)], 'g--');
plot([FB(2,2) y1],[FB(2,3) -x1-F(1,1)], 'g--');
axis off