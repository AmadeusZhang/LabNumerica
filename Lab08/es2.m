% Esercizio 2 Laboratorio 8

f = @(x) exp(-x.^2) .* sin(x);

a = -2; b = 3;

xvect = linspace( a, b, 1e3 );
yvect = f( xvect );

%% a) Polinomio interpolante composito lineare

%==========================================================================
% INTERP1
%==========================================================================
% Parametri di ingresso:
%   - nodi di interpolazione
%   - valori della funzione in corrispondenza di tali nodi
%   - punti nei quale valutare il polinomio interpolante
%
% Parametri di uscita:
%   - valutazione del polinomio interpolante in tali punti
%
%==========================================================================

n = 3;

x_nod = linspace( a, b, n+1 );
y_nod = f( x_nod );

p_interp = interp1( x_nod, y_nod, xvect );

plot( xvect, yvect, 'k', xvect, p_interp, 'r' );
hold on; grid on;
plot( x_nod, y_nod, 'o' );
title('Linear Interpolation');
legend('funzione: f(x)', 'interpolazione composita: \Pi_n f(x)', 'nodi');

%% b) errore di interpolazione in norma infinito
err = norm( yvect - p_interp, inf );

fprintf("errore di interpolazione è: %g\n", err);

%% c) implementazione con vettore di n

HH = []; err_max = [];

for n = 2 .^ ( 2: 7 )
    
    H = ( b-a ) / n;
    HH = [ HH H ];
    
    x_nod = linspace( a, b, n+1 );
    y_nod = f( x_nod );
    
    p_interp = interp1( x_nod, y_nod, xvect );
    
    err = norm( yvect - p_interp, inf );
    err_max = [ err_max err ];
    
end

loglog( HH, err_max, 'ro-', HH, HH, 'k--', HH, HH.^2, 'k' );
legend('\epsilon', 'H', 'H^2');
title('Errore in norma infinito \epsilon_H');

% COMMENTO
% Si verifica graficamente che l'errore si abbatte con andamento quadratico
% rispetto ad H, in accordo con la stima teorica.