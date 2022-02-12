% Esercizio 12 - Risoluuuuzione del sistema lineare

clear variables; close all; clc;

%% Sistema lineare

% A = [
%     6, 1, 9, 0, 0;
%     1, 12, 2, 6, 0;
%     9, 2, 18, 3, 3;
%     0, 6, 3, 24, 4;
%     0, 0, 3, 4, 30;
% ];

A = 6*diag(1:5) + diag(1:4,1) + diag(1:4,-1) + 3*diag(3:-1:1,2) + 3*diag(3:-1:1, -2);

% xex = [ 2, 2, 2, 2, 2 ]';

xex = 2 * ones(5,1);

% a) Calcolare il valore del termine noto b e il numero di condizionamento
b = A * xex;
k2a = cond(A);

%% b) Il metodo del gradiente coniugato

% Condizioni di applicabilità e di convergenza:
%   A e P matrici sdp

% Stima di convergenza:
%   converge in al più n iterazioni, ed 
%   ||e^k|| <= (2c^k)/(1+c^2k)*||e^0|| ove c=(sqrt(k2a)-1)/(sqrt(k2a)+1)

%% c) Verificare se la matrice A soddisfa le condizioni del pcg

if (isequal(A,A'))                  % A è simmetrica
    if (min(eig(A))>0)              % A è definita positiva
        fprintf("La matrice A è sdp\n");
    end
else
    fprintf("A non è sdp\n");
end

%% d) Applicare il metodo con Matlab Function pcg

nmax = 1e2;
x0 = zeros(5,1);
P = eye(5);
x1 = pcg( A, b, 1e-2, nmax, P, P, x0 );
x2 = pcg( A, b, 1e-3, nmax, P, P, x0 );

% residuo normalizzato
res1 = norm( x1 - xex )/norm(xex);
res2 = norm( x2 - xex )/norm(xex);