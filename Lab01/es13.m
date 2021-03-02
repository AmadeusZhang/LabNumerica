% Esercizio 13
% Convergenza della successione

function [n] = es13(n0)
    % scelta n0 arbitrario, costruisco la successione in un vettore
    n(1)=n0;
    ii = 1;
    while n(ii) > 1
        if mod(n(ii), 2) == 0
            n(ii+1)=n(ii)/2;
        else
            n(ii+1)=3*n(ii)+1;
        end
        ii = ii+1;
    end
end