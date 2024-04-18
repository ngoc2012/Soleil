function PatchF = PatchF( F, FB, str );
% PATCH
tcolor = [ .5 .5 .5 ];
FenetreP = findobj(gcf,'tag',str );
delete( FenetreP );
if length( FB ) > 1
    vertex_matrix1 = [ FB( 1, : ); FB( 2, : ); F( 1, : ); F( 4, : ) ];
    faces_matrix1 = [ 1 2 3 4 ];
    patch( 'Vertices', vertex_matrix1, 'Faces', faces_matrix1, 'FaceColor', tcolor , 'tag', str );
    alpha(.5)
end