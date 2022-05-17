function [Plan,feats] = experiment2_1(filename)
%% 对比实验2.1
%启发式  打印顺序选择——H相近
%        打印方向选择——H最低
%% get Plan
% get data
[machine,parts,machine_data,parts_data]=data_input(filename);

%得到每个零件的最小H集合 —— parts_hmin
%得到每个零件的最小H的方向集合 —— pos_hmin
%(最小高度相同的两个方向，选择support最小的方向)
parts_hmin = zeros(1,size(parts_data,2));
pos_hmin = zeros(1,size(parts_data,2));
for i = 1:size(parts_data,2)
    n = parts_data(i).orientation_num;
    h_thispart = zeros(1,n);
    for in = 1:n
        h_thispart(in) = parts_data(i).orientation(in).H;
    end
    [~,num] = find(h_thispart==min(h_thispart));
    if size(num,2)~=1
        support_these = zeros(1,size(num,2));
        for i2 = 1:size(num,2)
            support_these(i2) = parts_data(i).orientation(num(i2)).support;
        end
        [~,b] = min(support_these);
        parts_hmin(i) = parts_data(i).orientation(num(b)).H;
        pos_hmin(i) = num(b);
    else
        [parts_hmin(i),pos_hmin(i)] = min(h_thispart);
    end
end

%根据H,从高到低排序得到打印顺序 —— parts_order
[~,h_order] = sort(parts_hmin,'descend');

parts_order = zeros(1,size(parts_data,2));
for k = 1:size(parts_data,2)
    parts_order(h_order(k)) = k;
end   

%根据parts_order重新排序pos_hmin
pos_hmin = pos_hmin(parts_order);

%构成生产计划
Plan = [parts_order pos_hmin];
          
%% get feats
ProbData.n = 2*size(parts_data,2);
ProbData.m = 5;

feats = CalObjValues(Plan,ProbData,parts_data,machine_data)';

end








