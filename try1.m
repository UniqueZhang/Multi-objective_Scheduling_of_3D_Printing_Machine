XX=[0,1;1,3;3,5;5,7;7,7.5;7.5,8];
Y=[0;7;5;8;9;0];
YY=[0,9;9,15];
X=[7.5;0];
L=3;
W=2;
Ls=8;
Ws=15;
Yp1=0;
Xp1=Ls-L;
j=0;
[Xp1,Yp1,j]=packbox(L,W,XX,Y,X,YY,Xp1,Yp1)
[Xp1,Yp1,j]=packbox(L,W,XX,Y,X,YY,Xp1,Yp1)
Xp1
Yp1