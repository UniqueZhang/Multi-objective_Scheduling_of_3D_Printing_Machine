function rec_p=delete_rec(data_rec,Xp1,Yp1,L,W)
Xp3=Xp1+L;
Yp3=Yp1+W;
m=size(data_rec,1);
k=2;
while k~=m+1
    if data_rec(k,2) >= Xp3 || data_rec(k,3)>= Yp3
        data_rec(k,:)=[];
        k=k-1;
        m=m-1;
    end
    k=k+1;
end
rec_p=data_rec;
end