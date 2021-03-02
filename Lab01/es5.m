% Esercizio 5
x = [ 0 1 2 exp(1) 3 pi ];
f = @(x) x .* sin(x) + (1/2) .^ sqrt(x);
g = @(x) x .^ 4 + log(x.^3 + 1);