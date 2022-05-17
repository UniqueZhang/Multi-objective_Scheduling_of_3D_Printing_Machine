function [Plan,feats] = experiment2_2(filename)
%% �Ա�ʵ��2.2
%����ʽ  ��ӡ˳��ѡ�񡪡������L*W���Ӵ�С
%        ��ӡ����ѡ�񡪡�H���
%% get Plan
% get data
[machine,parts,machine_data,parts_data]=data_input(filename);

%�õ�ÿ���������СH�ķ��򼯺� ���� pos_hmin
%(��С�߶���ͬ����������ѡ��support��С�ķ���)
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

%����pos_hmin���õ�ÿ������Ĵ�ӡ��� ���� S_parts
S_parts = zeros(1,size(parts_data,2));
for k = 1:size(parts_data,2)
    L = parts_data(k).orientation(pos_hmin(k)).L;
    W = parts_data(k).orientation(pos_hmin(k)).W;
    S_parts(k) =  L * W;
end

%����S_parts������Ӵ�С����õ���ӡ˳�� ���� parts_order
[~,S_order] = sort(S_parts,'descend');

parts_order = zeros(1,size(parts_data,2));
for p = 1:size(parts_data,2)
    parts_order(S_order(p)) = p;
end   

%����parts_order��������pos_hmin
pos_hmin = pos_hmin(parts_order);

%���������ƻ�
Plan = [parts_order pos_hmin];
          
%% get feats
ProbData.n = 2*size(parts_data,2);
ProbData.m = 5;

feats = CalObjValues(Plan,ProbData,parts_data,machine_data)';

end








