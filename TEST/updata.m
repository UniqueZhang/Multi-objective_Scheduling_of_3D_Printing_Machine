function [XX,Y,X,YY]=updata(rec_p)
if size(rec_p)~=1
    m=max(rec_p);
else
    m=rec_p;
end
Lmax=m(4);
Wmax=m(5);
k=size(rec_p,1);
ww=[];
ll=[]; %ww=[横坐标，对应的最大Y值]，ll=[纵坐标，对应最大X值]
for p=0:0.1:Lmax
    w=0;
    for i=1:k
        if p >= rec_p(i,2) && p < rec_p(i,4) && w < rec_p(i,5)
            w=rec_p(i,5);
        end
    end
    w_new=[p,w];
    ww=[ww;w_new];
end%竖直方向进行了扫描
for p=0:0.1:Wmax
    l=0;
    for i=1:k
        if p >= rec_p(i,3) && p < rec_p(i,5) && l < rec_p(i,4)
            l=rec_p(i,4);
        end
    end
    l_new=[p,l];
    ll=[ll;l_new];
end%水平方向进行了扫描
%开始合并以上数据，进行XX，Y等数集的更新
XX=[];
Y=[];
X=[];
YY=[];
u=1;
j=1;
k1=size(ww,1);
k2=size(ll,1);
while j~=k1 %定位每一个X方向区间
    n=ww(u,2);
    for j=u:k1
        if ww(j,2)~=n
           break
        end
    end
   XX_P=[ww(u,1),ww(j,1)];
   Y_P=[n];
   XX=[XX;XX_P];
   Y=[Y;Y_P];
   u=j;
end  %XX,Y数集更新完成
e=1;
r=1;
while r~=k2 %定位每一个Y方向区间
    q=ll(e,2);
    for r=e:k2
        if ll(r,2)~=q
           break
        end
    end
   YY_P=[ll(e,1),ll(r,1)];
   X_P=[q];
   YY=[YY;YY_P];
   X=[X;X_P];
   e=r;
end %YY,X数集更新完成

    