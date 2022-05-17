function [Plan,feats] = experiment2_4(filename)
%% �Ա�ʵ��2.3
%����ʽ  ��ӡ˳��ѡ�񡪡������L*W���Ӵ�С
%        ��ӡ����ѡ�񡪡�support��С
%% get Plan
% get data
[machine,parts,machine_data,parts_data]=data_input(filename);

%�õ�ÿ�������support��С�ķ��򼯺� ���� pos_supmin,�Լ��������S_parts
%(��Сsupport��ͬ����������ѡ��H��С�ķ���)
pos_supmin = zeros(1,size(parts_data,2));
S_parts = zeros(1,size(parts_data,2));
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
    L = parts_data(i).orientation(pos_supmin(i)).L;
    W = parts_data(i).orientation(pos_supmin(i)).W;
    S_parts(i) = L * W;
end

%����S_parts������Ӵ�С����õ���ӡ˳�� ���� parts_order
[~,S_order] = sort(S_parts,'descend');

parts_order = zeros(1,size(parts_data,2));
for p = 1:size(parts_data,2)
    parts_order(S_order(p)) = p;
end   

%����parts_order��������pos_supmin
pos_supmin = pos_supmin(parts_order);

%���������ƻ�
Plan = [parts_order pos_supmin];
          
%% get feats
ProbData.n = 2*size(parts_data,2);
ProbData.m = 5;

feats = CalObjValues(Plan,ProbData,parts_data,machine_data)';

end








