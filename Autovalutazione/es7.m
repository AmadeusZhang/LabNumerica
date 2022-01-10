% Esercizio 7 - problema di Cauchy (col metodo di CN)

clear all; close all; clc

% Dato iniziale
f = @(t,y) sinh(t).*exp(-t./3) - y./3;
y_0 = 2;
t0 = 0;
T = 10;

% vettore soluzione approssimata
sol = [];

% soluzione esatta
yex = @(t) ( cosh(t)+1 ).*exp(-t./3);

% vettore errori
err = [];

% discrezione degli h
H = 2 .^ -(1:5);
for hh = H
    [ th, uh ] = es7_CN( f, t0, T, y_0, hh );
    
    sol = [ sol uh(end) ];
    
    err = [ err max(abs(uh-yex(th))) ];
end

% rappresentazione grafica
figure();
loglog( H, H.^2, 'k:', H, err, 'ro-' );
legend( 'H^2', 'E_{h}' );