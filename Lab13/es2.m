% Esercizio 2 Laboratorio 13

clear; clc

% impostazione problema di Cauchy
lambda = -42;
y0 = 2;

% soluzione esatta
f_ex = @(t) y0 * exp( lambda * t );

% intervallo
t_0 = 0;    t_max = 1;

%% a) grafico della soluzione esatta

figure();

% vettori 
xvect = linspace( t_0, t_max, 1e3 );
yvect = f_ex( xvect );

% plot:
plot( xvect, yvect, 'k--', 'LineWidth', 1 );
hold on; grid on;

%% b) approssimazione col metodo di Eulero Avanti
% vettore H
H = [ 0.05 0.0286 0.0167 ];
N = length(H);

% funzione forzante 
f = @(t, y) lambda * y;       % ricorda sempre di scrivere f(t,y)

% for
for ii = 1: N
    [ th, uh ] = eulero_avanti( f, t_0, t_max, y0, H(ii) );
    plot( th, uh );
    pause();
end

% legenda
legend( 'sol. esatta', 'H=0.05', 'H=0.0286', 'H=0.0167' );

%==========================================================================
% COMMENTO
%==========================================================================
% Diverge per h = 0.05, questo risultato lo aspettiamo, in quanto:
% posto Z = h*lambda, si verifica l'assoluta convergenza se |1+Z|<1;
%
% abs(1+H*lambda) = [ 1.1000    0.2012    0.2986 ];
%
% in effetti la convergenza si verificano per h2, h3 ma non per h1.
%
%==========================================================================
% NOTA BENE
%==========================================================================
% EULERO AVANTI è CONDIZIONATAMENTE A-STABILE
% EULERO INDIETRO è INCONDIZIONATAMENTE IN STABILE