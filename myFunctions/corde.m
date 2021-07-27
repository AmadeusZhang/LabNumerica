% Implementazione del metodo delle corde
%
%       [ xvect, niter ] = corde( a, b, x0, kmax, tol, f );
%
% Parametri in ingresso:
%
%   a       estremo inferiore dell'intervallo
%   b       estremo superiore dell'intervallo
%   x0      il punto di partenza
%  kmax     il numero massimo di iterazioni
%  tol      la tolleranza per il criterio d'arresto (sul residuo)
%   f       funzione da ricervare
%
% Parametri in uscita:
%
%  xvect    vettore delle iterate ( l'ultima componente è sol. )
%  niter    numero di iterazioni effettuate

function [ xvect, niter ] = corde( a, b, x0, kmax, tol, f )
% inizializzare le variabili di uscita
xvect = x0;         % vettore uscita
xk = x0;
niter = 0;

% inizializzare il residuo
res = tol+1;            % un numero suff. grande per entrare in ciclo
% res = abs( f(x0) );   % ver. residuo

% rapporto incrementale
qk = ( f(b)-f(a) ) / ( b-a );

% ciclo:
while niter < kmax && res > tol
    % aggiorno iter
    niter = niter + 1;
    
    % metodo delle corde
    xn = xk - f( xk )/qk;    
    
    % aggiorno xvect --> concatenazone
    xvect = [ xvect xn ];
    
    % aggiorno err. dovuto alle differenze
    % res = abs( xn - xk );
    
    % aggiorno err. Vers. residuo
     res = abs( f( xn ) );
    
    % aggiorno xk
    xk = xn; 
    
end