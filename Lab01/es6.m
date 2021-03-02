% Esercizio 6

function [flag] = es6(n)
    flag = 0;
    for a = 2:n-1
        if ( mod(n,a) == 0 )
            flag = 1;
            return
        end
    end
end