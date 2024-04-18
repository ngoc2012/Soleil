function FR = Fplane( F )
[ intersect, O ] = LinePlane ( p1, p2, p3, pa, pb )
[ FR(:,1), FR(:,2), FR(:,3) ] = rotateZ( F(:,1), F(:,2), F(:,3), phiF );
XMIN = line_exp_point_dist_3d ( p1, p2, p )