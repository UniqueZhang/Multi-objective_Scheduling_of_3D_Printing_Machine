function adaptation = decoding(part_Chromosome,parts_data,machine_data,mm)
%���룬�����Ӧֵ
%adaptation.support    ��֧�����
%adaptation.time       �ܴ�ӡʱ��
%TS(ti).time           ÿ�����δ�ӡʱ��
%TS(ti).support        ÿ�����δ�ӡ����

adaptation.support = 0;
adaptation.time = 0;
n = size(part_Chromosome,2);

%������˳�������

[Group,data_lwhsv] = arrange1(part_Chromosome,parts_data,machine_data,mm);
g = size(Group,2);

Sm = machine_data(mm).S;
Vm = machine_data(mm).V;
Um = machine_data(mm).U;

ti = 1;
%��ֵ

for s = 2:g
    sv = 0;
    sp = 0;
    First = Group(s-1);
    Last = Group(s) -1;
    for ss = First:Last
        sv = sv + data_lwhsv(ss,4) + data_lwhsv(ss,5);
        sp = sp + data_lwhsv(ss,4);
    end
    
    data_lwhsv_new = data_lwhsv;
    data_lwhsv_new(1:First-1,:) = [];
    data_lwhsv_new(Last+1:n,:) = [];
    hmax = max(data_lwhsv_new);
    h_max = hmax(3);
    TS(ti).time = Sm + Vm * sv + Um * h_max;
    TS(ti).support = sp;
    
    adaptation.time = adaptation.time + TS(ti).time;
    adaptation.support = adaptation.support + TS(ti).support;
    ti = ti + 1;
end
end

        



