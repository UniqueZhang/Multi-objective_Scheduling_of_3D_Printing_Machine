function r=check_all(data_rec)
r=1;
%���ÿһ�����ν����ص��ж�
m=size(data_rec,1);
for i=3:m-1
    for k=i+1:m
        q=judgeX(data_rec,i,k);
        p=judgeY(data_rec,i,k);
        if q && p == 1
            r=0;
           
        end
    end
end
end

       
          
         
            
    
