function part_Chromosome = coding(parts_data)
%编码，获得染色体
%part_Chromosome.oriention     打印方向
%part_Chromosome.turn          装箱顺序
%N                       零件数目


N = size(parts_data,2);

for i = 1 : N
    part_Chromosome(i).oriention = 1;
    part_Chromosome(i).turn = i;
end
end



