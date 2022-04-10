function Group = arrange(filename)
%实现所有零件的顺序排样
[machine,parts,machine_data,parts_data]=data_input(filename);
%提取出目前仅需要的parts的l、w进数值数组data_lw
m=size(parts_data,2);
m1=1;
data_lw=[];
while m1<=m
    u=1;
    add_lw=[parts_data(m1).orientation(u).L,parts_data(m1).orientation(u).W];
    data_lw=[data_lw;add_lw];
    m1=m1+1;
end
%获得工作台的尺寸
k = 0;
pa = 1;
ga = 1;
Group(1) = 1;
while k ~= pa
    [data_rec,k]=BLpack(data_lw,machine_data(2).L,machine_data(2).W);
    r=check_all(data_rec);
    if r==0
        disp('有重叠');
    else
        disp('没有重叠');
    end
    figure
    rectangle('Position',[0 0 machine_data(2).L machine_data(2).W])
    m=size(data_rec,1);
    for i=3:m
        rectangle('Position',[data_rec(i,2) data_rec(i,3) data_rec(i,4)-data_rec(i,2) data_rec(i,5)-data_rec(i,3)])
        text(data_rec(i,2)+0.2,data_rec(i,3)+0.7,num2str(i-2))
        hold on;
    end
    ga = ga + 1;
    Group(ga) = Group(ga-1) + k - 1;
    pa = size(data_lw,1);
    if  k ~= pa
        data_lw(1:k-1,:) = [];      
        pa = size(data_lw,1);
    else
        Group(ga) = Group(ga) + 1;
        break
    end
end

end