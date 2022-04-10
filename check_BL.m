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
    data_lw=zeros(m,2);
    while m1<=m
        u=1;
        add_lw=[parts_data(m1).orientation(u).L,parts_data(m1).orientation(u).W];
        data_lw(m1,:)=add_lw;
        m1=m1+1;
    end
    h=size(machine_data,2);
     v=['第',num2str(p-2),'文件'];
       disp(v);
    for k=1:h
       data_rec=BLpack(data_lw,machine_data(k).L,machine_data(k).W);
       r=check_all(data_rec);
      
       if r==0
          j=1;
          disp("BL失败，有重叠");
       else
           disp("BL成功，没有重叠");
          
       end
    end
    
end   

end

