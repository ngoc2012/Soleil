function str = direction( phiF )
str='';
if phiF > 180, phiF = 360 - phiF; , end;
if phiF < -180, phiF = 360 + phiF; , end;
if phiF == 0, str = 'Sud' ; , end;
if phiF == 180, str = 'Nord' ; , end;
if phiF == 90, str = 'Est' ; , end;
if phiF == -90, str = 'Ouest' ; , end;
if phiF > 0 && phiF < 90, str = strcat( num2str( phiF ), '° Sud - Est' ); , end;
if phiF > -90 && phiF < 0, str = strcat( num2str( abs( phiF ) ), '° Sud - Ouest' ); , end;
if phiF > 90 && phiF < 180, str = strcat( num2str( 180 - phiF ), '° Nord - Est' ); , end;
if phiF < -90 && phiF > -180, str = strcat( num2str( phiF + 180 ), '° Nord - Ouest' ); , end;