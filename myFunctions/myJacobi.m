% funzione myJacobi

function [xn, iter] = myJacobi(A,b,x0,nmax,toll)

    % Parametri di ingresso:
    %   A       matrice del sistema
    %   b       termine noto        (vettore colonna)
    %   x0      vettore iniziale    (vettore colonna)
    %   nmax    numero massimo di iterazioni
    %   toll    tolleranza sul test d'arresto (residuo normalizzato)
    %
    % Parametri di uscita:
    %   xn      vettore soluzione
    %   iter    #iterazioni effettuate
    
[n,m]=size(A);
if n ~= m
    error(' >>  La matrice non è quadrata.');
end

% definizione variabili
xn = x0;            % x^(k+1)
xv = x0;            % x^k
iter = 0;           % contatore iterazioni
res = toll+1;       % residuo iniziale deve soddisfare il ciclo, pertanto +1

while ( iter < nmax && res > toll )
    for ii = 1:n
        xn(ii) = ( b(ii)-( A(ii,[1:ii-1,ii+1:n])*xv([1:ii-1,ii+1:n]) ) )/A(ii,ii);
    end
    iter = iter+1;
    res = norm(b-A*xn)/norm(b);
    xv = xn;
end

end