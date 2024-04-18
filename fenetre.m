function [ X, Y ] = fenetre( Fo, z, Xo, Yo );
X = Xo;
Y = Yo;
cor = [ max(Fo(:,2)) min(Fo(:,2)) max(Fo(:,3)) z ];
dif = [ max(Fo(:,2))-Xo Xo-min(Fo(:,2)) max(Fo(:,3))-Yo Yo-z ];
[ res I ] = min(dif);
if I < 3
    X = cor(I);
end
if I > 2
    Y = cor(I);
end