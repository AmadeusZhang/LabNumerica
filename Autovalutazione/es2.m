% Ricerca degli zeri

tvect = linspace( 0.1, 2 );
f = @(x) 5 - 2 * exp(x) - ( exp(x)-1 )/x;
d1f = @(x) (exp(x) - 1)/x.^2 - exp(x)/x - 2*exp(x);
plot( tvect, f(tvect), tvect, d1f(tvect) );
grid on;
legend( 'f(x)', 'g(x)' );

%% Il metodo di Newton

% Descrizione:
% x^(k+1) = x^(k) - f(x^k)/qk, qk := f'(x^k), x^k := x al k-esimo passo

d2f = @(x) (2*exp(x))/x.^2 - exp(x)/x - 2*exp(x) - (2*(exp(x) - 1))/x.^3;
hold on;
plot( tvect, d2f(tvect) );
legend( 'f(x)', 'df(x)', 'd^2f(x)' );

% f è C2 in I => f ha convergenza di ordine 2

%% Implementazione del metodo di Newton
toll = 1e-6; x0 = 2; nmax = 1e3;

[xvect, it] = newton( x0, nmax, toll, f, d1f, 1 );

it