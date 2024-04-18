function [ intersect, p ] = LinePlane ( p1, p2, p3, pa, pb )

x0 = pa(1);
y0 = pa(2);
z0 = pa(3);
f = pa(1)-pb(1);
g = pa(2)-pb(2);
h = pa(3)-pb(3);

% Converts an explicit plane to implicit form in 3D
dim_num = 3;

  a = ( p2(2) - p1(2) ) * ( p3(3) - p1(3) ) ...
    - ( p2(3) - p1(3) ) * ( p3(2) - p1(2) );

  b = ( p2(3) - p1(3) ) * ( p3(1) - p1(1) ) ...
    - ( p2(1) - p1(1) ) * ( p3(3) - p1(3) );

  c = ( p2(1) - p1(1) ) * ( p3(2) - p1(2) ) ...
    - ( p2(2) - p1(2) ) * ( p3(1) - p1(1) );

  d = - p2(1) * a - p2(2) * b - p2(3) * c;

  
%% PLANE_IMP_LINE_PAR_INT_3D: intersection ( implicit plane, parametric line ) in 3D.
%
%  Discussion:
%
%    The implicit form of a plane in 3D is:
%
%      A * X + B * Y + C * Z + D = 0
%
%    The parametric form of a line in 3D is:
%
%      X = X0 + F * T
%      Y = Y0 + G * T
%      Z = Z0 + H * T
%
%  Parameters:
%
%    Input, real A, B, C, D, the implicit plane parameters.
%
%    Input, real X0, Y0, Z0, F, G, H, parameters that define the
%    parametric line.
%
%    Output, logical INTERSECT, is TRUE if the line and the plane
%    intersect.
%
%    Output, real P(3), is a point of intersection of the line
%    and the plane, if INTERSECT is TRUE.
%
  dim_num = 3;
  tol = 0.00001;
%
%  Check.
%
  norm1 = sqrt ( a * a + b * b + c * c );

  if ( norm1 == 0.0 )
    disp ( '  The plane normal vector is null.\n' );
  end

  norm2 = sqrt ( f * f + g * g + h * h );

  if ( norm2 == 0.0 )
    disp ( 1, '  The line direction vector is null.\n' );
  end

  denom = a * f + b * g + c * h;
%
%  The line and the plane may be parallel.
%
  if ( abs ( denom ) < tol * norm1 * norm2 )

    if ( a * x0 + b * y0 + c * z0 + d == 0.0 )
      intersect = 1;
      p(1) = x0;
      p(2) = y0;
      p(3) = z0;
    else
      intersect = 0;
      p(1:dim_num) = 0.0;
    end
%
%  If they are not parallel, they must intersect.
%
  else

    intersect = 1;
    t = - ( a * x0 + b * y0 + c * z0 + d ) / denom;
    p(1) = x0 + t * f;
    p(2) = y0 + t * g;
    p(3) = z0 + t * h;
    if p(1)<min(pa(1),pb(1)) || p(1)>max(pa(1),pb(1)) || p(2)<min(pa(2),pb(2)) || p(2)>max(pa(2),pb(2)) || p(3)<min(pa(3),pb(3)) || p(3)>max(pa(3),pb(3))
        intersect = 0;
    end

  end

