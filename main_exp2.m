%% txt地址
 % 'C:\Users\ASUS\Desktop\BL\2\Test instances of Che et al., 2021\ht100_3.txt'
%% 对比实验的运行
clc
clear 

data_exp.plan = [];
data_exp.feats = [];
data_exp = repmat(data_exp,[4,1]);

filename = 'C:\Users\ASUS\Desktop\BL\2\Test instances of Che et al., 2021\ht100_3.txt';
[data_exp(1).plan,data_exp(1).feats] = experiment2_1(filename);
[data_exp(2).plan,data_exp(2).feats] = experiment2_2(filename);
[data_exp(3).plan,data_exp(3).feats] = experiment2_3(filename);
[data_exp(4).plan,data_exp(4).feats] = experiment2_4(filename);

%% 存储数据
save('data_exp2\experiment2T1.mat','data_exp');






