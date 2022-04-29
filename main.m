clc
close all
clear all
%%

%% Problem Setup 

[machine1,parts1,machine_data1,parts_data1]=data_input('C:\Users\ASUS\Desktop\BL\2\Test instances of Che et al., 2021\ht100_3.txt');
%生成多组染色体并解码
ProbData.n = 2*size(parts_data1,2);
ProbData.m = 5;

alldata.machine = machine1;
alldata.parts = parts1;
alldata.machinedata = machine_data1;
alldata.partsdata = parts_data1;
% ProbData.n = 10;
% ProbData.m = 5;

%% Algorithm Setup

% AlgOptions: Options of the Algorithm
%  - SelectionFcn: [function handle] The function selecting the individuals for reproduction
%  - CreationFcn: [function handle] The function creating the initial pop
%  - CrossoverFcn: [function handle] crossover function 
%  - CrossoverRate: [float] crossover probability
%  - MutationFcn: [function handle] mutation function
%  = MutationRate: mutation probability
%  - Generations: Maximum number of generations       
%  - MaxEvalCount: Maximum number of solution evaluations
%  - MaxEvalTime : Maximum CPU Time

% ==== Outputs ====
% F1: Non-dominated Solutions
% pop: Final Population 
% eval_count: the cumulated number of evaluations累积评估
% t_run: running time

AlgOptions.Generations = 50;
AlgOptions.PopulationSize = 50;
AlgOptions.CreationFcn = @Creation;%初始化
AlgOptions.SelectionFcn = @TournamentSelection_nsga2;
AlgOptions.CrossoverFcn = @CrossOver;%交叉
AlgOptions.MutationFcn = @Mutation;%变异
AlgOptions.CrossoverRate = 0.5;
AlgOptions.MutationRate = 0.5;
AlgOptions.MaxEvalCount = inf;
AlgOptions.MaxEvalTime = inf;

ObjFun = @CalObjValues;%目标函数的计算
[ F1, pop , eval_count, t_run] = NSGA2(ObjFun, AlgOptions, ProbData,alldata)
%% F1结果画图
% for Fi = 1:size(F1,1)
%     chromfigure = F1(Fi).chrom ;
%     Batchtime_1{Fi} = figureBL(chromfigure,parts_data1,machine_data1);
% end

% %找不同 后半段
% aa = F1(1).chrom(101:end);
% bb = F1(2).chrom(101:end);
% cc = find(aa~=bb);
% 
% %检查一下，后半段是不是都是每个零件最小的support对应的方向
% yes = 0;
% %提取出support最小的方向们
% min_or = [];
% 
% for mi = 1:100
%     oi = parts_data1(mi).orientation_num;
%     spport_min =999;
%     for mmii = 1:oi
%         if parts_data1(mi).orientation(mmii).support < spport_min
%             spport_min = parts_data1(mi).orientation(mmii).support;
%             min_or1 = mmii;
%         end
%     end
%     min_or = [min_or min_or1];
% end
% 
% for ki = 1:2
%     aa = F1(ki).chrom(101:end);
%     cc = find(min_or~=aa);
% end





