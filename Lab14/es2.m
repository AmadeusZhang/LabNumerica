% Esercizio 2 Laboratorio 14

clear; close all; clc

% impostazione problema di Cauchy
t_0 = 0;    t_max = 20;
y0 = 1;

% esplicitare funzione f(t, y) = @(y) a(t)*y + b(t)
a = @(t) 1 ./ ( 1+t.^2 );
b = @(t) 0*t;

%% a) approssimazione col metodo di Eulero Implicito
Nh = [ 10 50 100 500 ];
N = length(Nh);

% rappresentazione grafica
figure();
hold on; grid on;
title('metodo di Eulero Implicito');

% ciclo for:
for ii = 1: N
    % calcolo passo temporale
    h = (t_max-t_0)/Nh(ii);
    
    % calcolo soluzione approssimata
    [ th, uh ] = eulero_indietro( a, b, t_0, t_max, y0, h );
    
    % plot:
    plot( th, uh );
    
end

% leggenda
legend('N_h=10', 'N_h=50', 'N_h=100', 'N_h=500');

%% b) errore
% soluzione esatta
f_ex = @(t) exp(atan(t));

% vettore temporale
tvect = linspace( t_0, t_max, 1e3 );
yvect = f_ex( tvect );

% vettore errore
err = zeros( 1, N );
h = zeros( 1, N );

% ciclo for:
for ii = 1: N
    % calcolo passo temporale
    h(ii) = (t_max-t_0)/Nh(ii);
    
    % calcolo soluzione approssimata
    [ th, uh ] = eulero_indietro( a, b, t_0, t_max, y0, h(ii) );
    
    % plot:
    figure();
    plot( tvect, yvect, 'k--', th, uh );
    grid on;
    title(['Nh = ', num2str(Nh(ii))]);
    legend('sol. esatta', 'appros. numerica');
    
    % errore:
    err(ii) = norm( f_ex(th)-uh, inf );
    fprintf("errore per Nh = %d è: %g\n", Nh(ii), err(ii));
    
end

% plot errore
figure();
loglog( h, err, h, h, 'k--' );
legend('err', 'H');
title('convergenza di errore');

% commento:
% metodo di ordine 1;

%% c) implementazione di funzione built-in ode23
% impostare ODE function
f = @(t,y) a(t)*y + b(t);

% approssimazione numerica
[ th, uh ] = ode23( f, [t_0, t_max], y0 );

% rappresentazione grafica
figure()
plot( th, uh, tvect, yvect, 'k--' );
grid on;
title('metodo di Runge-Kutta');
legend('Runge-Kutta', 'sol. esatta');

% errore
err = norm( f_ex(th)-uh, inf );
fprintf("Il metodo di ODE23 genera un errore di: %g\n", err );

% verifica passo temporale sia non uniforme
h_dist = th(2 :end) - th(1: end-1);
max(h_dist)
min(h_dist)