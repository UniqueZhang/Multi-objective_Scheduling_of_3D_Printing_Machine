function [Xp1,Yp1]=packbox_left(W,X,YY,Yp1)
Xpp=0;%������Ҫ���м���
Yp3=Yp1+W;%�����ϱߵ�������
c=1;
d=1;
n=size(YY,1);
for i=1:n
    if YY(i,1) <= Yp1 && Yp1< YY(i,2)
        c=i;
    end
end  %���¶�λ�ڵ�YY����
for i=1:n
    if YY(i,1) < Yp3 && Yp3 <= YY(i,2)
        d=i;
    end
end   %���¶�λ�ڵ�YY����
for i=c:d
    if X(i)>Xpp
        Xpp=X(i);
    end
end   
Xp1=Xpp;%X����仯��������
end