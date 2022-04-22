%编码解码
clc;clear all;
mm = 2;
[machine,parts,machine_data,parts_data]=data_input('C:\Users\ASUS\Desktop\BL\2\Test instances of Che et al., 2021\ht1_1.txt');
%生成30组染色体并解码

for i = 1:30
    part_Chromosome = coding(parts_data);
    fitness = decoding(part_Chromosome,parts_data,machine_data,mm);
    Chromosome(i).parts = part_Chromosome;
    Chromosome(i).fitness = fitness;
end
  
