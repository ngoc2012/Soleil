function barF = barF( F, phiF, z, nF )
% BAR DES FENETRES
for i = 1 : nF
    F2D = matrix3D2D ( F, i );
    FB = [ F2D(1,1) min( F2D(:,2) ) z ; F2D( 1, 1 ) max( F2D( :, 2 ) ) z ];
    [ FB(:,1), FB(:,2), FB(:,3) ] = rotateZ( FB(:,1), FB(:,2), FB(:,3), phiF( i ) );
    [ F2D(:,1), F2D(:,2), F2D(:,3) ] = rotateZ( F2D(:,1), F2D(:,2), F2D(:,3), phiF( i ) );
    str = strcat( 'FenetreP', num2str( i ) );
    PatchF( F2D, FB, str );
end