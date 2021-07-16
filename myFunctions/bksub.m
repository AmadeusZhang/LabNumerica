% backward substitution function

function [x] = bksub(L, f)
    n = size(L,1);
    x = zeros(n,1);
    x(n) = f(n)/L(n, n);
    for i = n-1 : -1 : 1
        
%         partialSum = 0;
%         for j = i+1 : n
%             partialSum = partialSum + L(i, j) * x(j);
%         end
        
        x(i) = ( f(i) - L(i, i+1: n) * x(i+1: n) ) / L(i, i);
    end
    
end
    