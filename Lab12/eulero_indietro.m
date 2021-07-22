% Implementazione del metodo di Eulero Indietro( implicito )

function [ th, uh ] = eulero_indietro( a, b, t_0, t_max, y0, h )
%==========================================================================
% step 1: esplicitare f
% f(t, y) = @(y) a(t)*y + b(t); lineare rispetto ad y
% uh(n) = uh(n-1) + h * ( a( th(n) )*uh(n) + b*( th(n) ) );
%   
% step 2: ricavare uh(n)
% uh(n) - [h*a(th(n))*uh(n)] = uh(n-1) + h*b*th(n);
% uh(n)[1-h*a(th(n))] = ...
% ...
% ==> uh(n) = [uh(n-1) + h*b(th(n))]/[1-h*a(th(n))];
%==========================================================================

% creazione vettori temporali di istante h --> :
th = t_0: h: t_max;

% lunghezza vettore temporale
N = length( th );

% inizializzazione vettore soluzione uh
uh = zeros( 1, N );                 % vettore riga
uh(1) = y0;

% ciclo for:
for n = 1: N-1
    % eq. ricavata in precedenza
    uh(n+1) = ( uh(n) + h * b( th(n+1) ) ) / ( 1 - h * a( th(n+1) ) );
end

end