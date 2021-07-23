% Esercizio 3 Laboratorio 13

clear; close all; clc

% impostazione problema di Cauchy
T = 3;
t_0 = 0; t_max = T;
y0 = 0; 
f_Cauchy = @(t,y) -y + exp(-t);

% impostazione problema perturbato
epsilon = 1e-2;
f_perturbato = @(t,z) -z + exp(-t) .* ( 1+epsilon );
z0 = epsilon;

% soluzione esatta
f_ex = @(t) t .* exp(-t);
tvect = linspace( t_0, t_max, 1e3 );
yvect = f_ex( tvect );

% vettore temporale
H = [ 0.1, 0.05 ];

for ii = 1: 2
    % risoluzione col metodo di Heun
    [ th, uh ] = heun( f_Cauchy, t_0, t_max, y0, H(ii) );
    [ th, zh ] = heun( f_perturbato, t_0, t_max, z0, H(ii) );

    % plot sol. esatta
    figure();
    subplot(1,2,1);
    plot( tvect, yvect, 'k--', 'LineWidth', 1 );
    hold on; grid on;

    % plot:
    plot( th, uh, ':*', th, zh, ':o' );

    % title:
    title(['h = ', num2str(H(ii))]);
    legend('sol_{ex}', 'Heun', 'Heun_{pert.}');

    % calcolo errore
    err = abs( uh-zh )/epsilon;
    subplot(1,2,2);
    plot( th, err, 'o' );
    title('Zero Stabilità del metodo di Heun');

end

%==========================================================================
% COMMENTO
%==========================================================================
% Si evince che C è indipendente da T dovuto al caso "fortunato":
% un metodo numerico condizionatamente a-stabile è applicato ad un problema
% stabile secondo Liapunov.
% Heun è a-stabile sotto condizione di stabilità di h.
% h < h_tilde;      h_tilde = 2/abs(D(f)/dy) = 2 nel caso.