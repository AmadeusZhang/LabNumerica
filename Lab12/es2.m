% Esercizio 2 Laboratorio 12

clear; close all; clc

%% a) implementazione funzione Heun

f = @(t, y) y ./ (3*t) + ( log(t) + 1 ) ./ 3*t;

y0 = -2;

t_0 = 1; t_max = 10;

%% b) risoluzione problema di Cauchy

% approssimazione col metodo di Heun
h = 1/5;
[ th, uh ] = heun( f, t_0, t_max, y0, h );

% soluzione esatta
xvect = linspace( t_0, t_max );

f_ex = @(t) 2 * t.^(1/3) - log(t) - 4;
yvect = f_ex( xvect );

% plot:
plot( xvect, yvect, 'k--', 'LineWidth', 1 );
hold on; grid on;

% plot( th, uh );
% title('metodo di Heun');
% legend('I_{ex}', 'I_{Heun}');