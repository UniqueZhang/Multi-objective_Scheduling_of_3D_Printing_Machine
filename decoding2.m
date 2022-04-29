function fitness = decoding2(part_Chromosome,parts_data,machine_data)
%���룬�����Ӧֵ
%fitness.support    ��֧�����
%fitness.time       �ܴ�ӡʱ��
%Batch(ti).time           ÿ�����δ�ӡʱ��
%Batch(ti).support        ÿ�����δ�ӡ����
%Batch(ti).h_max          ÿ�����δ�ӡ��߸߶�
mm = 2;
Sm = machine_data(mm).S;
Vm = machine_data(mm).V;
Um = machine_data(mm).U;

fitness.support = 0;
fitness.time = Um ;
n = size(part_Chromosome,2);

%������˳�������

[Branch,data_lwhsv] = arrange2(part_Chromosome,parts_data,machine_data,mm);
g = size(Branch,2);


%Ԥ����ռ��Batch
Batch.time = [];         
Batch.support = [];     
Batch.h_max = [];
Batch = repmat(Batch,[g,1]);
ti = 1;
%��ֵ
Last = 0;
for s = 1:g
    sv = 0;
    sp = 0;
    First = Last + 1;
    g1 = size(Branch{s},2);
    Last = First + g1 - 1;
    for ss = First:Last
        sv = sv + data_lwhsv(ss,4) + data_lwhsv(ss,5);
        sp = sp + data_lwhsv(ss,4);
    end
    
    data_lwhsv_new = data_lwhsv;
    
    
    if First - 1 < n
        data_lwhsv_new(1:First-1,:) = [];
        if Last + 1 <= n
            data_lwhsv_new(Last-First+2:n-First+1,:) = [];    
        end       
    else if Last + 1 <= n
            data_lwhsv_new(Last+1:n,:) = [];
        end
    end
    
    h_max = max(data_lwhsv_new(:,3));
     
   
    Batch(ti).time = Um + Vm * sv + Sm * h_max;
    Batch(ti).support = sp;
    Batch(ti).h_max = h_max;
    
    fitness.time = fitness.time + Batch(ti).time;
    fitness.support = fitness.support + Batch(ti).support;
    ti = ti + 1;
end