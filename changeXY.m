function [XX,Y,X,YY]=changeXY(XX,Y,X,YY,Xp1,Yp1)
%更新轮廓线坐标矩阵
m=size(XX,1);
a=0;
b=0;
for i=1:m
    if XX(i,1) <= Xp1 && Xp1 <= XX(i,2)
        a=i;
    end
end %定位左端点
for i=1:m
    if XX(i,1) <= Xp2 && Xp2 <= XX(i,2)
        b=i;
    end
end %定位右端点
Yp3=Yp1+W;
XX1=XX;
Y1=Y;
Y2=Y;
XX1(a,2)=Xp1;
XX1(a+1:m,:)=[];%XX1合并矩阵之上层
Y1(a+1:m,:)=[];
XXP=[Xp1,Xp2];%XXP合并矩阵之中间层
YP=[Yp3];
XX2(b,1)=Xp2;
XX2(1:b-1,:)=[];%XX2合并矩阵之下层
Y2(1:b-1,:)=[];
XX=[XX1,XXP,XX2];        %完成XX的初步更新合并
Y=[Y1,YP,Y2];
%现在需要查找并删除重叠的行，即表现为端点重合的情况
n=size(XX,1);
t=0;
for i=1:n
    if XX(i,1)==XX(i,2)
        t=i;
    end
end   %找到
if t>0
    XX(t,:)=[];
    Y(t,:)=[];
end   %删除
%更新XX,Y完全
%开始更新YY,X
m1=size(YY,1);
a1=0;
b1=0;
for i=1:m1
    if YY(i,1) <= Yp1 && Yp1 <= YY(i,2)
        a1=i;
    end
end %定位下端点
for i=1:m1
    if YY(i,1) <= Yp2 && Yp2 <= YY(i,2)
        b1=i;
    end
end %定位上端点
Xp2=Xp1+L;
YY1=YY;
YY2=YY;
X1=X;
X2=X;
YY1(a1,2)=Yp1;
YY1(a1+1:m1,:)=[];%YY1合并矩阵之上层
X1(a1+1:m1,:)=[];
YYP=[Yp1,Yp3];%YYP合并矩阵之中间层
XP=[Xp2];
YY2(b1,1)=Yp3;
YY2(1:b1-1,:)=[];%YY2合并矩阵之下层
X2(1:b1-1,:)=[];
YY=[YY1,YYP,YY2];        %完成YY的初步更新合并
X=[X1,XP,X2];
%现在需要查找并删除重叠的行，即表现为端点重合的情况
n1=size(YY,1);
t1=0;
for i=1:n1
    if YY(i,1)==YY(i,2)
        t1=i;
    end
end   %找到
if t1>0
    YY(t1,:)=[];
    X(t1,:)=[];
end   %删除


