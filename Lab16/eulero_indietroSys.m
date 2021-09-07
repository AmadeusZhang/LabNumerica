% Implementazione del metodo di Eulero Indietro( implicito )

function [ th, uh ] = eulero_indietroSys( f, t_0, t_max, y0, h )

% modified from eulero_indietro.m
% f     function handle
% y0    vettore colonna in R^d
% uh    matrice d x N

% creazione vettori temporali di istante h --> :
th = t_0: h: t_max;

% lunghezza vettore temporale
N = length( th );

% inizializzazione vettore soluzione uh
d = length( y0 );
uh = zeros( d, N );
uh(:, 1) = y0;

% parametri per le iterazioni di punto fisso
nmax = 1e3;
toll = 1e-5;

% ciclo for:
for n = 2: N
    % scrivere eulero indietro (eq. da risolvere)
    % uh(:, n) = uh(:, n-1) + h * f( th(n), uh(:, n) );       % formula esplicita
    
    % --> identificare la funzione phi di punto fisso
    % uh(:, n) = phi( uh(:,n) )    -->     uh(:,n) = u
    phi = @(u) uh(:, n-1) + h * f( th(n), u );
    
    % --> identificare x0 (un numero abbastanza vicino da convergere)
    x0 = uh(:, n-1);
    
    % chiamare funzione punto fisso
    [ xvect ] = punto_fissoSys( phi, x0, toll, nmax );
    
    uh(:, n) = xvect(:, end);
    
end

end