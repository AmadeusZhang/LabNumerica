% foward substitution function

function [x] = fwsub(L, f)
    n = size(L,1);
    x = zeros(n,1);
    x(1) = f(1)/L(1, 1);
    for i = 2 : n
        
%         scrittura analitica
%
%         partialSum = 0;
%         for j = 1: i-1
%             partialSum = partialSum + L(i, j) * x(j);
%         end
%         
%         x(i) = ( f(i) - partialSum ) / L(i, i);

%         scrittura matriciale
          
        x(i) = ( f(i) - L(i, 1: i-1) * x(1: i-1) ) / L(i, i);

    end

end