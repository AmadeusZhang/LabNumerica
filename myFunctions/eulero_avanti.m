% [ th, uh ] = eulero_avanti( f, t_0, t_max, y0, h )
% metodo ad un passo, esplicito
% uh(ii+1) = uh(ii) + h * f( th(ii), uh(ii) );

function [ th, uh ] = eulero_avanti( f, t_0, t_max, y0, h )

% creare il vettore degli istanti temporali th --> :
th = t_0 : h: t_max;

% calcolare quanti istanti temporali ha il vellore th
N = length(th);

% inizializzare il vettore uh con y0
uh = zeros(1, N);
uh(1) = y0;

% ciclo for: uh(n+1)= ... uh(n) --> Eulero Avanti
for ii = 1: N-1
    % metodo ad un passo, esplicito
    uh(ii+1) = uh(ii) + h * f( th(ii), uh(ii) );
end

end