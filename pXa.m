% PROJECTION SUR LA SURFACE YZ A X=F(1,1) DE L'ORIGIN
function [ XP, YP, ZP ] = pXa( X, Y, Z, F)
    R = F(1,1);
    YP=0;
    ZP=0;
    % PROJECTION SUR LA SURFACE X = R
    j=0;
    for i=1:length(X)
        [ YP0, ZP0, ival ] = projectX ( X(i), Y(i), Z(i), F, R );
        if ival == 1 && ( YP0 * Y(i) ) >= 0
            j = j + 1;
            YP(j) = YP0;
            ZP(j) = ZP0;
        end
    end

    if j<2
        YP = 0;
        ZP = 0;
    end
    XP=R*ones(1,length(YP));
end

function [ YP, ZP, ival ] = projectX ( X, Y, Z, F, R )
    ival = 0;
    YP = R*Y/X;
    ZP = R*Z/X;
    if YP <= max(F(:,2)) && YP >= min(F(:,2)) && ZP <= max(F(:,3)) && ZP >= min(F(:,3))
        ival = 1;
    end
end