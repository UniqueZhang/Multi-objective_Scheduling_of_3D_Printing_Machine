%PopObj�Ǹ� n*2 �ľ��󣬴���n����֧����Ŀ��ֵ��
%PF���������ߵĵ�ļ��ϣ���Ҫ����������ο���ģ���
clc
clear
%% ��ȡNSGA-������
%��ȡ���ݵ����ʵĸ�ʽ
load('data_NSGA2\test.mat','data_NSGA','pop');

%������ǰ��F1��Ŀ�꺯��ֵF1_Obj
F1 = data_NSGA{end};
F1_Obj = zeros(size(F1,1),2);
for i = 1:size(F1,1)
    F1_Obj(i,:) = F1(i).feats';
end

%��ȡ���е�Ŀ�꺯��ֵ��PF
PF = zeros(size(pop,1),2);
for i = 1:size(pop,1)
    PF(i,:) = pop(i).feats';
end

%% ��ȡexp_1����
addpath experiment1
load('experiment1\data_exp1\experiment1T1.mat','F1_exp1','pop_exp1');

%������ǰ��F1��Ŀ�꺯��ֵF1_exp1_Obj
F1_exp1_Obj = zeros(size(F1_exp1,1),2);
for i = 1:size(F1_exp1,1)
    F1_exp1_Obj(i,:) = F1_exp1(i).feats';
end

%��ȡ���е�Ŀ�꺯��ֵ��PF_exp1
PF_exp1 = zeros(size(pop_exp1,1),2);
for i = 1:size(pop_exp1,1)
    PF_exp1(i,:) = pop_exp1(i).feats';
end

%% ��ȡexp_2����
addpath experiment2
load('experiment2\data_exp2\experiment2T1.mat','data_exp');
F1_exp2_Obj = zeros(size(data_exp,1),2);
for i = 1:size(data_exp,1)
    F1_exp2_Obj(i,:) = data_exp(i).feats';
end

%% ʹ��HV ���������ж�
Score = HV(F1_Obj,PF);
Score_exp1 = HV(F1_exp1_Obj,PF_exp1);

%% ʹ��NHV ���������ж�
Score_N = NHV(F1_Obj,PF);
Score_exp1_N = NHV(F1_exp1_Obj,PF_exp1);

%% ʹ��MIGD ���������ж�
PF_all = [F1_Obj;F1_exp1_Obj;F1_exp2_Obj];
PF_all = [];
Score_M = MIGD(F1_Obj,PF_all);







