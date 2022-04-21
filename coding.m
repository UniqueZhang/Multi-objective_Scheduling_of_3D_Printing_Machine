function part_Chromosome = coding(parts_data)
%编码，获得染色体
%part_Chromosome.oriention     打印方向
%part_Chromosome.sequence      装箱顺序
%N                             零件数目

%随机初始化
N = size(parts_data,2);
p = randperm(N);
for i = 1:N
    part_Chromosome(i).sequence = p(i);
    part_Chromosome(i).oriention = randi(parts_data(i).orientation_num) ;    
end

