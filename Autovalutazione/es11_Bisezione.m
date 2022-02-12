% Esercizio 11 - Implementazione del metodo di bisezione
%
% function [ xvect, iter ] = es11_Bisezione( a, b, toll, fun )
%
% Descrizione degli input :
% — a, b : estremi dell’intervallo di ricerca
% — toll : tolleranza
% — fun : funzione
% Descrizione degli output :
% — xvect : vettore delle iterate
% — iter : numero di iterazioni effettuate

function [ xvect, iter ] = es11_Bisezione( a, b, toll, f )

nmax = 1e3;

xvect = [];
iter = 0;

% Si utilizzi un criterio d'arresto basato sul residuo, accoppiato ad un 
% controllo sull ampiezza dell’intervallo corrente, assumendo entrambe le 
% tolleranze pari a toll.

err = toll+1;   % sufficiente per entrare in ciclo

while ( iter < nmax && err > toll )
    c = (a+b)/2;
    xvect = [ xvect c ];
    iter = iter + 1;

    if f(c) == 0         % arresto per obiettivo compiuto
        err = 0;
    else
        if f(a)*f(c) < 0
        b = c;
        elseif f(b)*f(c) < 0
        a = c;
        end
        err = abs(b-a)/2;
    end
end

end