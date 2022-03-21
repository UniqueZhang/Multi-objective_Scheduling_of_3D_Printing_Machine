function [data_lw,data_LsWs]=data_input()
filename=input('请输入数据txt文件地址：\n','s');
data_table = importfile(filename);
data_txt=data_table{:,:};
types_machine=data_txt(1,1);%机器和零件的种类、数量四数据提取
types_parts=data_txt(1,2);
num_machine=data_txt(2,1);
num_parts=data_txt(2,2);
n=size(data_txt,1);%所用机器的数据提取
n1=3;
for i=3:n
     if ~isnan(data_txt(i,8))
      n1=i;
     else
         break;
     end
end              %找到了机器数据所在行数范围
%将其存入表中
data_machine=array2table(data_txt(3:n1,:),'VariableNames',{'machine_id','num_machine','V','U','S','L','W','H'});
data_LsWs=[data_machine.L,data_machine.W];
%加工零件的数据
data_parts=data_txt;
data_parts(1:n1,:)=[];
%目前需要提取出零件的l、w(所有加工方向吧),数据收集进data_lw
m=size(data_parts,1);
m1=1;
data_lw=[];
while m1<=m
    p=data_parts(m1,3);
    data_lw=[data_lw;data_parts(m1+1:m1+p,1:2)];
    if m1+p+1>m
        break;
    end
    m1=m1+p+1;
end
end
