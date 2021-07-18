% Esercizio 3 Laboratorio 9

f = @(t) sin(2*pi*t);

a = -1; b = 1; n = 20;

%% a) polinomio interpolante su n+1 nodi equispaziati

% genero vettore con n+1 nodi equispaziati
xnod = linspace( a, b, n+1 );
ynod = f( xnod );

% polinomio interpolante => polyfit
p_fit = polyfit( xnod, ynod, n );

% valutazione di p su vettore dei punti equispaziati fitti
xvect = linspace( a, b, 1e3 );
yvect = f( xvect );
y_val = polyval( p_fit, xvect );

%% b) confronto tra f(x) e interpolante

% plot:
figure();
plot( xvect, yvect, 'k', xvect, y_val, 'r' );
hold on; grid on;
plot( xnod, ynod, '*' );
title('Interpolazione polinomiale');
legend('f(x)', '\Pi_n f(x)');
hold off;

% calcolo errore
ydiff = norm( yvect-y_val, inf );
fprintf("La norma all'infinito della differenza è: %g\n", ydiff);

% approssima abbastanza bene la funzione f(x), con un errore 1e-7

%% c) perturbazione della funzione nei nodi

% modifico parzialmente la parte a

delta_ = 1e-2 * rand( n+1, 1 );    % perturbazione casuale di ampiezza 1e-2

% genero vettore con n+1 nodi equispaziati
xnod = linspace( a, b, n+1 );
ynod_tilde = f( xnod ) + delta_';

% polinomio interpolante => polyfit
p_fit = polyfit( xnod, ynod_tilde, n );

% valutazione di p su vettore dei punti equispaziati fitti
xvect = linspace( a, b, 1e3 );
yvect = f( xvect );
y_val_tilde = polyval( p_fit, xvect );

% plot:
figure();
plot( xvect, yvect, 'k', xvect, y_val_tilde, 'r' );
hold on; grid on;
plot( xnod, ynod_tilde, '*' );
title('Polinomio interpolante perturbato');
legend( {'$\hat{f}(x)$', '$\Pi_n f(x)$'}, 'FontSize', 14, 'Interpreter', 'latex' );
hold off;

%% d) calcolo errore
ydiff = norm( yvect-y_val_tilde, inf );
fprintf("La norma all'infinito della differenza è: %g\n", ydiff);

%==========================================================================
% COMMENTO
%==========================================================================
% Perturbazione del 1% (norm della differenza è sui 0.01) sui dati provoca 
% un ampliata di circa 1e7 rispetto a quello precedente.
% Questo comportamento è in linea con le stime teoriche di
% stabilità.
%==========================================================================

%% e) costante di Lebesgue
% polinomio phi_i vale 0 in tutti i nodi x_j t.c. j~=i, vale 1 in x_i
somma_phi = 0;

xnod = linspace( a, b, n+1 );
xx = linspace( a, b, 1e3 );

figure();
for ii = 1: n+1
    znod = zeros( n+1, 1 );                 % vale 0 su tutti i nodi
    znod(ii) = 1;                           % vale 1 nel nodo ii-esimo
    phi_ii = polyfit( xnod, znod, n );      % calcolo coeff. polinomio
    phi_x = polyval( phi_ii, xx );          % valutazione in xx
    
    somma_phi = somma_phi + abs(phi_x);     % somme parziali
    
    % rappresentazione grafica
    plot( xnod, znod, '*r', xx, phi_x, 'LineWidth', 2 )
    axis([ -1 1 -5 5 ])
    pause(0.1)
end

% calcolo lambda come il max
lamba_n = max( somma_phi );

% stima teorica
err_p = norm( y_val - y_val_tilde, inf );
err_f = norm( ynod - ynod_tilde, inf );

if err_p <= lamba_n * err_f
    disp('è verificata la stima teorica');
else
    disp('non è verificata la stima');
end