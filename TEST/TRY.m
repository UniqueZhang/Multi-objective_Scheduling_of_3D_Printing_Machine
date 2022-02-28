rec_all=[1,3;1,2;2,1;1,1.3;1,1.5;3,0.5;0.5,0.5];
Ls=5;
Ws=10;
data_rec=BLpack(rec_all,Ls,Ws);
figure
rectangle('Position',[0 0 5 10])
for i=3:9
    rectangle('Position',[data_rec(i,2) data_rec(i,3) data_rec(i,4)-data_rec(i,2) data_rec(i,5)-data_rec(i,3)])
    text(data_rec(i,2)+0.5,data_rec(i,3)+0.5,num2str(i-2))
    hold on;
end
