% Esercizio 4 Laboratorio 13

clear; close all; clc

% impostazione problema di Cauchy
f = @(t, y) y;

% al variare di T 
T = 3;

% valori iniziali
t_0 = 0;    t_max = T;
y0 = 1;

% perturbazione iniziale
delta0 = 1e-1;
z0 = y0+delta0;

% soluzione esatta
f_ex = @(t) exp(t);

% vettore temporale
tvect = linspace( t_0, t_max, 1e3 );
yvect = f_ex( tvect );

% plot
figure();
plot( tvect, yvect, 'k--', 'LineWidth', 1 );
hold on; grid on;

% passo temporale
h = 0.1;

% implementazione Heun
[ th, uh ] = heun( f, t_0, t_max, y0, h );
[ th, zh ] = heun( f, t_0, t_max, z0, h );   % perturbato

% plot
plot( th, uh, '*:', th, zh, 'o:' );
title('metodo di Heun');
legend('Sol_{esatta}', 'Heun', 'Heun_{pert.}');

% errore
figure();
plot( th, abs(uh-zh)/delta0, 'o' );
title('zero stabilità di Heun');