% Esercizio 2 Laboratorio 5

[errors,solutions,femregion,Dati,A,b]=es2_main1D('Test1',3);

[n,m] = size(A);

if n ~= m
    error('A non è matrice quadrata');
end

%% Verifica che A è tridiagonale
if isbanded(A,1,1)
    disp('A è tridiagonale');
else
    disp('A non è tridiagonale');
end

%% Verifica simmetria
if isequal(A,A')
    disp('A è simmetrica');
else
    disp('A non è simmetrica');
end

%% Definita Positiva
if all(eig(A)>0)
    disp('A è definita positiva');
else
    disp('A non è definita positiva');
end

%% Dominanza diagonale
dom_diag = [ true true ];
for ii = 1: n
    if ( abs(A(ii,ii)) < sum(abs(A(ii,[1:ii-1, ii+1:n]))) )
        dom_diag(1) = false;
    end
    
    if ( abs(A(ii,ii)) < sum(abs(A([1:ii-1,ii+1:n], ii))) )
        dom_diag(2) = false;
    end
end

if all(dom_diag)
    disp("A è dominante per righe e colonne (non stretta)");
elseif dom_diag(1)
    disp("A è dominante per righe");
elseif dom_diag(2)
    disp("A è dominante per colonne");
else
    disp("A non ha dominanza diagonale");
end

%% Convergenza per metodi di risoluzione iterativi
% per dominanza diagonale
disp('poiché A non ha dominanza diagonale STRETTA quindi non posso applicare il criterio sufficiente di convergenza per metodi di Jacobi e Gauss-Sidel');

% per SDP
disp('visto che A è sdp, converge per il metodo di Gauss-Sidel');

% convergenza per metodo iterativo in generale (Jacobi: 2D-A => conv.)
D = diag(diag(A));
if isequal( 2*D-A, transpose(2*D-A) )
    if all(eig(2*D-A)>0)
        disp('2D-A è sdp, pertanto converge il metodo di Jacobi');
    end
end

% alternativa: raggio spettrale \rho di matrice di iterazione < 1
E = -tril(A,-1);
F = -triu(A,1);
Bj = D\(E+F);
rhoBj = max(abs(eig(Bj)));
Bgs = (D-E)\F;
Bgs = full(Bgs);
rhoBgs = max(abs(eig(Bgs)));

disp("\rho_Bj e \rho_Bgs sono < 1, pertanto i due metodi convergono");

% convergenza del metodo di SOR
disp('per il teorema di Ostrowski: A sdp => SOR converge per 0 < \omega < 2');
disp('dato che A è sdp e tridiagonale, posso denifire \omega ottimale');

omega_opt = 2/(1+sqrt(1-(rhoBj)^2));    % =1,4465 pertanto converge

%% b) rapporto tra velocità di convergenza
disp("La relazione \rhoBj^2 = \rhoBgs vale per tutte le matrici sdp tridiagonali");
disp("tale relazione implica che la velocità asintotica di convergenza del metodo di G-S sarà doppio rispetto a quella del metodo di Jacobi");

x0 = zeros(n,1);
[xJ,itJ] = myJacobi(A,b,x0,1000,1e-12);
[xGS,itGS] = mySor(A,b,x0,1000,1e-12,1);

disp('Il metodo di Jacobi converge in un numero di iterazioni doppio rispetto a quello di G-S');

%% c) velocità di convergenza del metodo di SOR
[xSOR,itSOR] = mySor(A,b,x0,1e3,1e-12,omega_opt);
disp('Si nota che il metodo di SOR converge molto rapidamente rispetto a Gauss-Sidel, infatti questo algoritmo dipende molto alla scela di \omega');
