function adaptation = decoding(part_Chromosome,parts_data,machine_data)
%解码，获得适应值
%adaptation.support    总支撑体积
%adaptation.time       总打印时间
%V                     打印机扫描速度
%U                     打印机上升的速度


%求总support
n = size(part_Chromosome,2);
adaptation.support = 0;
adaptation.time = 0;
for i = 1:n
    OR = part_Chromosome(i).oriention; %染色体中该零件打印方向
    adaptation.support = adaptation.support + parts_data(i).orientation(OR).support;
end

%求总time
V = machine_data(1).V;
U = machine_data(1).U;
[Group,data_lwh] = arrange1(part_Chromosome,parts_data,machine_data);
g = size(Group,2);


for s = 2:g
    S = 0; %S为总面积
    First = Group(s-1);
    Last = Group(s) -1;
    for ss = First:Last
        S = S + data_lwh(ss,1)*data_lwh(ss,2);
    end
    %ST是扫描时间，HT是上升时间
    ST = S / V;
    data_lwh_new = data_lwh;
    data_lwh_new(1:First-1,:) = [];
    data_lwh_new(Last+1:n,:) = [];
    hmax = max(data_lwh_new);
    h_max = hmax(3);
    HT = h_max / U;
    adaptation.time = adaptation.time + ST + HT ;
end
  adaptation.time   
        



