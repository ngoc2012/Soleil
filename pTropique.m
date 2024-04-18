function [XP,YP,ZP,LP] = pTropique( X, Y, Z, F, phiF);
% Projection sur la surface qui tourne phiF par l'axe Z
if phiF ~= 0
    [ X, Y, Z ] = rotateZ( X, Y, Z, -phiF );
end
[ XP, YP, ZP, LP ] = pX( X, Y, Z, F );
if length(XP) > 1
    if phiF ~= 0
        [ XP, YP, ZP ] = rotateZ( XP, YP, ZP, phiF );
    end
end