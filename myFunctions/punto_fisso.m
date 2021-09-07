function [xvect, niter] = punto_fisso( phi, x0, tol, kmax )

% [ xvect, iter ] = punto_fisso( phi, x0, tol, kmax )
% trova un punto fisso della funzione phi
% usando il metodo delle iterazioni di punto fisso
% e restituisce un vettore xvect contenente le iterate del metodo.
%
% Parametri di INPUT:
% phi   funzione scalare che accetta una variabile scalare in input
% x0    approssimazione iniziale
% tol   tolleranza per il criterio d'arresto (basato sull'incremento)
% kmax  numero massimo di iterazioni concesso
%
% [xvect] = punto_fisso(phi, x0, tol, kmax)
% restituisce anche il numero niter di iterazioni compiute
% (siccome xvect(1)=x0, si ha length(xvect) = niter + 1).

% inizializzo variabili d'uscita
niter = 0;
xvect(niter+1) = x0;
err_estim = tol + 1;

% ciclo:
while ( err_estim >= tol && niter < kmax )
    xvect(niter+2) = phi( xvect(niter+1) );
    err_estim = abs( xvect(niter+2) - xvect(niter+1) );
    niter = niter + 1;
end

if ( niter >= kmax )
    warning('Il numero massimo di iterazioni è stato raggiunto.');
end

return