function part_Chromosome = coding(parts_data)
%���룬���Ⱦɫ��
%part_Chromosome.oriention     ��ӡ����
%part_Chromosome.turn          װ��˳��
%N                       �����Ŀ


N = size(parts_data,2);

for i = 1 : N
    part_Chromosome(i).oriention = 1;
    part_Chromosome(i).turn = i;
end
end



