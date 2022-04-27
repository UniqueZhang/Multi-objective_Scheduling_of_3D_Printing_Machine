%
% Copyright (c) 2015, Yarpiz (www.yarpiz.com)
% All rights reserved. Please read the "license.txt" for license terms.
%
% Project Code: YPEA120
% Project Title: Non-dominated Sorting Genetic Algorithm II (NSGA-II)
% Publisher: Yarpiz (www.yarpiz.com)
% 
% Developer: S. Mostapha Kalami Heris (Member of Yarpiz Team)
% 
% Contact Info: sm.kalami@gmail.com, info@yarpiz.com
%

function [pop, F]=fastNonDominatedSorting(pop)

% This version is an improved version of the Non domination sorting
% function to increase running speed, by removing the use of cell structure
% to allow the conversion to mex function 

    nPop=numel(pop);
    F = zeros(nPop,nPop);
    
    for i=1:nPop
        pop(i).DominationSet=[];
        pop(i).DominatedCount=0;
    end
    
    %F{1}=[];
    
    for i=1:nPop
        for j=i+1:nPop
            p=pop(i);
            q=pop(j);
            
            if Dominates(p.feats,q.feats)
                p.DominationSet=[p.DominationSet j];
                q.DominatedCount=q.DominatedCount+1;
            end
            
            if Dominates(q.feats,p.feats)
                q.DominationSet=[q.DominationSet i];
                p.DominatedCount=p.DominatedCount+1;
            end
            
            pop(i)=p;
            pop(j)=q;
        end
        
        if pop(i).DominatedCount==0
            %F{1}=[F{1} i];
            F(1,i) = 1;
            pop(i).Rank=1;
        end
    end
    
    k=1;
    
    while true
        
        Q= zeros(1,0);
        
        %for i=F{k}
        I = find(F(k,:));%找出了帕累托第k前沿
        for ii = 1:numel(I)
            i = I(ii);
            p=pop(i);%支配者p
            
            for jj= 1: numel( p.DominationSet)
                j = p.DominationSet(jj);
                q=pop(j);%被支配者q
                
                q.DominatedCount=q.DominatedCount-1;%支配者等级+1
                
                if q.DominatedCount==0%如果变成了接下来的第k+1前沿，就记下来
                    Q=[Q j]; %#ok，避免break
                    q.Rank=k+1;
                end
                
                pop(j)=q;
            end
        end
        
        if isempty(Q)
            break;
        end
        
        %F{k+1}=Q; %#ok
        F(k+1, Q) = 1;
        
        k=k+1;
        
    end
    
    F = F( sum(F,2)>0,:);
    
    %% subfunction
    
    
    function b=Dominates(x,y)
        
        %     if isstruct(x)
        %         x=x.feats;
        %     end
        %
        %     if isstruct(y)
        %         y=y.feats;
        %     end
        
        b=all(x<=y) && any(x<y);
        
    end
    
end