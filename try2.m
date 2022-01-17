Ls=input('Ls=');
Ws=input('Ws=');
L=input('L=');
W=input('W=');
Xp1=Ls-L;
Yp1=0;
j=0;
while j==0  %一直平移直到触底。
    [Xp1,Yp1,j]=packbox(L,W,XX,Y,X,YY,Xp1,Yp1);
end
[XX,Y,X,YY]=changeXY(XX,Y,X,YY,Xp1,Yp1);
