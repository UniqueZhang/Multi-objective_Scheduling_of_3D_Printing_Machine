function j=check_BL()
%返回值是0就没问题
%遍历文件夹里的txt文件
PathRoot='C:\Users\ASUS\Desktop\BL\2\Test instances of Che et al., 2021';
list=dir(fullfile(PathRoot));
fileNum=size(list,1);
j=0;
for p=3:fileNum
    filename = fullfile(list(p).folder,list(p).name);
    [machine,parts,machine_data,parts_data]=data_input(filename);
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
    h=size(machine_data,2);
    for k=1:h
       data_rec=BLpack(data_lw,machine_data(k).L,machine_data(k).W);
       r=check_all(data_rec);
       if r==0
          j=1;
          
       end
    end
    
end

end

