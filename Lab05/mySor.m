function [xn, iter] = mySor(A, b, x0, nmax, toll, omega)

    % Parametri di ingresso:
    %   A       matrice del sistema
    %   b       termine noto        (vettore colonna)
    %   x0      vettore iniziale    (vettore colonna)
    %   nmax    numero massimo di iterazioni
    %   toll    tolleranza sul test d'arresto (residuo normalizzato)
    %   omega   parametro di rilassamento (volendo studiare col metodo di
    %   Gauss-Sidel si assume che omega=1
    %
    % Parametri di uscita:
    %   xn      vettore soluzione
    %   iter    #iterazioni effettuate
   
% Verifica matrice
[n,m] = size(A);
if n ~= m
    error('Matrice non quadrata');
end

% Definizione dei variabili    
xn = x0;
xv = x0;
iter = 0;
err = toll+1;
normb = norm(b);    % poiché viene ripetutamente utilizzato, è un calcolo sprecato se dover ricalcolarlo ogni interazione
while ( iter < nmax && err > toll )
    for ii = 1: n
        xn(ii) = (1-omega)*xv(ii) + omega * ( b(ii) - A(ii,1:ii-1)*xn(1:ii-1) - A(ii,ii+1:n)*xv(ii+1:n) ) / A(ii,ii);
    end
    iter = iter+1;
    err = norm(b-A*xn)/normb;
    xv = xn;
end

if iter == nmax
    disp(" >>   Il metodo di SOR non converge nei termini sufficienti");
end

end