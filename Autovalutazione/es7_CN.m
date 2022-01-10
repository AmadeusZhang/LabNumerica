% Esercizio 7 - Algoritmo per metodo di Crank-Nicolson
%
% Descrizione degli input:
% — f : funzione di due variabili (t, y) definita come anonymous function
% — T : estremo dell'intervallo di integrazione
% — y_0 : dato iniziale
% — h : passo di discretizzazione temporale
%
% Descrizione degli output:
% — t_h : vettore degli istanti temporali discreti
% — u_h : soluzione approssimata

function [ th, uh ] = es7_CN( f, t0, T, y_0, h )
% vettore temporale
th = t0: h: t0+T;
N = length( th );

% vettore soluzione
uh = zeros( 1, N );
uh(1) = y_0;

% parametri per le iterazioni di punto fisso
nmax = 1e3;
toll = 1e-9;

% ciclo:
for it = 2:N
    phi = @(u) uh(it-1) + (h/2)*( f( th(it-1), uh(it-1) ) + f( th(it), u ) );
    j = 0; err = toll+1;
    w0 = uh(it-1);
    
    % punto fisso:
    while err > toll && j < nmax
        w1 = phi( w0 );
        err = abs( w1-w0 );
        j = j+1;
        w0 = w1;
    end
    
    uh(it) = w1;
end