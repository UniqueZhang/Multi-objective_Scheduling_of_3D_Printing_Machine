function IndivChromMutated = Mutation(IndivChrom,parts_data)
%   Mutation performs the Shift-Based-Mutation
%   A random element in the chromosome is shifted to a random selected
%   position in the chromosome. 
%% Inputs and Outputs
% ======= Inputs =======
% IndivChrom: Matrix of the individuals' Chromosomes
%           IndivChrom(i,:): the chromosome of the i-th individual 
% NumIteration: Number of insertions

%% Here we remove a gene then insert it to another position in the permutation
%% test

N = size(IndivChrom,2);
IndivChrom1 = IndivChrom(1,1 : N/ 2);
IndivChrom2 = IndivChrom(1,N/2+1:end);

%% mutation of sequence
num_indiv = size(IndivChrom1,1);
NVARS = size(IndivChrom1,2);


NumIteration = 1;
for i=1:num_indiv
    parent = IndivChrom1(i,:);
    
    child = parent;
    % Job sequence chromosome mutation (Insert)
    for j=1:NumIteration
        
        pos_mut = randsample(NVARS,2);
        
        if pos_mut(2)>=pos_mut(1)                                          %If the element to be picked out is after the element to be inserted
            
            temp = child(pos_mut(2));
            child = pickout(child,pos_mut(2));
            child = insert(temp, child, pos_mut(1));
            
        else                                          %If the element to be picked out is before the element to be inserted
            temp = child(pos_mut(2));
            child = pickout(child,pos_mut(2));
            child = insert(temp, child, pos_mut(1)-1);                     %pos_mut(1) -1 because the position of the to-be-inserted element is reduced by 1
        end
    end
    
IndivChrom1 = child;
end
%% mutation of orientation

%找到有变异空间的点
k_data = size(parts_data,2);
num_not1 = [];
for ki = 1:k_data
    if parts_data(ki).orientation_num > 1
        num_not1 = [num_not1 ki];
    end
end

NVARS_2 = size(num_not1,2);
pos_mut2 = randsample(NVARS_2,1);
id_pos2 = num_not1(pos_mut2);
pi = 1;
if NVARS_2 ==0
    pi =0;
end

while pi == 1
    a = IndivChrom2(1,id_pos2);
    b = randi(parts_data(id_pos2).orientation_num);
    if not(a == b)
        IndivChrom2(1,id_pos2) = b;
        break;
    end
end
IndivChromMutated = [IndivChrom1 IndivChrom2];
%% subfunction
    function [x_new] = pickout(x,n)
        % x: the vector
        % n: the position of the element to be picked out
        x_new = x;
        x_new(n) = [];
        
    end

    function [x_new] = insert(a,x,n)
        % a: the element to insert
        % x: the vector
        % n: the position before which the element is inserted
        
        x_new= cat(2, x(1:n-1), a, x(n:end));
    end

end

