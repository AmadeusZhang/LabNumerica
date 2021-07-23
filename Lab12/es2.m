% Esercizio 2 Laboratorio 12

clear; clc

%% a) implementazione funzione Heun

f = @(t, y) y ./ (3*t) + ( log(t) + 1 ) ./ (3*t);

y0 = -2;

t_0 = 1; t_max = 10;

%% b) risoluzione problema di Cauchy

% approssimazione col metodo di Heun
h = 1/5;
[ th_heun, uh_heun ] = heun( f, t_0, t_max, y0, h );

% soluzione esatta
xvect = linspace( t_0, t_max );

f_ex = @(t) 2 * t.^(1/3) - log(t) - 4;
yvect = f_ex( xvect );

% plot:
plot( xvect, yvect, 'k--', 'LineWidth', 1 );
hold on; grid on;

plot( th_heun, uh_heun );
title('metodo di Heun e CN');

%% c) implementazione il metodo di Crank-Nicolson
% approssimazione col metodo di CN
h = 1/5;
[ th_CN, uh_CN, iter ] = CN( f, t_0, t_max, y0, h );

% plot:
plot( th_CN, uh_CN );

legend('I_{ex}', 'I_{Heun}', 'I_{CN}');

%% andamento degli errori
H = [ 1/5 1/10 1/20 1/40 ];
N = length(H);

% creare il vettore nullo
err_heun = zeros( 1, N );
err_CN = zeros( 1, N );

% ciclo di iterazione:
for ii = 1: N
    % calcolo le approssimazioni
    [ th_CN, uh_CN, iter ] = CN( f, t_0, t_max, y0, H(ii) );
    [ th_heun, uh_heun ] = heun( f, t_0, t_max, y0, H(ii) );
    
    % plot:
    plot( th_heun, uh_heun, 'b', th_heun, f_ex(th_heun), 'r--' );
    pause(1)
    
    
    % calcolo gli errori
    err_heun(ii) = norm( f_ex(th_CN) - uh_CN, inf );
    err_CN(ii) = norm( f_ex(th_heun) - uh_heun, inf );
    
end

% plot
figure();
loglog( H, err_CN, H, err_heun, H, H, '--', H, H.^2, '--' );
grid on;
title('Confronto degli errori');
legend('err_{CN}', 'err_{heun}', 'H', 'H^2');

% commento:
% dal grafico si evince che entambi CN e Heun hanno un andamento parallelo
% ad H^2, pertanto ordine di convergenza 2.