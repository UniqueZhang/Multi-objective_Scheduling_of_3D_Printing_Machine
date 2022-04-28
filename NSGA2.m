function [ F1, pop , eval_count,t_run] = NSGA2(ObjFun, AlgOptions, ProbData,alldata)
% NSGA2 is the multi-objective optimization approach proposed in Deb,2002.
%% ==== Inputs ====
% ObjFun: [function handle] The function returns the objective values
%         [Outputs] = ObjFun(Chromosome, ProbData)
%         Chromosome: A vector representing the chromosome
%         Outputs: A vector representing the objective values

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

% ProbData: Data of the optimization problem. A user-defined data structure
% 优化问题的数据、用户定义的结构

% ==== Outputs ====
% F1: Non-dominated Solutions
% pop: Final Population 
% eval_count: the cumulated number of evaluations累积评估
% t_run: running time

%% Plot setting
plot_on = true;
% Number of Objective Functions

%% NSGA-II Parameters参数

MaxIt = AlgOptions.Generations;
PopSize = AlgOptions.PopulationSize;   %  size of sub-population

SelectionFcn = AlgOptions.SelectionFcn;
CrossoverFcn  = AlgOptions.CrossoverFcn;
MutationFcn = AlgOptions.MutationFcn;
pCrossover = AlgOptions.CrossoverRate;
pMutation = AlgOptions.MutationRate;
CreationFcn = AlgOptions.CreationFcn;

MaxEvalCount = AlgOptions.MaxEvalCount;
MaxEvalTime = AlgOptions.MaxEvalTime;

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

% =======  Create Initial Population =======
Chrom = CreationFcn(PopSize, ProbData,parts_data);

for i=1:PopSize
    pop(i).chrom= Chrom(i,:);
    pop(i).feats = ObjFun(pop(i).chrom, ProbData,parts_data,machine_data)';
end

eval_count = 0;
eval_count = eval_count + PopSize;

[pop, F_mat]=fastNonDominatedSorting(pop);%找出帕累托前沿的支配关系和批次

% Calculate Crowding Distance
pop=CalcCrowdingDistance(pop,F_mat);

% Sort Population according to the Rank and Crowding distance
[pop, F] = SortPopulation(pop);
% ==========================================


%% Figure
if plot_on
    figure(1)
    grid on;
end

%% NSGA-II Main Loop
cond_terminate = 0;

it = 0;               % Iteration counter
while not(cond_terminate)
    
    it = it +1;
    % Selection
    [ winners ] = SelectionFcn( pop,PopSize);

    %% ================= Reproduction ======================
    Child_chrom_all = [];                      % Matrix of the children's chromosomes.
    for i=1:2:PopSize
        % Reproduction with crossover
        if rand<pCrossover
            [Child_chrom1,Child_chrom2] = CrossoverFcn(winners(i).chrom, winners(i+1).chrom);
        else
            Child_chrom1 = winners(i).chrom;
            Child_chrom2 = winners(i+1).chrom;
%             Child_chrom = [winners(i).chrom ; winners(i+1).chrom];
        end
        
        % Reproduction with mutation
        if rand<pMutation
            Child_chrom1 = MutationFcn(Child_chrom1,parts_data);
            Child_chrom2 = MutationFcn(Child_chrom2,parts_data);
        end
        Child_chrom_all = [Child_chrom_all; Child_chrom1];
        Child_chrom_all = [Child_chrom_all; Child_chrom2];
    end
    
    chrom_all = cell2mat( {pop.chrom}');
    Child_chrom_all = unique(Child_chrom_all,'rows');%删去自身中重复的行
    
    % remove duplicated chromosomes
    I = ismember(Child_chrom_all,chrom_all,'rows');
    Child_chrom_all = Child_chrom_all(not(I),:);
    
    % evaluate the offsprings
      popc=repmat(empty_individual, size(Child_chrom_all,1),1);
    for vi = 1:size(Child_chrom_all,1)
        val_obj_children = ObjFun(Child_chrom_all(vi,:),ProbData,parts_data,machine_data);
        eval_count = eval_count + size(val_obj_children,1) ;
        popc(vi).chrom = Child_chrom_all(vi,:);
        popc(vi).feats = val_obj_children(1,:)';
    end

    
    
    % combine
    pop_all = [pop;popc];
    
    % Non-Dominated Sorting
    [pop_all, F_mat]=fastNonDominatedSorting(pop_all);
    
    % Calculate Crowding Distance
    pop_all=CalcCrowdingDistance(pop_all,F_mat);
    
    % Sort Population
    pop_all=SortPopulation(pop_all);
    
    % Generational scheme: take the first PopSize individuals
    pop = pop_all(1:PopSize);
    
    % Store F1
    F1=pop( [pop.Rank] ==1);
    [~,uo] = unique([F1.feats]','rows','stable');
    F1 = F1(uo);
    
    %% ================= Update Plot ======================
    if plot_on
        % Show Iteration Information
        disp(['Iteration ' num2str(it) ': Number of F1 Members = ' num2str(numel(F1))]);
        
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
    cond_terminate = (eval_count>=MaxEvalCount) ||(toc(time_start)*1000 >=MaxEvalTime(end))|| it>= MaxIt ;
    
    if cond_terminate
        break;
    end
    
end


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

