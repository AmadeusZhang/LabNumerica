% Esercizio 8 - Quadratura

close all; clear all; clc

%% Rappresentazione grafica della funzione
f = @(x) exp(-x.^2);
a = 0; b = 1;
xvect = linspace( a, b, 1e3 );
plot( xvect, f(xvect), 'k--' );

%% Interpolazione col punto medio composita

% i) Formula:   I_{pm, c} = H * sum( 1, M )( f( x_hat(k) ) );

% ii) Interpretazione geometrica:   suddivisione in M sottointervalli su
% cui applicare la formula del quadratura di punto medio (semplice)

% iii) formula dell'errore:     E(f) = (b-a)/24 * H^2 * f''(z), se f è C^2

% iv) grado di esatezza e ordine di accuratezza:    gde = 1, oda = 2

%% Soluzione approssimato ed errore

% al discrezione di N
N = 5 * 2.^(0:4);

% vettore soluzione e errore
sol = [];
err = [];

% soluzione esatta
I_ex = 0.746824180726425;       % given data

for nn = N
    I_N = es8_pmedcomp( a, b, nn, f );
    sol = [ sol I_N ];
    err = [ err norm( I_ex - I_N, inf ) ];
end

% format short e;
% sol

% Rappresentazione grafica in scala logaritmica
H = (b-a)./N;
figure();
% loglog( H, H, '--', H, H.^2, '--', H, err, 'ro-' );
loglog( N, err, N, N.^(-2), '-o' );
legend( 'Errore_{f}', 'N^{-2}' );
% legend( 'H^1', 'H^2', 'Errore' );

% COMMENTO:
% L'andamento dell'errore è in ordine di H^2, come stima teorica oda = 2;