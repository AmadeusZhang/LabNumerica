function [xvect, niter] = punto_fissoSys( phi, x0, tol, kmax )

% modified from punto_fiss.m !
% x0            vettore colonna
% xvect         affiancare le colonne x(it)
% err_estim     abs --> norm( .., inf )

% inizializzo variabili d'uscita
niter = 0;
% scalare: xvect(niter+1) = x0;
xvect(:, niter+1) = x0;
err_estim = tol + 1;

% ciclo:
while ( err_estim >= tol && niter < kmax )
    xvect(:, niter+2) = phi( xvect(:, niter+1) );
    err_estim = norm( xvect(:, niter+2) - xvect(:, niter+1), inf );
    niter = niter + 1;
end

if ( niter >= kmax )
    warning('Il numero massimo di iterazioni è stato raggiunto.');
end

return