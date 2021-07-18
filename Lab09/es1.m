% Esercizio 1 Laboratorio 9

clear
close all
clc

%% a) nuvola di punti

% definire f con una function handle

f = @(x) 2 * x .^ 2 + 1/4 * sin( 20*pi*x );

% generare i nodi con linspace

a = 0; b = 2; m = 31;

xnod = linspace( a, b, m+1 );

% fare plot dei punti

ynod = f ( xnod );

% plot( xnod, ynod, '*' );

%% b) costruzione matrice M

% help Vander

%  vander Vandermonde matrix.
%     A = vander(V), for a vector of length n, returns the n-by-n
%     Vandermonde matrix A. The columns of A are powers of the vector V,
%     such that the j-th column is A(:,j) = V(:).^(n-j)

% costruire la matrice di Vandermonde

V = vander( xnod );

% estrarre M

% n = 3;
n = 10;         % punto d

M = V( :, (end-n): end );         % m, m-1, ..., n, n-1, ..., 1, 0
% M sono le ultime n+1 colonne, pertanto in alternativa posso scrivere
% M = V( :, (m+1-n):(m+1) );

% risolvere le equazioni normali con il \ (backslash)
MM = M' * M;
My = M' * ynod';        % xnod è un vettore riga, pertanto anche ynod
c_eqnorm = MM \ My;

% plot: (non richiesto nell'esercizio)
figure();
xvect = linspace( a, b, 1e3 );
y_eval = polyval( c_eqnorm, xvect );
plot( xvect, f(xvect), 'k', xvect, y_eval, 'r' );
hold on
plot( xnod, ynod, 'o' );
grid on
legend( 'f(x)', '\Pi_n f(x)' );
title('Risoluzione delle equazioni normali');
hold off;

% commento:
% in questo caso abbiamo usato un polinomio di grado minore per tanto il
% grafico della funzione interpolante non fa \Pi(xi)=yi come nel caso
% precedenti, però fornisce col minor costo l'andamento della f(x).

% Sappiamo, inoltre, dalla teoria che il metodo delle equazioni normali è 
% poco stabile in quanto la matrice M^T*M può avere un condizionamento alto,
% in questo caso ha condizionamento dell’ordine di 1e4


%% c) fattorizzazione QR

% qr economy-size version
[Q_tilde, R_tilde] = qr(M, 0);

% Mc = y ---> R_tilde * c = Q_tilde' * y

Qy = Q_tilde' * ynod';

c_qrdecomp = R_tilde \ Qy;

% Plot:
figure();
y_qreval = polyval( c_qrdecomp, xvect );
plot( xvect, f(xvect), 'k', xvect, y_qreval, 'r' );
hold on; grid on;
plot( xnod, ynod, '*' );
legend( 'f(x)', '\Pi_n f(x)' );
title('Decomposizione QR');
hold off;

%% d) confronto tra due metodi 
% ( attenzione, ad occhio nudo non si vedono questa differenza )

diff = norm( c_qrdecomp - c_eqnorm );       % 2.6871e-13

figure();
plot( xvect, y_eval, 'k', xvect, y_qreval, 'r' );
hold on; grid on;
plot( xnod, ynod, '*' );
legend( 'eq. norm', 'qr ridotta' );
hold off

% COMMENTO:
%   diff di ordine 1e-13, se i due sistemi fossero stati con una
%   accuratezza ragionevole, la diff è circa 1e-16 (errore della macchina),
%   pertanto come afferma dalla teoria, una diff. c'è tra i due sistemi.
%   aspetto inoltre aumentare l'errore all'aumento del n

%% e) osservazione per n = 10

fprintf("Per n = 10, la differenza è %g, decisamente più grande rispetto ad n = 3\n", diff);

% infatti si può osservare direttamente dai vettori c

% dal grafico sembra che QR si stacchi dalla eq. normale, il problema è
% però nell'eq. normale in quanto non sono consapevole sui coefficienti,
% (si pensi al confronto tra il numero di condizionamento dei due metodi);
% inoltre il "distacco" è dovuto dal numero di nodi.