%PopObj是个 n*2 的矩阵，代表n个非支配解的目标值，
%PF是所有曲线的点的集合（主要是用来计算参考点的）。
clc
clear
%% 提取NSGA-Ⅱ数据
%提取数据到合适的格式
load('data_NSGA2\test.mat','data_NSGA','pop');

%帕累托前沿F1的目标函数值F1_Obj
F1 = data_NSGA{end};
F1_Obj = zeros(size(F1,1),2);
for i = 1:size(F1,1)
    F1_Obj(i,:) = F1(i).feats';
end

%提取所有的目标函数值到PF
PF = zeros(size(pop,1),2);
for i = 1:size(pop,1)
    PF(i,:) = pop(i).feats';
end

%% 提取exp_1数据
addpath experiment1
load('experiment1\data_exp1\experiment1T1.mat','F1_exp1','pop_exp1');

%帕累托前沿F1的目标函数值F1_exp1_Obj
F1_exp1_Obj = zeros(size(F1_exp1,1),2);
for i = 1:size(F1_exp1,1)
    F1_exp1_Obj(i,:) = F1_exp1(i).feats';
end

%提取所有的目标函数值到PF_exp1
PF_exp1 = zeros(size(pop_exp1,1),2);
for i = 1:size(pop_exp1,1)
    PF_exp1(i,:) = pop_exp1(i).feats';
end

%% 提取exp_2数据
addpath experiment2
load('experiment2\data_exp2\experiment2T1.mat','data_exp');
F1_exp2_Obj = zeros(size(data_exp,1),2);
for i = 1:size(data_exp,1)
    F1_exp2_Obj(i,:) = data_exp(i).feats';
end

%% 使用HV 进行优劣判断
Score = HV(F1_Obj,PF);
Score_exp1 = HV(F1_exp1_Obj,PF_exp1);

%% 使用NHV 进行优劣判断
Score_N = NHV(F1_Obj,PF);
Score_exp1_N = NHV(F1_exp1_Obj,PF_exp1);

%% 使用MIGD 进行优劣判断
PF_all = [F1_Obj;F1_exp1_Obj;F1_exp2_Obj];
PF_all = [];
Score_M = MIGD(F1_Obj,PF_all);







