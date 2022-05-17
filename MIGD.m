function Score = MIGD(PopObj,PF)
% <metric> <min>
% Modified Inverted generational distance
%--------------------------------------------------------------------------
% Copyright (c) 2016-2017 BIMK Group. You are free to use the PlatEMO for
% research purposes. All publications which use this platform or any code
% in the platform should acknowledge the use of "PlatEMO" and reference "Ye
% Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB Platform
% for Evolutionary Multi-Objective Optimization [Educational Forum], IEEE
% Computational Intelligence Magazine, 2017, 12(4): 73-87".
%--------------------------------------------------------------------------

    %Distance = min(pdist2(PF,PopObj),[],2);
    
    n_a = size(PopObj,1);
    n_z = size(PF,1);
    A = PopObj;
    Z = PF;
    k = size(PF,2);
    
    PDist = zeros(n_z, n_a);
    for i = 1:n_z
        for j = 1:n_a
            d_za = 0;
            a = A(j,:);
            z = Z(i,:);
            for o = 1:k
                d_za = d_za + max( a(o) - z(o), 0)^2;
            end
            d_za = sqrt(d_za);
            PDist(i,j) = d_za;
        end
    end
    Distance = min(PDist,[],2);
    Score    = mean(Distance);
end