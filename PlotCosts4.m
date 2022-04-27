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
% In this version, we add an input to specify the pause time of the points


function [phd,th]=PlotCosts4(pop, mk_type, pauseT)

% mk_type = 'r*'
th = []; % text handle

feats=[pop.feats];
[C,ia,ic] = unique(feats','rows');
freq_tab = tabulate(ic);
freq = freq_tab(:,2);

n_jb = numel( pop(1).chrom ) -1;
chrom_all = [pop.chrom];
chrom_all = reshape(chrom_all, n_jb+1, numel(chrom_all)/(n_jb+1))';


n_obj = size(feats,1);
if n_obj<3
    phd = plot(feats(1,:),feats(2,:),mk_type,'MarkerSize',8);
    %th = text(C(:,1), C(:,2), num2str(freq));
    %th = text(feats(1,:), feats(2,:), num2str( chrom_all(:,1)));
else
    phd = plot3(feats(1,:),feats(2,:), feats(3,:),mk_type,'MarkerSize',8);
    %th = text(C(:,1), C(:,2), C(:,3), num2str(freq));
    
end
% plot the frequency of a point

if pauseT>0
    pause(pauseT);
end

% delete(phd);
% delete(th);

end