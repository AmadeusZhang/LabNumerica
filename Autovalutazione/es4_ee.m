% Esercizio 4 - Implementazione Eulero Esplicito

function [ th, uh ] = es4_ee( f, t_0, t_max, y0, h )

% creare vettore temporale
th = t_0 : h : t_max;
N = length(th);

% vettore soluzione
uh = zeros( 1, N );
uh(1) = y0;

for ii = 1: N-1
    uh(ii+1) = uh(ii) + h * f( th(ii), uh(ii) );
end

end