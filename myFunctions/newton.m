function [ xvect, it] = newton( x0, nmax, tol, f, df, mol )

% [ xvect, it] = newton( x0, nmax, tol, f, df, mol )
%
% Metodo di Newton per la ricerca degli zeri della funzione fun.
% Test d'arresto basato sull'incremento tra due iterazioni successive.
%
% Parametri di ingresso:
%
% x0            Punto di partenza
% nmax          Numero massimo di iterazioni
% toll          Tolleranza sul test d'arresto
% fun dfun      Anonymous function contenenti la funzione e la sua derivata
% mol           Molteplicita' dello zero che si vuole trovare
%
% Parametri di uscita:
%
% x_vect        Vett. contenente tutte le iterate calcolate
%               (l'ultima componente e' la soluzione)
% it            Iterazioni effettuate

% inizializzare variabili d'uscita:
xvect = x0;
it = 0;

% variabili ausiliari
xk = x0;        % valore di x al passo k, per calcolo del rapp. incr.
err = tol+1;    % err. residuo, suff. grande per entrare in ciclo

% ciclo:
while it < nmax && err > tol
    % aggiorno numero iterazioni
    it = it + 1;
    
    % aggiorno rapporto incrementale
    qk = df( xk );
    
    % controllo che qk sia non nullo
    if ~qk
        break;
    end
    
    % calcolo x al passo k+1
    xn = xk - mol * f(xk)/qk;
    
    % concatenamento xvect
    xvect = [ xvect xn ];    
    
    % criterio d'arresto ( diff. tra due iterate ):
    err = abs( xk - xn );
    
    % aggiorno xk
    xk = xn;
end