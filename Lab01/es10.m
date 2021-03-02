% Esercizio 10
f = @(x) -sqrt(x.^2-x) .* (x<0) + (-x.^2 + 2.*x) .* exp(-x) .* (x>=0);
x = linspace(-10,10,1000);
figure
plot(x,f(x))