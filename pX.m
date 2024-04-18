% PROJECTION SUR LA SURFACE YZ A X=F(1,1) DE L'ORIGIN
function [XP,YP,ZP,LP] = pX(X, Y, Z, F)
num = length(X) - 1;        % Nombre des ecarts
n = (length(X)-1)/24;
R = F(1,1);

LP=0;
YP=0;
ZP=0;
m = 0;
% PROJECTION SUR LA SURFACE X = R
j=0;
for i=1:length(X)
    [ YP0, ZP0, LP0, ival ] = projectX ( X(i), Y(i), Z(i), F, R, n, i );
    if ival == 1 && dot( [ R, YP0, ZP0 ], [ X(i), Y(i), Z(i) ] ) > 0
        j = j + 1;
        YP(j) = YP0;
        ZP(j) = ZP0;
        LP(j) = LP0;
        if j > 1 && (i - k) > 1
            m = k;
        end
        k = i;
    end
end

% if len(YP) > 0
if m > 0
    len = length(YP);
    YP( ( len + 1 ) : ( len + m ) ) = YP( 1 : m );
    len = length(ZP);
    ZP( ( len + 1 ) : ( len + m ) ) = ZP( 1 : m );
    len = length(LP);
    LP( ( len + 1 ) : ( len + m ) ) = LP( 1 : m );
    YP ( 1 : m ) = [];
    ZP ( 1 : m ) = [];
    LP ( 1 : m ) = [];
end
% end

if j<2
    YP = 0;
    ZP = 0;
    LP = 0;
end
XP=R*ones(1,length(YP));