function var = checkin( VT, VT1, phi )
var = 1;
Z = degrees( asin(  dot( VT, VT1 ) / ( norm(VT) * norm(VT1) )  ) );
% if Z <= 23.4394
%     var = 1;
% end
if abs(Z) > phi
    var = 0;
end