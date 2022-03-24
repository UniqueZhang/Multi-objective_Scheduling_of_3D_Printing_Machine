function [Xp1,Yp1,j]=packbox(L,W,XX,Y,X,YY,Xp1,Yp1)
[Xp1,Yp1]=packbox_bottom(L,XX,Y,Xp1);%ÏÂÒÆ
[Xp1,Yp1]=packbox_left(W,X,YY,Yp1);%×óÒÆ
j=circulate_check(XX,Y,Xp1,Yp1,L);%¼ì²éBLÊÇ·ñ³¹µ×
end

        