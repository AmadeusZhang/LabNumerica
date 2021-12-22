% risoluzione di un sistema lineare mediante fattorizzazione LU

function [x] = solve( L, U, b )

% Descrizione degli input:
% - L: matrice triangolare inferiore
% - U: matrice triangolare superiore
% - b: termine noto
%
% Descrizione degli output:
% - x: soluzione approssimata

y = fwsub( L, b );
x = bksub( U, y );

end