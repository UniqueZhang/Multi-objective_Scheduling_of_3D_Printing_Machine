function [Xp1,Yp1,j]=packbox(L,W,XX,Y,X,YY,Xp1,Yp1)
Xp2=Xp1+L;
m=size(XX,1); 
a=1;
b=1;
for i=1:m
    if XX(i,1) < Xp1 && Xp1 <= XX(i,2)
        a=i;
    end
end  %左下端位于的X区域
for i=1:m
    if XX(i,1) < Xp2 && Xp2 <= XX(i,2)
        b=i;
    end
end   %右下端位于的X区域
a
b
for i=a:b
    if Y(i)>Yp1
        Yp1=Y(i);
    end
end   %Y方向变化，即下移
Xpp=0;%后面需要的中间量
Yp3=Yp1+W;%矩形上方的纵坐标
c=1;
d=1;
n=size(YY,1);
for i=1:n
    if YY(i,1) <= Yp1 && Yp1<= YY(i,2)
        c=i;
    end
end  %左下端位于的Y区域
for i=1:n
    if YY(i,1) <= Yp3 && Yp3 <= YY(i,2)
        d=i;
    end
end   %右下端位于的Y区域
c
d
for i=c:d
    if X(i)>Xpp
        Xpp=X(i);
    end
end   
Xp1=Xpp;
Xp2=Xpp+L;%X方向变化，即左移
%检查左移之后是否还能移动？是否触底？
e=0;
f=0;
for i=1:m
    if XX(i,1) <= Xp1 && Xp1 <= XX(i,2)
        e=i;
    end
end  %左下端位于的X区域
for i=1:m
    if XX(i,1) <= Xp2 && Xp2 <= XX(i,2)
        f=i;
    end
end   %右下端位于的X区域
j=0;%接下来需要的中间变量
for i=e:f
    if Y(i)==Yp1
        j=1;
    end
end   %判断是否触底


        