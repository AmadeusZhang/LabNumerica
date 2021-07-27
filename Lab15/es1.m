% Esercizio 1 Laboratorio 15

clear; close all; clc

% definizione f
f = @(x) cos(x-1).^2 - x.^2;

% derivata prima di f
df = @(x) 2*cos(x-1).*(-sin(x-1)) - 2*x;

% dominio
estr_a = 0;
estr_b = 2.7;

%% a) determinare le radici e la loro molteplicità

% plot delle funzioni f, df (metodo grafico)
xvect = linspace( estr_a, estr_b, 1e3 );
plot( xvect, f(xvect), 'k--', xvect, df(xvect), ':', 'LineWidth', 1 );
legend( 'f', 'df' );
grid on;

% commento:
%  f(1)  = 0 --> zero della funzione
% df(1) != 0 --> molteplicità 1

%% b-c) implementazione del metodo delle corde

% definizione tolleranza e max #iterazioni
tol = 1e-10;
kmax = 1e2;     % opportuno ==> che sia non-vincolante per ciclo

% definire diversi valori di x0 iniziale
xx = [ 0.3  0.6  1.2 ];

% ciclo: 
for ii = 1: length(xx)
    x0 = xx(ii);
    % richiamo metood delle corde implementato
    [ xvect, niter ] = corde( estr_a, estr_b, x0, kmax, tol, f );
    
    % plot in scala semilogaritmica degli ERRORI
    err = abs( xvect-1 );   % abbiamo trovato in precedenza x=1 è uno zero
    figure();
    semilogy( 0: niter, err );    % be careful about dimension
    grid on;
    title(['errore del metodo delle corde per x0 = ', num2str(x0)]);
end