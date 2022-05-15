clc
close all
clear all
%%

%% Problem Setup 

[machine1,parts1,machine_data1,parts_data1]=data_input('C:\Users\ASUS\Desktop\BL\2\ALG_random\Test instances of Che et al., 2021\ht100_3.txt');
%生成多组染色体并解码
ProbData.n = 2*size(parts_data1,2);
ProbData.m = 5;

alldata.machine = machine1;
alldata.parts = parts1;
alldata.machinedata = machine_data1;
alldata.partsdata = parts_data1;


%% Algorithm Setup

% AlgOptions: Options of the Algorithm
%  - CreationFcn: [function handle] The function creating the initial pop

% ==== Outputs ====
% F1: Non-dominated Solutions
% pop: Final Population 
% t_run: running time

AlgOptions.Generations = 10;
AlgOptions.PopulationSize = 50;
AlgOptions.CreationFcn = @Creation;%初始化


ObjFun = @CalObjValues;%目标函数的计算
[ F1, pop , t_run] = ALGRANDOM(ObjFun, AlgOptions, ProbData,alldata)