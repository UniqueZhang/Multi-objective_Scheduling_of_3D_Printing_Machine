function [Group,data_lwhsv] = arrange1(part_Chromosome,parts_data,machine_data,mm)
%%实现所有零件的顺序排样
%使用第mm台机器


%按sequence对染色体排序,获得打印顺序的零件ID数组Turn
[~,Turn] = sort([part_Chromosome.sequence]);
%预设空间，提高运行速度
m=size(parts_data,2);
data_lwhsv = zeros(m,5);
%按打印顺序填满data_lwhsv
for i2 = 1: m
    data_lwhsv(i2,1) =  parts_data(Turn(i2)).orientation(part_Chromosome(Turn(i2)).oriention).L;
    data_lwhsv(i2,2) =  parts_data(Turn(i2)).orientation(part_Chromosome(Turn(i2)).oriention).W;
    data_lwhsv(i2,3) =  parts_data(Turn(i2)).orientation(part_Chromosome(Turn(i2)).oriention).H;
    data_lwhsv(i2,4) =  parts_data(Turn(i2)).orientation(part_Chromosome(Turn(i2)).oriention).support;
    data_lwhsv(i2,5) =  parts_data(Turn(i2)).volume;
end
data_lw =  data_lwhsv;
data_lw(:,3:5) = [];
%排样并得出批次结果
k = 0;
pa = 1;
ga = 1;
Group(1) = 1;

while k ~= pa
    [data_rec,k]=BLpack(data_lw,machine_data(mm).L,machine_data(mm).W);
    r=check_all(data_rec);
    if r==0
        disp('有重叠');
    else
        disp('没有重叠');
    end
    figure
    rectangle('Position',[0 0 machine_data(mm).L machine_data(mm).W])
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