% Esercizio 9 - Sistema Lineare

close all; clear all; clc

%% il metodo di Gauss-Sidel

% i) Condizioni di applicabilità del metodo di Gauss-Sidel :
        % P = D-E sia non singolare <==> diagonale non nulla
        
% ii) consizioni necessarie e sufficienti per sua convergenza:
        % 1. le matrici a dominanza diagonale stretta per righe
        % 2. le matrici reali simmetriche e definite positive
        
A = [
    2, -1, 0, 0, 0;
    -1, 2, -1, 0, 0;
    0, -1, 2, -1, 0;
    0, 0, -1, 2, -1;
    0, 0, 0, -1, 2;
];



xex = [ 1, 1, 1, 1, 1 ]';

b = A * xex;

% Verificare se la matrice A soddisfa le condizioni di (i) e (ii):

D = diag(A);
E = tril(A) - D;
P = D-E;

if ( det(P) )   % P is not singular
    disp('è possibile applicare il metodo di Gauss-Sidel');
else
    disp('non soddisfa le condizioni di applicabilità');
end

if ( min( eig(A) ) > 0 )    % tutti gli autovalori sono strettamente positivi
    disp('A è sdp ==> il metodo di Gauss-Sidel converge');
end

%% Applicazione del metodo G-S
x0 = zeros(5,1);
nmax = 1e2;
toll = 1e-6;

[ xn, iter ] = mySor( A, b, x0, nmax, toll, 1 );

% Soluzione approssimata e il valore del residuo normalizzato
res = norm( xn-xex, inf );

% (T)  In base ai risultati ottenuti, cosa si può concludere relativamente
%      all’applicabilità e alla convergenza del metodo di Jacobi per la 
%      risoluzione del sistema Ax = b ?

%      poiché A è una matrice tridiagonale, si ha che
%               rho(Bgs) = rho^2(Bj)
%      pertanto, i due metodi convergono o divergono contemporaneamente.