function [ xvect, it] = newtonSys( x0, nmax, tol, f, J )

%   MODIFIED from newton.m!
%
% [ xvect, it] = newtonSys( x0, nmax, tol, f, J )
%
% Metodo di Newton per la ricerca degli zeri di una funzione vettoriale.
% Test d'arresto basato sull'incremento tra due iterazioni successive.
%
% Parametri di ingresso:
%
% x0            Punto di partenza ( vettore colonna: x0 = [ x1; x2 ] )
% nmax          Numero massimo di iterazioni
% toll          Tolleranza sul test d'arresto
% f             Anonymous function della funzione
% J             Matrice Jacobiano della variabile vettoriale
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
    Jk = J( xk );   % Jk è una matrice, pertanto seguono le seguenti modifiche:
    
    % controllo che det(Jk) sia non nullo
    if ~det(Jk)     % non ha senso verificare se è una matrice è nulla, 
                    % bensì se la sua determinante fosse nulla o meno;
        error("Arresto per Jacobiano singolare");
    end
    
    % calcolo x al passo k+1
    xn = xk - ( Jk\f(xk) );     % f(xk)/Jk --> Jk^(-1)*f(xk) --> risoluzione di un sistema!
                                %       ==> Jk\f(xk)
    
    % concatenamento xvect
    xvect = [ xvect, xn ];      % xvect, xn sono vettori colonna, pertanto 
                                % faccio concatenazione orizzontale
    
    % criterio d'arresto ( diff. tra due iterate ):
    err = norm( xk-xn, inf );   % abs( xk-xn ) restituisce ancora un vettore,
                                % ma a noi interessa soltanto uno scalare,
                                % pertanto calcoliamo la norma all'infinito
    
    % aggiorno xk
    xk = xn;
    
end

end