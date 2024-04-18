function [ intersect, p ] = intFenetre ( X2, Y2, Z2, X3, Y3, Z3, F)
intersect = 0;      % NOMBRE DES INTERSECTIONS
p = [ 0, 0, 0 ];
p1 = [ 0, 0, 0 ];
k = 0;
for m = 1:4
    [ ival, p0 ] = LinePlane ( p1, [X2, Y2, Z2], [X3, Y3, Z3], F(m,:), F(m+1,:) );
    if ival == 1
        k = k + 1;
        p(k,:) = p0;
        intersect = intersect + 1;
    end
end
% if intersect == 3
%     for i = 1:3
%         t = mod((i+1),3);
%         if t == 0, t = 3;, end
%         if p(i) == p(t)
%             a = i;
%         end
%     end
%     if isempty(a) == 0
%         p(a) = [];
%     end
% end