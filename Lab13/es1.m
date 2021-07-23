% Esercizio 1 Laboratorio 13

clear; close all; clc

%==========================================================================
% RIPASSO
%==========================================================================
% Un metodo numerico per l'approssimazione di un problema di Cauchy si dice
% assolutamente stabile se esiste h0>0 tale che per ogni h<=h0 si abbia
%                         lim_{n->inf} norm(un) = 0
%==========================================================================

%% a) Assoluta Stabilità
% creare i vettori
ReZ = linspace( -3, 3, 101 );  % metto un n. dispari per centrare l'origine
ImZ = linspace( -3, 3, 101 );

% costruzione reticolo piano complesso
[ a, b ] = meshgrid( ReZ, ImZ );        
Z = a + 1i*b;                        % Z è una matrice

% definizione funzione
g = @(z) 1+z;                        % Eulero Avanti
g_abs = abs( g(Z) );                 % |g(Z)|

%% b) rappresentazione grafica
mesh( a, b, g_abs );                 % 3D-plot
% contour( a, b, g_abs );            % curve di livello
% colorbar

% interesse particolare per curve di livello tra 0 e 1
figure();
contourf( a, b, g_abs, [0 1] );      % curve di livello riempito
axis equal;
grid on;

%% altri metodi:
% Eulero Implicito
% g = @(z) 1 ./ (1-z);
%
% Crank-Nicolson
% g = @(z) ( 1 + 1/2*z ) ./ ( 1 - 1/2*z );
%
% Heun
% g = @(z) ( 1 + z + 1/2 * z.^2 );