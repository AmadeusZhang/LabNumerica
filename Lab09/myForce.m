function y = myForce(x)
% approssima la forzante con il polinomio interpolante p(x)

%==========================================================================
% PARAMETRI DI INGRESSO:
%       x       vettore dei punti equispaziati contenente in [-1,1]
%
% PARAMETRI DI OUTPUT:
%       y       vettore dei punti valutati in x col polinomio p_fit
%==========================================================================

% vettori xnod ynod
xnod = (-1: 0.5: 1)';
ynod = [-0.9 0.01 1.01 0 -1.05]';

n = length(xnod);

% interpolazione --> polyfit

p_fit = polyfit( xnod, ynod, n-1 );   

% restituire il valore in x --> polyval

y = polyval( p_fit, x );

end