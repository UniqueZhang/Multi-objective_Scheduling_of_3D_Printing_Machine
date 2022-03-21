[data_lw,data_LsWs]=data_input();
h=size(data_LsWs,1);
for k=1:h
    Ls=data_LsWs(k,1);
    Ws=data_LsWs(k,2);
data_rec=BLpack(data_lw,Ls,Ws);
r=check_all(data_rec);
if r==0
    disp('有重叠');
else
    disp('没有重叠');
end
figure
rectangle('Position',[0 0 Ls Ws])
m=size(data_rec,1);
for i=3:m
    rectangle('Position',[data_rec(i,2) data_rec(i,3) data_rec(i,4)-data_rec(i,2) data_rec(i,5)-data_rec(i,3)])
    text(data_rec(i,2)+0.2,data_rec(i,3)+0.2,num2str(i-2))
    hold on;
end
end
