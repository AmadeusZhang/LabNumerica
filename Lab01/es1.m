% Esercizio 1a
% Calcolare il det. di M

M = [ 2 3 4; 3 4 5; 4 5 6];

d = det(M);

% Esercizio 1b
% Costruire matrice A ordine n = 10, aij = i+j

A = zeros(10);

for i = 1:10
    for j = 1:10
        A(i,j) = i+j;
    end
end


% Esercizio 1c
% elemento a53
A(5,3);
% prima colonna
A(:,1);
% terza riga
A(3,:);
% diagonale principale
diag(A);
% matrice triangolare superiore
triu(A);
% colonne 3,4 e 8 in B
B = zeros(3,10);
B = A(:,[3,4,8]);
% righe 1, 3 e 10 in C
C = zeros(10,3);
C = A([1,3,10],:);
rank(C)

%% Esercizio 1d
% Costruzione della matrice
n = 15;
I = eye(n);
d2 = 2*diag(ones(1,n-1),+1);
D = I+d2;
D(:,1) = 1:n;
