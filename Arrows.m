function Arrows = Arrows ( a, x, y, z, phiZ )
Arrow = findobj(gcf,'tag','Arrow1');
txtArrow = findobj(gcf,'tag','txtArrow1');
if isempty(Arrow) == 0, delete(Arrow);, end
if isempty(txtArrow) == 0, delete(txtArrow);, end
% NORD ARROW
[ A, B, C ] = rotateZ( a, 0, 0, phiZ );
[ A, B, C ] = transXYZ( A, B, C, x, y, z );
arrow([x y z], [ A, B, C ] , 18, 'BaseAngle', 30, 'tag', 'Arrow1');    
text(1.2*A, B, C, 'Sud', 'tag', 'txtArrow1');
% SUD ARROW
[ A, B, C ] = rotateZ( -a, 0, 0, phiZ );
[ A, B, C ] = transXYZ( A, B, C, x, y, z );
arrow([x y z], [ A, B, C ], 18, 'BaseAngle', 30, 'tag', 'Arrow1');    
text(1.2*A, B, C, 'Nord', 'tag', 'txtArrow1');
% EST ARROW
[ A, B, C ] = rotateZ( 0, -a, 0, phiZ );
[ A, B, C ] = transXYZ( A, B, C, x, y, z );
arrow([x y z], [ A, B, C ], 18, 'BaseAngle', 30, 'tag', 'Arrow1');    
text(A, 1.2*B, C, 'Ouest', 'tag', 'txtArrow1');
% OUEST ARROW
[ A, B, C ] = rotateZ( 0, a, 0, phiZ );
[ A, B, C ] = transXYZ( A, B, C, x, y, z );
arrow([x y z], [ A, B, C ], 18, 'BaseAngle', 30, 'tag', 'Arrow1');    
text(A, 1.2*B, C, 'Est', 'tag', 'txtArrow1');