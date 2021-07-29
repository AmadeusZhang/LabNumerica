% Esercizio 1 Laboratorio 16

clear; close all; clc

%% a) disegnare le coniche --> plotzeros.m

% definizione funzioni coniche --> function handle di una variabile VETTORIALE
F = @(X) [                      % X contiene 2 componenti: (x1, x2)
    X(1).^2 - 4*X(2).^2 + 3;
    X(1) - X(2).^2
];

% plotzeros.m per rappresentazione grafica di F
plotzeros( F, [ 0 5 ], [ -3 3 ] );

% osservazione:
% 4 p.ti di intersecazione tra le due coniche

%% b) implementazione del metodo di Newton per sistema non lineare
% parametri d'ingresso
x0 = [ 0; -0.5 ];
nmax = 1e3;
tol = 1e-15;

% matrice jacobiana
J = @(X) [ 
    2*X(1)  (-8*X(2));
      1     (-2*X(2))
];

% recall newtonSys
[ xvect, it] = newtonSys( x0, nmax, tol, F, J );