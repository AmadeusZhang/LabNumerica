% Esercizio 3
% stampa una matrice hilbertiana
n = 5;
M = zeros(n);
for ii = 1:n
    for jj = 1:n
        M(ii,jj) = 1/(ii+jj-1);
    end
end