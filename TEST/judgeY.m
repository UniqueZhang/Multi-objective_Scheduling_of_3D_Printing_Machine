function p=judgeY(data_rec,i,k)
p=0;
if (data_rec(i,3) < data_rec(k,3) && data_rec(k,3) < data_rec(i,5))|| ...,
             (data_rec(i,3) < data_rec(k,5) && data_rec(k,5) < data_rec(i,5))==1
         p=1;
end
end