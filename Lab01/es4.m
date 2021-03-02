% Esercizio 4
n = 10;
I = eye(n);
S1 = (-1)*diag(ones(1,n-1),+1);
S2 = (-1)*diag(ones(1,n-1),-1);
A = 2*I + S1 + S2;

%% determinante
d = det(A);

%% norme
n1 = norm(A,1);
n2 = norm(A);
nInf = norm(A, Inf);

%% condizionamento
k1 = cond(A,1);
k2 = cond(A,2);
kInf = cond(A, Inf);


%% autovalori e autovettori
[V, D] = eig(A);
v3 = V(:,3);
d3 = D(3,3);

%% raggio spettrale
rho = max(max(D));

%% diagonalizzabilità
P = V\A*V;