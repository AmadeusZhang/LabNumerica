% Esercizio 3 Laboratorio 15

clear; close all; clc

% intervallo
a = 0.5;
b = 2;

% funzioni
f = @(x) log(x);
df = @(x) 1./x;

g = @(x) 1 - x + log(x);
dg = @(x) -1 + 1./x;
d2g = @(x) - 1 ./ x.^2;

%% a) convergenza del metodo di Newton
xvect = linspace( a, b );

% plot:
figure();
hold on; grid on;
plot( xvect, f(xvect), xvect, df(xvect) );
plot( xvect, 0.*xvect, 'k--', 'LineWidth', 1 );
legend('f', 'df');

figure();
hold on; grid on;
plot( xvect, g(xvect), xvect, dg(xvect), xvect, d2g(xvect) );
plot( xvect, 0.*xvect, 'k--', 'LineWidth', 1 );
legend('g', 'dg', 'd^2g');

% radici
% f ammette una radice in x=1 con m.a. 1 ==> conv. ord. 2 (newton)
% g ammette una radice in x=1 con m.a. 2 ==> conv. ord. 1 (newton mod.)

%% b-c) implementare metodo di Newton
% test d'arresto
tol = 1e-6;
nmax = 1e2;

% scelta di x0 iniziale
x0 = a;

% metodo di Newton
[ xvect_f, it_f ] = newton( x0, nmax, tol, f, df, 1 );
[ xvect_g, it_g ] = newton( x0, nmax, tol, g, dg, 1 );      % voglio vedere differenza con f

% metodo di Newton Modificato
[ xvect_gm, it_gm ] = newton( x0, nmax, tol, g, dg, 2 );

% calcolo errore
err_f = abs( xvect_f - 1 );
err_g = abs( xvect_g - 1 );
err_gm = abs( xvect_gm - 1 );

% plot:
semilogy( 0: it_f, err_f, 0: it_g, err_g, 0: it_gm, err_gm );
grid on;
legend( 'f', 'g', 'gm' );

% osservazione:
% f converge con ordine 2, g invece è lineare;
% però aggiustando con Newton Modificato, gm si presenta quadratica.

% ATTENZIONE: nel grafico generato, sembra che f ha una iterata in meno,
% però il fatto è perché il suo 5a valore è 0 esatto, pertanto in una scala
% logaritmica non viene visualizzata, possiamo considerare infinitamente
% piccolo.