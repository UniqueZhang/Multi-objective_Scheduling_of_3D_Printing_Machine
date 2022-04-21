%±àÂë½âÂë
clc;clear all;
mm = 2;
[machine,parts,machine_data,parts_data]=data_input('C:\Users\ASUS\Desktop\BL\2\Test instances of Che et al., 2021\ht1_1.txt');
part_Chromosome = coding(parts_data);
fitness = decoding(part_Chromosome,parts_data,machine_data,mm);