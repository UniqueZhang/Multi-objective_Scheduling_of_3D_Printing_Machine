function [Xp1,Yp1,j]=packbox(L,W,XX,Y,X,YY,Xp1,Yp1)
Xp2=Xp1+L;
m=size(XX,1); 
a=1;
b=1;
for i=1:m
    if XX(i,1) < Xp1 && Xp1 <= XX(i,2)
        a=i;
    end
end  %���¶�λ�ڵ�X����
for i=1:m
    if XX(i,1) < Xp2 && Xp2 <= XX(i,2)
        b=i;
    end
end   %���¶�λ�ڵ�X����
a
b
for i=a:b
    if Y(i)>Yp1
        Yp1=Y(i);
    end
end   %Y����仯��������
Xpp=0;%������Ҫ���м���
Yp3=Yp1+W;%�����Ϸ���������
c=1;
d=1;
n=size(YY,1);
for i=1:n
    if YY(i,1) <= Yp1 && Yp1<= YY(i,2)
        c=i;
    end
end  %���¶�λ�ڵ�Y����
for i=1:n
    if YY(i,1) <= Yp3 && Yp3 <= YY(i,2)
        d=i;
    end
end   %���¶�λ�ڵ�Y����
c
d
for i=c:d
    if X(i)>Xpp
        Xpp=X(i);
    end
end   
Xp1=Xpp;
Xp2=Xpp+L;%X����仯��������
%�������֮���Ƿ����ƶ����Ƿ񴥵ף�
e=0;
f=0;
for i=1:m
    if XX(i,1) <= Xp1 && Xp1 <= XX(i,2)
        e=i;
    end
end  %���¶�λ�ڵ�X����
for i=1:m
    if XX(i,1) <= Xp2 && Xp2 <= XX(i,2)
        f=i;
    end
end   %���¶�λ�ڵ�X����
j=0;%��������Ҫ���м����
for i=e:f
    if Y(i)==Yp1
        j=1;
    end
end   %�ж��Ƿ񴥵�


        