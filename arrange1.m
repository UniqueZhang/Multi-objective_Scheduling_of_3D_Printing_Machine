function [Group,data_lwhsv] = arrange1(part_Chromosome,parts_data,machine_data,mm)
%%实现所有零件的顺序排样
%使用第mm台机器

%按照染色体中顺序，生成零件排样数值数组data_lw
m=size(parts_data,2);
for m1 = 1:m
    for m2 = 1:m
        if part_Chromosome(m2).turn == m1
            or = part_Chromosome(m2).oriention;
            data_lw(m1,1) = parts_data(m2).orientation(or).L;
            data_lw(m1,2) = parts_data(m2).orientation(or).W;
            data_h(m1,1) = parts_data(m2).orientation(or).H;
            data_s(m1,1) = parts_data(m2).orientation(or).support;
            data_v(m1,1) = parts_data(m2).volume;
        end
    end
end
data_lwh = [data_lw,data_h];
data_lwhs = [data_lwh,data_s];
data_lwhsv = [data_lwhs,data_v];
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