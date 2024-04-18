function [Xh,Yh,Zh,Lh] = meridian(X2,Y2,Z2,X3,Y3,Z3,XP2,YP2,ZP2,LP2,XP3,YP3,ZP3,LP3,phiF,F,P)
nn = (length(X2)-1)/24;     % NOMBRE DES POINTS ENTRE 2 HEURES
[F(:,1),F(:,2),F(:,3)] = rotateZ(F(:,1),F(:,2),F(:,3),phiF);
T = 0;
j = 0;
Xh = 0;
Yh = 0;
Zh = 0;
Lh = 0;
p1 = [0,0,0];

if length(LP2)>0
    for i=1:length(LP2)
        if LP2(i) ~= 0
            j = j+1;
            T(j) = LP2(i);
            Xh(1,j) = XP2(i);
            Yh(1,j) = YP2(i);
            Zh(1,j) = ZP2(i);
            % POSITIONS DES POINTS SUR LA SPHERE
            b = LP2(i)*nn + 1 ;
            
            % CHERCHER LES 2 INTERSECTION PAR LA FENETRE
            [ intersect, p ] = intFenetre ( X2(b), Y2(b), Z2(b), X3(b), Y3(b), Z3(b), F);
            
            % SI L'ON  A UNE AUTRE PROJECTIONS SUR LA TROPIQUE RESTE
            [ival,n] = check(LP3,LP2(i));
            if ival == 1
                Xh(2,j) = XP3(n);
                Yh(2,j) = YP3(n);
                Zh(2,j) = ZP3(n);
            % SI L'ON  N'EN A PAS UNE
            else
                % VECTOR SUR LA SPHERE
                v = [X2(b) - X3(b), Y2(b) - Y3(b), Z2(b) - Z3(b)];
                % VECTORS SUR LA PROJECTION
                v1 = [Xh(1,j) - p(1,1), Yh(1,j) - p(1,2), Zh(1,j) - p(1,3)];
                
                if dot(v,v1)>0
                    Xh(2,j) = p(1,1);
                    Yh(2,j) = p(1,2);
                    Zh(2,j) = p(1,3);
                else
                    Xh(2,j) = p(2,1);
                    Yh(2,j) = p(2,2);
                    Zh(2,j) = p(2,3);
                end
            end
            Lh(j) = LP2(i);
        end
    end
end

if length(LP3)>0
    for i=1:length(LP3)
        [ival,n] = check(LP2,LP3(i));
        if LP3(i) ~= 0 && ival == 0
            j = j+1;
            Xh(1,j) = XP3(i);
            Yh(1,j) = YP3(i);
            Zh(1,j) = ZP3(i);
            % POSITIONS DES POINTS SUR LA SPHERE
            b = LP3(i)*nn + 1;
            
            % CHERCHER LES 2 INTERSECTION PAR LA FENETRE
            [ intersect, p ] = intFenetre ( X2(b), Y2(b), Z2(b), X3(b), Y3(b), Z3(b), F);
            
            % SI L'ON  A UNE AUTRE PROJECTIONS SUR LA TROPIQUE RESTE
            if check(LP2,LP3(i)) == 1
                Xh(2,j) = XP2(i);
                Yh(2,j) = YP2(i);
                Zh(2,j) = ZP2(i);
            % SI L'ON  N'EN A PAS UNE
            else
                % VECTOR SUR LA SPHERE
                v = [X3(b) - X2(b), Y3(b) - Y2(b), Z3(b) - Z2(b)];
                % VECTORS SUR LA PROJECTION
                v1 = [Xh(1,j) - p(1,1), Yh(1,j) - p(1,2), Zh(1,j) - p(1,3)];
                
                if dot(v,v1)>0
                    Xh(2,j) = p(1,1);
                    Yh(2,j) = p(1,2);
                    Zh(2,j) = p(1,3);
                else
                    Xh(2,j) = p(2,1);
                    Yh(2,j) = p(2,2);
                    Zh(2,j) = p(2,3);
                end
            end
            Lh(j) = LP3(i);
        end
    end
end

