function pop = Creation(PopSize, ProbData,parts_data)
%% Creation 
% Creation is a user-defined function to generate the initial population used by NSGA2
%% Inputs & Outputs
% ====== Inputs ======
% PopSize: Population size
% ProbData: Data structure of the problem
% ====== Outputs ======
% pop: Matrix of the chromosomes of the initial population
%     pop(i,:): The chromosome of the i-th individual in the population

%% Algorithm
% N = size(parts_data,2);
% p = randperm(N);
% part_Chromosome.sequence = [];
% part_Chromosome.oriention = [];
% part_Chromosome = repmat(part_Chromosome,N,1);
% for i = 1:N
%     part_Chromosome(i).sequence = p(i);
%     part_Chromosome(i).oriention = randi(parts_data(i).orientation_num) ;    
% end
pop = zeros(PopSize,ProbData.n);
for i=1:PopSize
    pop(i,1:ProbData.n / 2) = randperm(ProbData.n / 2);
    p1 =1;
    for p =ProbData.n / 2 +1: ProbData.n
        pop(i,p) = randi(parts_data(p1).orientation_num);
        p1 = p1 +1;
    end
end
 
% pop = zeros(PopSize,ProbData.n);
% for i=1:PopSize
%     pop(i,:) = randperm(ProbData.n);
% end

end

