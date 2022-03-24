function [machine,parts,machine_data,parts_data]=data_input(filename)
data_table = importfile(filename);
data_txt=data_table{:,:};
machine.types=data_txt(1,1);%机器和零件的种类、数量数据分别提取为两个结构体machine和parts
parts.types=data_txt(1,2);
machine.num=data_txt(2,1);
parts.num=data_txt(2,2);
%所用机器的具体数据提取machine_data结构体
n=size(data_txt,1);
n1=3;
for i=3:n
     if ~isnan(data_txt(i,8))
      n1=i;
     else
         break;
     end
end              %找到了机器数据所在data_txt行数范围
%存入结构体中
for e=1:n1-2
    machine_data(e).id=data_txt(2+e,1);
    machine_data(e).num=data_txt(2+e,2);
    machine_data(e).V=data_txt(2+e,3);
    machine_data(e).U=data_txt(2+e,4);
    machine_data(e).S=data_txt(2+e,5);
    machine_data(e).L=data_txt(2+e,6);
    machine_data(e).W=data_txt(2+e,7);
    machine_data(e).H=data_txt(2+e,8);
end
%提取加工零件的数据进parts_data结构体
data_parts=data_txt;
data_parts(1:n1,:)=[];
%目前需要提取出零件的l、w(所有加工方向吧),数据收集进data_lw
m=size(data_parts,1);
m1=1;
data_lw=[];
while m1<=m
    p=data_parts(m1,3);
    parts_data(m1).id=data_parts(m1,1);
    parts_data(m1).num=data_parts(m1,2);
    parts_data(m1).orientation_num=data_parts(m1,3);
    parts_data(m1).volume=data_parts(m1,4);   
    for y=1:p
        parts_data(m1).orientation(y).L=data_parts(m1+y,1);
        parts_data(m1).orientation(y).W=data_parts(m1+y,2);
        parts_data(m1).orientation(y).H=data_parts(m1+y,3);
        parts_data(m1).orientation(y).support=data_parts(m1+y,4);
    end
    if m1+p+1>m
        break;
    end
    m1=m1+p+1;
end
end
