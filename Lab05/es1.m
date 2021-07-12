% Esercizio 1 Laboratorio 5
A = [
    10, -1, 2, 3;
    1, 10, -1, 2;
    2, 3, 20, -1;
    3, 2, 1, 20
];

xex = ones(size(A,1),1);

b = A*xex;

%% a) convergenza dei metodi di Jacobi e Gauss-Sidelyhb

% verifica proprietà matrici

disp("====== proprietà matrice A ======");

if isequal(A,A')
    disp('A è simmetrica')
else
    disp('A non è simmetrica')
end

if all(eig(A)>0)
    disp('A è definita positiva')
else
    disp('A non è definita positiva, e gli autovalori sono:')
    eig(A)
end

% convergenza per dominanza diagonale stretta per righe
disp("====== dominanza diagonale =====");
dom_diag = [ true, true ];
nn = size(A,1);

for ii = 1:nn
    if ( abs(A(ii,ii)) <= sum( abs( A(ii,[1:ii-1, ii+1:nn]) ) ) )
        dom_diag(1) = false;
    end
    
    if ( abs(A(ii,ii)) <= sum( abs( A([1:ii-1, ii+1:nn], ii) ) ) )
        dom_diag(2) = false;
    end
end

if dom_diag(1)
    disp('A è a dominanza diagonale per le righe, pertanto convergente');
else
    disp('A non è a dominanza diagonale per le righe');
end

if dom_diag(2)
    disp('A è a dominanza diagonale per le colonne, pertanto convergente');
else
    disp('A non è a dominanza diagonale per le colonne');
end   

% calcolo analitico del metodo di Jacobi e di Gauss-Seidel
D = diag(diag(A));
E = -1*tril(A,-1);
F = -1*triu(A,1);
BJ = D\(E+F);
rBJ = max(abs(eig(BJ)))
BGS = (D-E)\F;
rBGS = max(abs(eig(BGS)))
disp("infatti rJ e rGS sono < 1, pertanto convergenti");

%% b) numero minimo di iterazioni ( col errore iniziale ridotto del 10^(-10) )
norm_BJ = norm(BJ);     % =0.4034 < 1

% per fattore s'intende che norm(e^k)/norm(e^0) <= \epsilon
% per tanto facendo calcoli sempli su disuguaglianza fornita s'ottiene che 
k_min = ceil(-10/log10(norm_BJ))     % =25.3617, per tanto k >= 26

% NON posso usare il raggio spettrale \rho_BJ perchè A non è sdp.

%% c) verifica Nmax con myJacobi
x0 = zeros(4,1);
[xk, it] = myJacobi(A, b, x0, k_min, 0);

% confronto gli errori ottenuti
disp('========== JACOBI ==========');
err0 = norm(xex - x0);
errK = norm(xex - xk);
errK / err0

% il fattore ottenuto è 1.6093e-14 < 1e-10.

%% d) verifica col metodo di Gauss-Sidel
x0 = zeros(4,1);
omega = 1;
toll = 1e-10;
[xk, it] = mySor(A, b, x0, k_min, toll,omega);

% confronto gli errori ottenuti
disp('========== G-S ==========');
it
err0 = norm(xex - x0);
errK = norm(xex - xk);
errK / err0

% il metodo di Gauss-Sidel converge in 10 iterazioni alla tolleranza richiesta, col errore relativo di 4.2070e-11