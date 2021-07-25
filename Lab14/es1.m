% Esercizio 1 Laboratorio 14

clear; close all; clc

%% a) soluzione esatta
% valori iniziali
t_0 = 0;    t_max = 15;
lambda = 1;
y0 = 1;

% soluzione esatta
f_ex = @(t) exp( -lambda * t );

% vettori temporali
tvect = linspace( t_0, t_max );
yvect = f_ex( tvect );

% plot:
plot( tvect, yvect, 'k--', 'LineWidth', 1 );

hold on; grid on;

%% b-c) implementazione metodo del Runge-Kutta a 2 stadi
h = 0.5;

% problema di Cauchy
f = @(t, y) - lambda * y;

% soluzione approssimata
[ th, uh ] = RK2( f, t_0, t_max, y0, h );

% rappresentazione della soluzione
plot( th, uh, '-o' );
title('Metodo di Runge-Kutta a 2 stadi');
legend('Sol. esatta', 'Runge-Kutta_2');

%% d) metodo di Eulero Esplicito
H = [ 0.5   1.5    2.1 ];

% ciclo for:
for ii = 1: length(H)
    % plot sol. esatta:
    figure();
    plot( tvect, yvect, 'k--', 'LineWidth', 1 );
    hold on; grid on;
    
    % sol. approssimata
    [ th, uh_RK ] = RK2( f, t_0, t_max, y0, H(ii) );    % RK2 == Heun
    [ th, uh_EE ] = eulero_avanti( f, t_0, t_max, y0, H(ii) );
    
    % plot delle approssimazioni:
    plot( th, uh_RK, '-*', th, uh_EE, '-o' );
    
    % legenda e titolo
    legend( 'sol. esatta', 'Runge-Kutta_2', 'Eulero Avanti' );
    title(['h = ', num2str(H(ii))]);
    
end

%==========================================================================
% COMMENTO
%==========================================================================
% Runge-Kutta a 2 stadi === metodo di Heun
%==========================================================================
% Si osserva la convergenza per h1 e h2, e divergenza per h3.
% in quanto h3=2.1 supera la regione di assoluta stabilità:
% per RK2: |(1-z+z.^2/2)| < 1 --> 0 < z_hat < 2
% z = h*lambda == h --> h1 h2 sono minori di 2, quindi ok.
%==========================================================================