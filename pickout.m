 function [x_new] = pickout(x,n)
        % x: the vector
        % n: the position of the element to be picked out
        x_new = x;
        x_new(n) = [];
        
    end