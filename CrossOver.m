function [ChildChrom1, ChildChrom2]  = CrossOver(ParentChrom1, ParentChrom2)
%%   CrossOver performs the Precedence preserving order-based crossover (Zhang
%   et al., 2011)
%% Inputs and Outputs 
% ======= Inputs =======
%   ParentChrom1: Matrix of the Chromosomes of Parents in Group 1
%          ParentChrom1(i,:): Chromosome of the i-th Parent in Group1
%   ParentChrom2: Matrix of the Chromosomes of Parents in Group 2
%          ParentChrom2(i,:): Chromosome of the i-th Parent in Group2

% ======= Ouputs =======
%  ChildChrom1,2: Matrix of the Children's Chromosomes
%% test data
% clear ChildChrom1;clear ChildChrom2;clear child1_1;clear child1_2;
% ParentChrom1 = winners(1).chrom;
% ParentChrom2 = winners(2).chrom;

% ParentChrom1 = [1,6,3,4,5,2,1,2,3,4,5,6];
% ParentChrom2 = [4,3,1,2,6,5,6,5,4,3,2,1];
%% strat
NVARS = size(ParentChrom1,2);
ChildChrom1 = zeros(1,NVARS);       
ChildChrom2 = ChildChrom1;
%% 对零件顺序进行交叉 binary mask
ParentChrom1_1 = ParentChrom1(1,1 : NVARS / 2);
ParentChrom1_2 = ParentChrom2(1,1 : NVARS / 2);


parent1 = ParentChrom1_1;
parent2 = ParentChrom1_2;

child1_1=zeros(size(parent1));
child1_2=child1_1;

% ======= Job sequence crossover =======

% Step 1: position copy
geneexchangepos = randi([0 1], 1, NVARS/2);                              % The position of genes to be exchanged to Parent2
geneexchange_1 = parent1(geneexchangepos==1);                          % The genes to be copy directly to child1
geneexchange_2 = parent2(geneexchangepos==1);                          % The genes to be copy directly to child2

child1_1(geneexchangepos==1) = geneexchange_1;
child1_2(geneexchangepos==1) = geneexchange_2;

% Step 2: Sequence copy
[~,~,geneintsec_2]=intersect(parent1(geneexchangepos==0),parent2);     % Find out the position of the corresponding in Parent 2
[~,~,geneintsec_1]=intersect(parent2(geneexchangepos==0),parent1);     % Find out the position of the corresponding in Parent 1

child1_1(geneexchangepos==0) = parent2(sort(geneintsec_2));
child1_2(geneexchangepos==0) = parent1(sort(geneintsec_1));

ChildChrom1(1,1 : NVARS / 2) = child1_1;
ChildChrom2(1,1 : NVARS / 2) = child1_2;

%% 打印方向交叉， Two-point Crossover
ParentChrom2_1 = ParentChrom1(1,NVARS / 2 + 1:end);
ParentChrom2_2 = ParentChrom2(1,NVARS / 2 + 1:end);

parent11 = ParentChrom2_1;
parent22 = ParentChrom2_2;

child2_1=zeros(size(parent11));
child2_2=child2_1;

geneexchangepos_2 = randi([0 1], 1, NVARS/2); 

geneexchange_11 = parent11(geneexchangepos_2==1);                          
geneexchange_22 = parent22(geneexchangepos_2==1);                          
geneexchange_10 = parent11(geneexchangepos_2==0);                          
geneexchange_20 = parent22(geneexchangepos_2==0); 

child2_1(geneexchangepos_2==1) = geneexchange_11;
child2_2(geneexchangepos_2==1) = geneexchange_22;
child2_1(geneexchangepos_2==0) = geneexchange_20;
child2_2(geneexchangepos_2==0) = geneexchange_10;


ChildChrom1(1,NVARS / 2 + 1:end) = child2_1;
ChildChrom2(1,NVARS / 2 + 1:end) = child2_2;

end

