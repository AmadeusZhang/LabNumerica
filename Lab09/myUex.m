function y = myUex(x)

%==========================================================================
% USAGE
%==========================================================================
% approssima la soluzione esatta con il polinomio interpolante p(x) dei
% nodi {(x_i, u_i)}
%
% PARAMETRI DI INGRESSO:
%   x       vettore dei nodi equispaziati
%
% PARAMETRI DI OUTPUT:
%   y       vettore dei punti valutati in x
%==========================================================================

xnod = (-1: 0.5: 1)';
ynod = [ 0 1.01 2.03 0.99 0 ]';

P = polyfit( xnod, ynod, 4 );
y = polyval( P, x );

end

