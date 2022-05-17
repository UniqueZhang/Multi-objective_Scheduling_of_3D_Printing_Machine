function [Plan,feats] = experiment2_2(filename)
%% 对比实验2.2
%启发式  打印顺序选择——面积（L*W）从大到小
%        打印方向选择——H最低
%% get Plan
% get data
[machine,parts,machine_data,parts_data]=data_input(filename);

%得到每个零件的最小H的方向集合 —— pos_hmin
%(最小高度相同的两个方向，选择support最小的方向)
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
        pos_hmin(i) = num(b);
    else
        pos_hmin(i) = num(1);
    end
end

%根据pos_hmin，得到每个零件的打印面积 —— S_parts
S_parts = zeros(1,size(parts_data,2));
for k = 1:size(parts_data,2)
    L = parts_data(k).orientation(pos_hmin(k)).L;
    W = parts_data(k).orientation(pos_hmin(k)).W;
    S_parts(k) =  L * W;
end

%根据S_parts，面积从大到小排序得到打印顺序 —— parts_order
[~,S_order] = sort(S_parts,'descend');

parts_order = zeros(1,size(parts_data,2));
for p = 1:size(parts_data,2)
    parts_order(S_order(p)) = p;
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








