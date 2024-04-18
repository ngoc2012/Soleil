function var = infenetre( Fo, X, z );
var = 1;
if X(1) > max(Fo(:,2)), var = 0;, end
if X(1) < min(Fo(:,2)), var = 0;, end
if X(2) > max(Fo(:,3)), var = 0;, end
if X(2) < z, var = 0;, end