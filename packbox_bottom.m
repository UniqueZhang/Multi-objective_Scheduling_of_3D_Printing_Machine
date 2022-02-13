function [Xp1,Yp1]=packbox_bottom(L,XX,Y,Xp1)
Ypp=0;%后面需要的中间量
Xp2=Xp1+L;
m=size(XX,1); 
a=1;
b=1;
for i=1:m
    if XX(i,1) <= Xp1 && Xp1 < XX(i,2)
        a=i;
    end
end  %左下端位于的XX区域
for i=1:m
    if XX(i,1) < Xp2 && Xp2 <= XX(i,2)
        b=i;
    end
end   %右下端位于的XX区域
for i=a:b
    if Y(i)>Ypp
        Ypp=Y(i);
    end
end   
Yp1=Ypp;%Y方向变化，即下移
end