filename=input('请输入数据txt文件地址：\n','s');
[machine,parts,machine_data,parts_data]=data_input(filename);
%提取出目前仅需要的parts的l、w进数值数组data_lw
m=size(parts_data,2);
m1=1;
data_lw=[];
while m1<=m
    p=parts_data(m1).orientation_num;
    for u=1:p
        add_lw=[parts_data(m1).orientation(u).L,parts_data(m1).orientation(u).W];
        data_lw=[data_lw;add_lw];
    end
    if m1+p+1>m
        break;
    end
    m1=m1+p+1;
end
%获得工作台的尺寸
h=size(machine_data,2);
for k=1:h
data_rec=BLpack(data_lw,machine_data(k).L,machine_data(k).W);
r=check_all(data_rec);
if r==0
    disp('有重叠');
else
    disp('没有重叠');
end
figure
rectangle('Position',[0 0 machine_data(k).L machine_data(k).W])
m=size(data_rec,1);
for i=3:m
    rectangle('Position',[data_rec(i,2) data_rec(i,3) data_rec(i,4)-data_rec(i,2) data_rec(i,5)-data_rec(i,3)])
    text(data_rec(i,2)+0.2,data_rec(i,3)+0.7,num2str(i-2))
    hold on;
end
end
