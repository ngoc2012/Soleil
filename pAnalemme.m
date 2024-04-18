function [ Xa, Ya, Za ] = pAnalemme( Lh, R, phiX, phiZ, phiL, F, phiF )
Date = clock;
Y = Date( 1 );
% M = 1 : 12
% D = 1 : 31
% number of days in each month
numdays = [31 28 31 30 31 30 31 31 30 31 30 31];
if mod( Y, 4 ) == 0 && mod( Y, 400 ) ~= 0
    numdays = [31 29 31 30 31 30 31 31 30 31 30 31];
end
k = 0;
for i = 1 : 12
    M = i;                                  % Mois de cette anne
    for j = 1 : numdays(i)
        D = j + Lh / 24;                    % Jour + heure examinees
        k = k + 1;
        [ E, Decl ] = EquaT1( Y, M, D );    % Equation du temps et declinaison
        Xa( k ) = R * cos( radians( Decl ) );
        Ya( k ) = 0;
        Za( k ) = R * sin( - radians( Decl ) );
        AD = phiL + Lh * 15 + degrees( E );        % Ascension droite
%         AD = Lh * 15 + degrees( E );        % Ascension droite
        [ Xa(k), Ya(k), Za(k) ] = rotateZ( Xa(k), Ya(k), Za(k), AD );
        [ Xa(k), Ya(k), Za(k) ] = rotateX( Xa(k), Ya(k), Za(k), phiX );
        [ Xa(k), Ya(k), Za(k) ] = rotateZ( Xa(k), Ya(k), Za(k), phiZ );
    end
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