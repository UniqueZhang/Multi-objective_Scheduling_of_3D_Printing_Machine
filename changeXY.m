function [XX,Y,X,YY]=changeXY(XX,Y,X,YY,Xp1,Yp1)
%�����������������
m=size(XX,1);
a=0;
b=0;
for i=1:m
    if XX(i,1) <= Xp1 && Xp1 <= XX(i,2)
        a=i;
    end
end %��λ��˵�
for i=1:m
    if XX(i,1) <= Xp2 && Xp2 <= XX(i,2)
        b=i;
    end
end %��λ�Ҷ˵�
Yp3=Yp1+W;
XX1=XX;
Y1=Y;
Y2=Y;
XX1(a,2)=Xp1;
XX1(a+1:m,:)=[];%XX1�ϲ�����֮�ϲ�
Y1(a+1:m,:)=[];
XXP=[Xp1,Xp2];%XXP�ϲ�����֮�м��
YP=[Yp3];
XX2(b,1)=Xp2;
XX2(1:b-1,:)=[];%XX2�ϲ�����֮�²�
Y2(1:b-1,:)=[];
XX=[XX1,XXP,XX2];        %���XX�ĳ������ºϲ�
Y=[Y1,YP,Y2];
%������Ҫ���Ҳ�ɾ���ص����У�������Ϊ�˵��غϵ����
n=size(XX,1);
t=0;
for i=1:n
    if XX(i,1)==XX(i,2)
        t=i;
    end
end   %�ҵ�
if t>0
    XX(t,:)=[];
    Y(t,:)=[];
end   %ɾ��
%����XX,Y��ȫ
%��ʼ����YY,X
m1=size(YY,1);
a1=0;
b1=0;
for i=1:m1
    if YY(i,1) <= Yp1 && Yp1 <= YY(i,2)
        a1=i;
    end
end %��λ�¶˵�
for i=1:m1
    if YY(i,1) <= Yp2 && Yp2 <= YY(i,2)
        b1=i;
    end
end %��λ�϶˵�
Xp2=Xp1+L;
YY1=YY;
YY2=YY;
X1=X;
X2=X;
YY1(a1,2)=Yp1;
YY1(a1+1:m1,:)=[];%YY1�ϲ�����֮�ϲ�
X1(a1+1:m1,:)=[];
YYP=[Yp1,Yp3];%YYP�ϲ�����֮�м��
XP=[Xp2];
YY2(b1,1)=Yp3;
YY2(1:b1-1,:)=[];%YY2�ϲ�����֮�²�
X2(1:b1-1,:)=[];
YY=[YY1,YYP,YY2];        %���YY�ĳ������ºϲ�
X=[X1,XP,X2];
%������Ҫ���Ҳ�ɾ���ص����У�������Ϊ�˵��غϵ����
n1=size(YY,1);
t1=0;
for i=1:n1
    if YY(i,1)==YY(i,2)
        t1=i;
    end
end   %�ҵ�
if t1>0
    YY(t1,:)=[];
    X(t1,:)=[];
end   %ɾ��


