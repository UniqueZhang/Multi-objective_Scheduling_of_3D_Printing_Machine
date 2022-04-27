function IndivChromMutated = Mutation(IndivChrom)
%   Mutation performs the Shift-Based-Mutation
%   A random element in the chromosome is shifted to a random selected
%   position in the chromosome. 
%% Inputs and Outputs
% ======= Inputs =======
% IndivChrom: Matrix of the individuals' Chromosomes
%           IndivChrom(i,:): the chromosome of the i-th individual 
% NumIteration: Number of insertions

%% Here we remove a gene then insert it to another position in the permutation
num_indiv = size(IndivChrom,1);
NVARS = size(IndivChrom,2);
IndivChromMutated = zeros(num_indiv,NVARS);

NumIteration = 1;
for i=1:num_indiv
    parent = IndivChrom(i,:);
    
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
    
    IndivChromMutated(i,:) = child;
end

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

