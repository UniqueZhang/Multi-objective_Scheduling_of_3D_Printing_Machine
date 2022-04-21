function [Branch,data_lwhsv] = arrange2(part_Chromosome,parts_data,machine_data,mm)
%��sequence��Ⱦɫ������,��ô�ӡ˳������ID����Turn
[~,Turn] = sort([part_Chromosome.sequence]);
%Ԥ��ռ䣬��������ٶ�
m=size(parts_data,2);
data_lwhsv = zeros(m,5);
%����ӡ˳������data_lwhsv
for i2 = 1: m
    data_lwhsv(i2,1) =  parts_data(Turn(i2)).orientation(part_Chromosome(Turn(i2)).oriention).L;
    data_lwhsv(i2,2) =  parts_data(Turn(i2)).orientation(part_Chromosome(Turn(i2)).oriention).W;
    data_lwhsv(i2,3) =  parts_data(Turn(i2)).orientation(part_Chromosome(Turn(i2)).oriention).H;
    data_lwhsv(i2,4) =  parts_data(Turn(i2)).orientation(part_Chromosome(Turn(i2)).oriention).support;
    data_lwhsv(i2,5) =  parts_data(Turn(i2)).volume;
end
data_lw = data_lwhsv;
data_lw(:,3:5) = [];
%����BL������ÿһ���ν������Ԫ������Branch
kk = 0;
Bi = 1;
T_first = 1;
Dn = size(data_lw,1);
k2 = 0;
while kk == 0
    [data_rec,k,k2]=BLpack(data_lw,machine_data(mm).L,machine_data(mm).W);
    %��ͼ
    r=check_all(data_rec);
    if r==0
        disp('���ص�');
    else
        disp('û���ص�');
    end
    figure
    rectangle('Position',[0 0 machine_data(mm).L machine_data(mm).W])
    m=size(data_rec,1);
    for i=3:m
        rectangle('Position',[data_rec(i,2) data_rec(i,3) data_rec(i,4)-data_rec(i,2) data_rec(i,5)-data_rec(i,3)])
        text(data_rec(i,2)+0.2,data_rec(i,3)+0.7,num2str(i-2))
        hold on;
    end
    %�Ĳ�
    Branch(Bi) = {Turn(T_first:T_first+k-2)};
    if k == Dn && k2 == 0
        Branch(Bi) = {Turn(T_first:T_first+k-1)};  
        break;              
    end
    data_lw(T_first:k-1,:) = [];
    T_first = k;
    Dn = size(data_lw,1);
    Bi = Bi + 1;
    k2 = 0;
end
end




