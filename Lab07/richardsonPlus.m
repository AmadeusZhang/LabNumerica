function [xk, k] = richardsonPlus(A, b, P, x0, tol, nmax, alpha)

% Implementazione del metodo di Richardson

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

[n,m] = size(A);
if n ~= m
    error('A non è quadrata');
end

x = x0;
k = 0;
r = b - A * x;
b_norm = norm(b);       % poiché viene ripetutamente richiamato
res_norm = norm(r) / b_norm;

% PLUS:
xk = [ x0 ];

% x^(k+1) = x^(k) + \alpha * P^(-1) * r^(k)

while ( res_norm > tol && k < nmax )
    z = P \ r;                          % z := P^(-1) * r^(k)
    x = x + alpha * z;
    r = b - A * x;
    res_norm = norm(r) / b_norm;
    k = k + 1;
    
    % PLUS:
    xk = [ xk x ];
end

% notiamo che in questo caso non abbiam più bisogno di due variabili per 
% tenere distinti tra x_old e x_new, come negli es. precedenti;

if ( res_norm < tol )
    fprintf('Richardson converge in %d iterazioni \n', k);
else
    fprintf('Richardson non converge dopo aver raggiunto %d iterazioni prestabilito \n', nmax);
end