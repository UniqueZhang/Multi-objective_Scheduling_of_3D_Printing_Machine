function [Plan,feats] = experiment2_3(filename)
%% 对比实验2.3
%启发式  打印顺序选择——H相近
%        打印方向选择——support最小
%% get Plan
% get data
[machine,parts,machine_data,parts_data]=data_input(filename);

%得到每个零件的support最小的方向集合 —— pos_supmin,以及高度集合H_parts
%(最小support相同的两个方向，选择H最小的方向)
pos_supmin = zeros(1,size(parts_data,2));
H_parts = zeros(1,size(parts_data,2));
for i = 1:size(parts_data,2)
    n = parts_data(i).orientation_num;
    suppport_thispart = zeros(1,n);
    for in = 1:n
        suppport_thispart(in) = parts_data(i).orientation(in).support;
    end
    [~,num] = find(suppport_thispart==min(suppport_thispart));
    if size(num,2)~=1
        H_these = zeros(1,size(num,2));
        for i2 = 1:size(num,2)
            H_these(i2) = parts_data(i).orientation(num(i2)).H;
        end
        [~,b] = min(H_these);
        pos_supmin(i) = num(b);
    else
        pos_supmin(i) = num(1);
    end
    H_parts(i) = parts_data(i).orientation(pos_supmin(i)).H;
end

%根据H_parts，面积从大到小排序得到打印顺序 —— parts_order
[~,H_order] = sort(H_parts,'descend');

parts_order = zeros(1,size(parts_data,2));
for p = 1:size(parts_data,2)
    parts_order(H_order(p)) = p;
end   

%根据parts_order重新排序pos_supmin
pos_supmin = pos_supmin(parts_order);

%构成生产计划
Plan = [parts_order pos_supmin];
          
%% get feats
ProbData.n = 2*size(parts_data,2);
ProbData.m = 5;

feats = CalObjValues(Plan,ProbData,parts_data,machine_data)';

end









