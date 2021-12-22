% Esercizio 2 Laboratorio 15

clear; close all; clc;

% dichiarare funzioni 

f = @(x) x.^2 - 5*x + 6;
df = @(x) 2*x - 5;

%% radici e molteplicità
% plot:
xvect = linspace( 1, 4, 1e3 );
plot( xvect, f(xvect), xvect, df(xvect) );
legend( 'f', 'df' );
grid on;

% radici:
% x1 = 2; x2 = 3; con ambedue molteplicità 1;

%% a) metodo di punto fisso per determinare gli zeri