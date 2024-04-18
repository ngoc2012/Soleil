function [ Xa, Ya, Za ] = jAnalemme( Y, M, D, R, phiX, phiZ, phiL, F, phiF )
D0 = D;
    for i = 1 : 24
        D = D0 + i / 24;                    % Jour + heure examinees
        [ E, Decl ] = EquaT1( Y, M, D );    % Equation du temps et declinaison
        Xa( i ) = R * cos( radians( Decl ) );
        Ya( i ) = 0;
        Za( i ) = R * sin( - radians( Decl ) );
        AD = phiL + i * 15 + degrees( E );        % Ascension droite
        [ Xa(i), Ya(i), Za(i) ] = rotateZ( Xa(i), Ya(i), Za(i), AD );
        [ Xa(i), Ya(i), Za(i) ] = rotateX( Xa(i), Ya(i), Za(i), phiX );
        [ Xa(i), Ya(i), Za(i) ] = rotateZ( Xa(i), Ya(i), Za(i), phiZ );
    end

% PROJECTION SUR LA FENETRE
if phiF ~= 0
    [ Xa, Ya, Za ] = rotateZ( Xa, Ya, Za, -phiF );
end
[ Xa, Ya, Za ] = pXa( Xa, Ya, Za, F );
if length(Xa) > 1
    if phiF ~= 0
        [ Xa, Ya, Za ] = rotateZ( Xa, Ya, Za, phiF );
    end
end