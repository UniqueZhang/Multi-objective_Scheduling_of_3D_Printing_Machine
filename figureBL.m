function Branch = figureBL(chromfigure,parts_data1,machine_data1)

length_ch = size(chromfigure,2);
[~,Turn] = sort(chromfigure(1:length_ch/2));
%预设空间，提高运行速度
m=size(parts_data1,2);
data_lwhsv = zeros(m,5);
%按打印顺序填满data_lwhsv
for i2 = 1: m
    data_lwhsv(i2,1) =  parts_data1(Turn(i2)).orientation(chromfigure(Turn(i2)+length_ch/2)).L;
    data_lwhsv(i2,2) =  parts_data1(Turn(i2)).orientation(chromfigure(Turn(i2)+length_ch/2)).W;
    data_lwhsv(i2,3) =  parts_data1(Turn(i2)).orientation(chromfigure(Turn(i2)+length_ch/2)).H;
    data_lwhsv(i2,4) =  parts_data1(Turn(i2)).orientation(chromfigure(Turn(i2)+length_ch/2)).support;
    data_lwhsv(i2,5) =  parts_data1(Turn(i2)).volume;
end
data_lw = data_lwhsv;
data_lw(:,3:5) = [];
%进行BL，并将每一批次结果存入元胞数组Branch
kk = 0;
Bi = 1;
T_first = 1;
Dn = size(data_lw,1);
% Branch = cell(1,1);
mm=2;
while kk == 0
    [data_rec,k,k2]=BLpack(data_lw,machine_data1(mm).L,machine_data1(mm).W);
    %画图
    r=check_all(data_rec);
    if r==0
        disp('有重叠');
    else
        disp('没有重叠');
    end
    figure
    rectangle('Position',[0 0 machine_data1(mm).L machine_data1(mm).W])
    m=size(data_rec,1);
    for i=3:m
        rectangle('Position',[data_rec(i,2) data_rec(i,3) data_rec(i,4)-data_rec(i,2) data_rec(i,5)-data_rec(i,3)])
        text(data_rec(i,2)+0.2,data_rec(i,3)+0.7,num2str(i-2))
        hold on;
    end
    %改参
    Branch(Bi) = {Turn(T_first:T_first+k-2)};
    if k == Dn && k2 == 0
        Branch(Bi) = {Turn(T_first:T_first+k-1)};  
        break;              
    end
    data_lw(1:k-1,:) = [];
    T_first = k;
    Dn = size(data_lw,1);
    Bi = Bi + 1;
    k2 = 0;
end
end