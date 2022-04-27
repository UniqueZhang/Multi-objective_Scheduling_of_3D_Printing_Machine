%编码解码
clc;clear all;
mm = 2;
[machine,parts,machine_data,parts_data]=data_input('C:\Users\ASUS\Desktop\BL\2\Test instances of Che et al., 2021\ht1_1.txt');
%生成N组染色体并解码
N = 50;
Chromosome.parts = [];
Chromosome.fitness = [];
Chromosome = repmat(Chromosome,[N,1]);
for i = 1:N
    part_Chromosome = coding(parts_data);
    fitness = decoding(part_Chromosome,parts_data,machine_data,mm);
    Chromosome(i).parts = part_Chromosome;
    Chromosome(i).fitness = fitness;
end
  
