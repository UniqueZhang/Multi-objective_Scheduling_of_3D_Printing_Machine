function j=circulate_check(XX,Y,Xp1,Yp1,L)
%检查BL一次之后是否还能移动？是否触底？
e=1;
f=1;
Xp2=Xp1+L;
m=size(XX,1);
for i=1:m
    if XX(i,1) <= Xp1 && Xp1 < XX(i,2)
        e=i;
    end
end  %左下端位于的X区域
for i=1:m
    if XX(i,1) < Xp2 && Xp2 <= XX(i,2)
        f=i;
    end
end   %右下端位于的X区域
j=0;%接下来需要的中间变量
for i=e:f
    if Y(i)==Yp1
        j=1;
    end
end   %判断是否触底
end