% Esercizio 1 Laboratorio 6

%% a) Creazione componenti problema
n = 50;
A = zeros(n)+4*diag(ones(n,1));
kk = [-2 -1 1 2];
for ii = 1: length(kk)
    A = A + (-1)*diag( ones(n-abs(kk(ii)),1), kk(ii) );
end

b = 0.2*ones(n,1);

x0 = zeros(n,1);

%% b) verifica che tale A generata sia sdp e calcolarne il condizionamento
if isequal(A,transpose(A))
    if all(eig(A)>0)
        disp('A è una matrice sdp');
    end
else
    disp('A non è una matrice sdp');
end

k2a = max(eig(A))/min(eig(A));
%% c/d) implementazione funzione richardson.m

tol = 1e-5; nmax = 1e4;

P = eye(n);

mat_aux = P\A;

aut_opt = eig(mat_aux);

alpha = [ 0.2, 0.33, 2/( max(aut_opt) + min(aut_opt) ) ];

for ii = 1: length(alpha)
    [xrc, k] = richardson( A, b, P, x0, tol, nmax, alpha(ii));
    fprintf('Numero di kazioni per \x03b1 = %g : %g\n', alpha(ii), k);
    rho = max( abs(eig( P - alpha(ii) * mat_aux )) );
    fprintf('raggio spettrale: %g\n\n', rho);
end

%% e) errore relativo
xex = A\b;

C = ( k2a - 1 ) / ( k2a + 1 );

% verifica stima
stima = norm(xrc - xex) <= C^k * norm(x0 - xex);

if stima
    disp('Si è verificata la stima');
else
    disp('Non si verifica la stima');
end

%% f) confronto tra metodo di Richardson e Gauss-Sidel
tol = 1e-5; nmax = 1e5; alpha = 1;

% metodo di Richardson
P = tril(A);
[xrc, krc] = richardson( A, b, P, x0, 1e-5, nmax, alpha );
mat_cond = P\A;
mat_iter = eye(n) - mat_cond;
cond_rc = cond( mat_iter );
rho_rc = max(abs(eig( mat_iter )));
fprintf("col numero di condizionamento: %g \t e raggio spettrale: %g \n\n", cond_rc, rho_rc);

% metodo di Gauss-Sidel
omega = 1;
[xgs, kgs] = mySor( A, b, x0, nmax, tol, omega );
fprintf("Gauss-Sidel converge in %d iterazioni\n", kgs);
D = diag(diag(A));
E = -1 * tril(A, -1);
F = -1 * triu(A, 1);
Bgs = (D-E)\F;
cond_gs = cond(Bgs);
rho_gs = max(abs(eig(Bgs)));
fprintf("col numero di condizionamento: %g \t e raggio spettrale: %g \n\n", cond_gs, rho_gs);
disp('Si osserva immediatamente che i due raggi spettrale sono uguali, pertanto convergono allo stesso tempo');

%% g) condizionatore tridiagonale
clc
P = 2*diag( ones(n,1) )- diag( ones(n-1,1),1 )- diag( ones(n-1,1),-1 );

% verifica se P è sdp
if isequal(P, P')
    if all(eig(P)>0)
        disp('P è una matrice sdp');
    end
else
    disp('P non è sdp');
end

% matrice di iterazione P^(-1)*A
mat_iter = P\A;
eig_iter = eig(mat_iter);
alpha_opt = 2/( max(eig_iter) + min(eig_iter) );

% implementazione metodo di Richardson
tol = 1e-5; nmax = 1e5;
[xrc, krc] = richardson( A, b, P, x0, tol, nmax, alpha_opt );

% cond_rc = max(eig_iter) / min(eig_iter);
% questo formula se P\A è sdp

cond_rc = cond(P\A);

B_alpha = eye(n) - alpha_opt * ( P \ A );
rho_rc = max( abs( eig(B_alpha) ) );
fprintf("- raggio spettrale: %g\n- numero di condizionamento: %g\n", rho_rc, cond_rc);