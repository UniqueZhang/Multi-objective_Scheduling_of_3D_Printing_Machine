function q=judgeX(data_rec,i,k)
q=0;
if (data_rec(i,2) < data_rec(k,2) && data_rec(k,2) < data_rec(i,4))|| ...,
             (data_rec(i,2) < data_rec(k,4) && data_rec(k,4) < data_rec(i,4))==1
         q=1;
end
end