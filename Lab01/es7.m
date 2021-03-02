% Esercizio 7
% Calcolo determinante

function [d] = es7(A)
    [n, m] = size(A);
    d = 0;
    if ( n == m )           % verifica se matrice quadrata
        if ( n == 1 )
            d = A;
        elseif ( n == 2 )
            d = A(1,1)*A(2,2)-A(1,2)*A(2,1);
        else
            for ii = 1:n
                idc = [1:ii-1, ii+1:n];
                idr = (2:n);
                d = d + (-1)^(ii+1) * A(1,ii) * es7(A(idr, idc));
            end
        end
    else
        disp('si accetta solo matrici quadrate')
    end
end