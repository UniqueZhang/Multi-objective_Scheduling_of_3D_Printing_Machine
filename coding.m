function part_Chromosome = coding(parts_data)
%���룬���Ⱦɫ��
%part_Chromosome.oriention     ��ӡ����
%part_Chromosome.sequence      װ��˳��
%N                             �����Ŀ

%�����ʼ��
N = size(parts_data,2);
p = randperm(N);
for i = 1:N
    part_Chromosome(i).sequence = p(i);
    part_Chromosome(i).oriention = randi(parts_data(i).orientation_num) ;    
end

