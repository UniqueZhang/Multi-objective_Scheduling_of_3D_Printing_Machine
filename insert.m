 function [x_new] = insert(a,x,n)
        % a: the element to insert
        % x: the vector
        % n: the position before which the element is inserted
        
        x_new= cat(2, x(1:n-1), a, x(n:end));
    end