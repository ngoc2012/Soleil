function jPlot = jPlot ( Y, M, D, R, F1, F2, phiX, phiZ, phiL, phiT, phiF1, phiF2, x, y, z, n)

% LA CIRCLE AVANT TRANSLATION
[X1, Y1, Z1] = rot3c( R, phiX, phiZ, phiL, 0, n );