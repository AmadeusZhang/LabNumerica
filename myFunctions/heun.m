% Implementazione del metodo di Heun per risoluzione del problema di Cauchy metodo che sfrutta l'approssimazione degli integrali

function [ th, uh ] = heun( f, t_0, t_max, y0, h )
% creare il vettore degli instanti temporali --> :
th = t_0: h: t_max;

% calcolare lunghezza del vettore temporale
N = length( th );

% inizializzare vettore soluzione
uh = zeros( 1, N );
uh(1) = y0;
    
% ciclo for:
for n = 1: N-1
    uh(n+1) = uh(n) + (h/2) * ( f(th(n), uh(n)) + f( th(n+1), uh(n)+h*f(th(n), uh(n)) ) );
end

end