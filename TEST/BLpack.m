function data_rec=BLpack(rec_all,Ls,Ws)
XX=[0,Ls];
Y=[0];
YY=[0,Ws];
X=[0];
data_rec=[0,0,0,Ls,0;0,0,0,0,Ws];
j=0;
n=size(rec_all,1);
for k=1:n   %ÿһ�����ο�ʼBL
    L=rec_all(k,1);
    W=rec_all(k,2);
    Xp1=Ls-L;
    Yp1=Ws-W;
    u=check_over(Xp1,Yp1,L,W,data_rec);
    if u==1
        vv=['��',num2str(k),'������Ų�����'];
        disp(vv);
        break
    end
    while j==0
        [Xp1,Yp1,j]=packbox(L,W,XX,Y,X,YY,Xp1,Yp1);%һ��BL�Լ������ж�
        rec_p=delete_rec(data_rec,Xp1,Yp1,L,W);%ɾ�����ϵľ���
        [XX,Y,X,YY]=updata(rec_p);%�����Ĵ�����
    end
    i=k;
    j=0;
    data_rec=save_data(data_rec,L,W,Xp1,Yp1,i);%����ÿ�ξ�������
    [XX,Y,X,YY]=updata(data_rec);%�����Ĵ�����
end
end
    
    



