function j=circulate_check(XX,Y,Xp1,Yp1,L)
%���BLһ��֮���Ƿ����ƶ����Ƿ񴥵ף�
e=1;
f=1;
Xp2=Xp1+L;
m=size(XX,1);
for i=1:m
    if XX(i,1) <= Xp1 && Xp1 < XX(i,2)
        e=i;
    end
end  %���¶�λ�ڵ�X����
for i=1:m
    if XX(i,1) < Xp2 && Xp2 <= XX(i,2)
        f=i;
    end
end   %���¶�λ�ڵ�X����
j=0;%��������Ҫ���м����
for i=e:f
    if Y(i)==Yp1
        j=1;
    end
end   %�ж��Ƿ񴥵�
end