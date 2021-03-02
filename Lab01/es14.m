% Esercizio 14

%% Rappresentare una circoferenza
f = @(x,y) x.^2 + y.^2 -1;
x = linspace(-5,5,50);
plot(f(x),f(x));