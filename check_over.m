function u=check_over(Xp1,Yp1,L,W,data_rec)
[XX,Y,X,YY]=updata(data_rec);
Xp3=Xp1+L;
Yp3=Yp1+W;
u=0;
m=size(XX,1); 
a=1;
b=1;
for i=1:m
    if XX(i,1) <= Xp1 && Xp1 < XX(i,2)
        a=i;
    end
end  %左下端位于的XX区域
for i=1:m
    if XX(i,1) < Xp3 && Xp3 <= XX(i,2)
        b=i;
    end
end   %右下端位于的XX区域
for i=a:b
    if Y(i)>Yp1
        u=1;
        
    end
end   %检查在Y方向上是否有重叠
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
    if X(i)>Xp1
        u=1;
        
    end
end   %检查X方向上是否有重叠
end