% CAS OU IL N'Y A PAS DE POINT DANS LA FENETRE
% POSITIONS DES POINTS SUR LA SPHERE
b(1) = ( max(Lh) + 1 ) * nn + 1;
b(2) = ( min(Lh) - 1 ) * nn + 1;
b(2) = mod(b(2),length(X2));
% CHERCHER LES 2 INTERSECTION PAR LA FENETRE
for i = 1:length(b)
    if b(i) <= length(X2)
        [ intersect, p ] = intFenetre ( X2(b(i)), Y2(b(i)), Z2(b(i)), X3(b(i)), Y3(b(i)), Z3(b(i)), F);
    
        if intersect == 2
    	% pp = PROJECTION DES p SUR LA LIGNE [ X2 Y2 Z3 ] 
        [ intersect, pp ] = LinePlane ( [ 0, 0, 0], p( 1, : ), F( 2, : ), [ X2(b(i)), Y2(b(i)), Z2(b(i)) ], [ X3(b(i)), Y3(b(i)), Z3(b(i)) ] );
        v1 = [pp(1) - X2(b(i)), pp(2) - Y2(b(i)), pp(3) - Z2(b(i))];
        v2 = [pp(1) - X3(b(i)), pp(2) - Y3(b(i)), pp(3) - Z3(b(i))];
            if dot(v1,v2) <= 0
                j = j + 1;
                Xh( 1 , j ) = p( 1 , 1 );
                Yh( 1 , j ) = p( 1 , 2 );
                Zh( 1 , j ) = p( 1 , 3 );
                Xh( 2 , j ) = p( 2 , 1 );
                Yh( 2 , j ) = p( 2 , 2 );
                Zh( 2 , j ) = p( 2 , 3 );
                if i == 1
                    Lh(j) = max(Lh) + 1;
                else
                    Lh(j) = min(Lh) - 1;
                end
            end
        end
    end
end

% CAS OU IL N'Y A PAS DE POINTS DANS LP2 ET LP3
len = 0;
if isempty(P) == 0
    len = size(P);
    P;
end
LP2;
LP3;
if sum(LP2) + sum(LP3) == 0 && len(1) == 2
    j = 0;
    for i = 1:24
        b = i*nn + 1;
        [ intersect1, p ] = intFenetre ( X2(b), Y2(b), Z2(b), X3(b), Y3(b), Z3(b), F);
        
        if intersect1 == 2 
            % pp = PROJECTION DES p SUR LA LIGNE [ X2 Y2 Z3 ] 
            [ intersect, pp ] = LinePlane ( [ 0, 0, 0], p( 1, : ), F( 2, : ), [ X2(b), Y2(b), Z2(b) ], [ X3(b), Y3(b), Z3(b) ] );
            v1 = [pp(1) - X2(b), pp(2) - Y2(b), pp(3) - Z2(b)];
            v2 = [pp(1) - X3(b), pp(2) - Y3(b), pp(3) - Z3(b)];
            
            if dot(v1,v2) <= 0
            a1 = p( 1, : ) / norm( p( 1, : ) );
            c = pp / norm(pp);
                if round(a1*100) == round(c*100)
                    j = j + 1;
                    Xh( 1 , j ) = p( 1 , 1 );
                    Yh( 1 , j ) = p( 1 , 2 );
                    Zh( 1 , j ) = p( 1 , 3 );
                    Xh( 2 , j ) = p( 2 , 1 );
                    Yh( 2 , j ) = p( 2 , 2 );
                    Zh( 2 , j ) = p( 2 , 3 );
                    Lh(j) = i;
                end
            end
        end
    end
    
    % CHECK S'IL Y A QQC
    for k = min(Lh):max(Lh)
        [ ival, m ] = check(k,Lh);
        if ival == 0
            b = k*nn + 1;
            [ intersect, p ] = intFenetre ( X2(b), Y2(b), Z2(b), X3(b), Y3(b), Z3(b), F);
            j = j + 1;
            Xh( 1 , j ) = p( 1 , 1 );
            Yh( 1 , j ) = p( 1 , 2 );
            Zh( 1 , j ) = p( 1 , 3 );
            Xh( 2 , j ) = p( 2 , 1 );
            Yh( 2 , j ) = p( 2 , 2 );
            Zh( 2 , j ) = p( 2 , 3 );
            Lh(j) = k;
        end
    end 
end

% IL FAUT CHANGER LES HEURES
% for i = 1 : length(Lh)
%     if mod( Lh(i), 12 ) ~= 0
%         Lh(i) = 24 - Lh(i);
%     end
% end