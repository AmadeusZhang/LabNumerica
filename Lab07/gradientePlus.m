% Implementazione del metodo del gradiente

function [xk, k] = gradientePlus( A, b, P, x0, tol, nmax)

% ========================= PARAMETRI DI INGRESSO =========================
%   A          matrice del sistema lineare
%   b          termine noto
%   P          precondizionatore
%   x0         vettore soluzione iniziale
%   tol        tolleranza sul test d'arresto del residuo normalizzato
%   nmax       numero massimo di iterazioni
%   alpha      parametro di rilassamento (costante se stazionario)
%
% ========================== PARAMETRI DI USCITA ==========================
%   x          vettore soluzione (ultima iterazione)
%   k          numero di iterazioni effettuate
%
% la differenza tra metodo del Richardson e del gradiente sta nel calcolo
% dinamico del parametro ottimale

[n, m] = size(A);

if n ~= m
    error('A non è quadrata');
end

x = x0; k = 0;
r = b - A * x;
b_norm = norm(b);
res_norm = norm(r) / b_norm;

% PLUS
xk = x0;

while ( res_norm > tol && k < nmax )
    z = P \ r;
    % nel caso di metodi non precondizionati (P=I), si ha z = r
    alpha_dyn = ( z' * r ) / ( z' * A * z );        % alpha dinamico
    x = x + alpha_dyn * z;
    r = b - A * x;
    res_norm = norm(r) / b_norm;
    k = k + 1;
    
    % PLUS
    xk = [ xk, x ];
end

if ( res_norm < tol )
    fprintf('il metodo di gradiente converge in %d iterazioni\n', k);
else
    fprintf('il metodo di gradiente non converge dopo %d iterazioni\n', k);
end