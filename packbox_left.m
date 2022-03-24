function [Xp1,Yp1]=packbox_left(W,X,YY,Yp1)
Xpp=0;%后面需要的中间量
Yp3=Yp1+W;%矩形上边的纵坐标
c=1;
d=1;
n=size(YY,1);
for i=1:n
    if YY(i,1) <= Yp1 && Yp1< YY(i,2)
        c=i;
    end
end  %左下端位于的YY区域
for i=1:n
    if YY(i,1) < Yp3 && Yp3 <= YY(i,2)
        d=i;
    end
end   %右下端位于的YY区域
for i=c:d
    if X(i)>Xpp
        Xpp=X(i);
    end
end   
Xp1=Xpp;%X方向变化，即左移
end