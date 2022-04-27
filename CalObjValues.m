function [ ObjVals ] = CalObjValues( Chroms, ProbData,parts_data,machine_data)
%% CalObjValues Summary of this function goes here
% This function calculates the objectives of the chromosomes
%% Inputs and outputs
% ======= Inputs =======
% Chroms: Matrix of the Chromosomes
%        Chroms(i,:): The i-th chromosome
% ProbData: Data structure of the problem
% ======= Outputs =======
% ObjVals: Matrix of the calculated objective values
%        ObjVals(i,:): Vector of objective values of the i-th chromosome

%% Algorithm

%先把每条染色体数据格式转过来
n_chrom = size(Chroms,1);
ObjVals = zeros(n_chrom,2);
part_Chromosome.sequence = [];
part_Chromosome.oriention = [];
part_Chromosome = repmat(part_Chromosome,ProbData.n / 2,1);
for i = 1 : n_chrom
    for u = 1 : ProbData.n / 2
        part_Chromosome(u).sequence = Chroms(i,u);
        part_Chromosome(u).oriention = Chroms(i,u + ProbData.n / 2);
    end
    fitness = decoding2(part_Chromosome,parts_data,machine_data);
    ObjVals(i,1) = fitness.support + ProbData.m ;
    ObjVals(i,2) = fitness.time  + ProbData.m ;
end


% n_chrom = size(Chroms,1);
% ObjVals = zeros(n_chrom,2);
% 
% for i=1:n_chrom
%     ObjVals(i,1) = Chroms(i,end/2-1)/Chroms(i,end/2+1) + ProbData.m;
%     ObjVals(i,2) = Chroms(i,end)/Chroms(i,1) + ProbData.m ;
% end

end

