function P = pEquateur( R, phiX, phiZ , F, phiF );
[F(:,1),F(:,2),F(:,3)] = rotateZ(F(:,1),F(:,2),F(:,3),phiF);

P = 0;
P0 = [0 0 0];
[P1(1),P1(2),P1(3)] = rotateX(R,0,0,phiX);
[P1(1),P1(2),P1(3)] = rotateZ(P1(1),P1(2),P1(3),phiZ);
[P2(1),P2(2),P2(3)] = rotateX(0,R,0,phiX);
[P2(1),P2(2),P2(3)] = rotateZ(P2(1),P2(2),P2(3),phiZ);

len = size(F);
j = 0;
for i=1:len(1)-1
    [ intersect , PL ] = LinePlane(P0,P1,P2,F(i,:),F(i+1,:));
    if intersect == 1
        j = j+1;
        P(j,1) = PL(1);
        P(j,2) = PL(2);
        P(j,3) = PL(3);
    end
end