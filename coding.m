function part_Chromosome = coding(parts_data)
%编码，获得染色体
%part_Chromosome.oriention     打印方向
%part_Chromosome.sequence      装箱顺序
%N                             零件数目

%随机初始化
N = size(parts_data,2);
p = randperm(N);
part_Chromosome.sequence = [];
part_Chromosome.oriention = [];
part_Chromosome = repmat(part_Chromosome,N,1);
for i = 1:N
    part_Chromosome(i).sequence = p(i);
    part_Chromosome(i).oriention = randi(parts_data(i).orientation_num) ;    
end
end

