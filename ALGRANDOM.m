function [ F1, pop ,t_run] = ALGRANDOM(ObjFun, AlgOptions, ProbData,alldata)
%% ==== Inputs ====
% ObjFun: [function handle] The function returns the objective values
%         [Outputs] = ObjFun(Chromosome, ProbData)
%         Chromosome: A vector representing the chromosome
%         Outputs: A vector representing the objective values

% AlgOptions: Options of the Algorithm
%  - CreationFcn: [function handle] The function creating the initial pop

% ProbData: Data of the optimization problem. A user-defined data structure
% 优化问题的数据、用户定义的结构

% ==== Outputs ====
% F1: Non-dominated Solutions
% pop: Final Population
% t_run: running time

%% Plot setting
plot_on = true;
% Number of Objective Functions

%% NSGA-II Parameters参数

MaxIt = AlgOptions.Generations;
PopSize = AlgOptions.PopulationSize;   %  size of sub-population
CreationFcn = AlgOptions.CreationFcn;

machine = alldata.machine;
parts = alldata.parts ;
machine_data = alldata.machinedata ;
parts_data = alldata.partsdata ;

%% Initialize time counter
time_start = tic;

%% Initialization

% ==== Define individual structure ====
empty_individual.chrom= [];
empty_individual.feats=[];
empty_individual.Cost = [];
empty_individual.Rank= 0;
empty_individual.DominationSet=0;
empty_individual.DominatedCount=0;
empty_individual.CrowdingDistance= 0;
empty_individual.id= 0;
% =====================================
pop=repmat(empty_individual,PopSize,1);
pop_1 = pop;
%% 每50个染色体为一个种群，每两个种群之间相互比较得出支配关系和新种群（50染色体）
Chrom_1 = CreationFcn(PopSize, ProbData,parts_data);
 for i=1:size(Chrom_1,1)
        pop(i).chrom= Chrom_1(i,:);
        pop(i).feats = ObjFun(pop(i).chrom, ProbData,parts_data,machine_data)';
     end

for ipop = 2:MaxIt
    Chrom_2 = CreationFcn(PopSize, ProbData,parts_data);
    
   % remove duplicated chromosomes
    I = ismember(Chrom_2,Chrom_1,'rows');
    Chrom_2 = Chrom_2(not(I),:);
    
     for i=1:size(Chrom_2,1)
        pop_1(i).chrom= Chrom_2(i,:);
        pop_1(i).feats = ObjFun(pop_1(i).chrom, ProbData,parts_data,machine_data)';
     end
    
    Chrom_2 = [Chrom_1;Chrom_2];
    
    pop = [pop;pop_1];   
    
    %remove chromosomes whose feats are duplicated
    all_obj_Chrom_2 = [];
    for ii = 1:numel(pop)
        obj_Chrom_2 = pop(ii).feats';
        all_obj_Chrom_2 = [all_obj_Chrom_2;obj_Chrom_2] ;
    end
    
    [~,rows_needs,~] = unique(all_obj_Chrom_2,'rows','stable');
    Chrom_2 = Chrom_2(rows_needs,:);
    
    POP = [];
    for irow = 1:size(rows_needs,1)
        POP1 = pop(rows_needs(irow));   
        POP = [POP;POP1];
    end
    pop = POP;
           
    [pop, F_mat]=fastNonDominatedSorting(pop);%找出帕累托前沿的支配关系和批次
    
    % Calculate Crowding Distance
    pop=CalcCrowdingDistance(pop,F_mat);
    
    % Sort Population according to the Rank and Crowding distance
    [pop, F] = SortPopulation(pop);
    
    % keep popsize <= PopSize
    Chrom_1 = [];
    for ipop1 = 1:numel(pop)
        Chrom_11 = pop(ipop1).chrom;
        Chrom_1 = [Chrom_1;Chrom_11];
    end
    if size(Chrom_1,1) > PopSize
        Chrom_1 = Chrom_1(1:50,:);
        for ik = PopSize+1:numel(pop)
            pop(PopSize+1) = [];
        end
    end
end

%% Figure
if plot_on
    figure(1)
    grid on;
end

% Store F1
F1=pop( [pop.Rank] ==1);
[~,uo] = unique([F1.feats]','rows','stable');
F1 = F1(uo);

%% ================= Plot ======================
if plot_on
    % Show Iteration Information
    disp(['Iteration ' num2str(1) ': Number of F1 Members = ' num2str(numel(F1))]);
    
    % Plot Archive Costs
    
    figure(1);
    xlabel('support');
    ylabel('time');
    pauseT_arc = 0.5;
    
    feats = [pop.feats];
    y1 = feats(1,:);
    y2 = feats(2,:);
    ub_y1 = max(y1)*1.2;
    ub_y2 = max(y2)*1.2;
    axis([min(y1)*0.8, ub_y1, min(y2)*0.8, ub_y2]);
    mk_type = 'b*';
    [hd_a_pop,hd_b_pop] = PlotCosts4(pop, mk_type, pauseT_arc);
    grid on;
    hold on;
    mk_type = 'go';
    [hd_a_F1,hd_b_F1] = PlotCosts4(F1, mk_type, pauseT_arc);
    delete( [hd_a_F1;hd_b_F1;hd_a_pop;hd_b_pop]);
end

%% Check termination
if plot_on
    figure(1)
    pauseT = 0.5;
    [hd_a,hd_b]=PlotCosts4(pop, 'r*', pauseT);
    hold on;
    [hd_a,hd_b]=PlotCosts4(F1, 'b*', pauseT);
    hold on;
    grid on;
    xlabel('support');
    ylabel('time');
    legend({'Dominated Solutions','Non-Dominated Solutions'});
end

t_run =toc(time_start);


end