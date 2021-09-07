% Esercizio 2 Laboratorio 16

clear; close all; clc

%% a) Definire funzione handle per descrivere il modello SIR
% parametri
alpha = 4;
beta = 1;
zeta = 0.2;

% function handle
f = @(t,y) [
    -beta*y(1)*y(2)
    (beta-alpha)*y(1)*y(2) + zeta*y(3)
    alpha*y(1)*y(2) - zeta*y(3)
];

%% b-c) Implementazione del eulero_indietro col metodo del punto fisso
% intervallo di tempo t = 96
t_0 = 0;
t_max = 96;

% y0 iniziale (typo sul pdf perché somma di y0 dev'essere 1)
y0 = [ 0.99; 0.01; 0 ];

% passo di discretizzazione 
h = 0.1;

% risoluzione
[th, uh] = eulero_indietroSys( f, t_0, t_max, y0, h );

% tracciare il grafico
plot( th, uh(1,:), th, uh(2,:), th, uh(3,:) );
grid on;
legend('S','Z','R');