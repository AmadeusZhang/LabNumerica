% Esercizio 2 Laboratorio 7

A = delsq( numgrid('B',50) );
b = ones( size(A,1), 1 );

%% a) numero di condizionamento e metodo del pcg
num_cond = condest(A);
toll = 1e-12;
nmax = 1e3;
[X1,FLAG1,RELRES1,ITER1,RESVEC1] = pcg( A, b, toll, nmax );

if ITER1 < nmax && ~FLAG1
    fprintf("matrice converge per metodo del dcg in %d iterazioni\n", ITER1);
else
    disp("per metodo del dcg non converge nei limiti stabiliti");
end

semilogy( 1:length(RESVEC1), RESVEC1 );
grid on;
% il residuo normalizzato decresce in scala logaritmica

%% b) sistema precondizionato
P = diag( diag(A) ) + diag( diag(A,-1), -1 ) + diag( diag(A,1), 1 );

% verifica che P è sdp
if isequal(P, P')
    if all( eig(P)>0 )
        disp('P è una matrice sdp');
    end
else
    error('P non è una matrice sdp');
end

% sistema P\Ax=P\b
numCond_p = condest(P\A);
toll = 1e-12; nmax = 2e3;
[X2,FLAG2,RELRES2,ITER2,RESVEC2] = pcg( A, b, toll, nmax, P );

if ITER2 < nmax && ~FLAG2
    fprintf("matrice precondizionato converge per metodo del dcg in %d iterazioni\n", ITER2);
else
    disp("per metodo del dcg non converge nei limiti stabiliti");
end

semilogy( 1:length(RESVEC2), RESVEC2 );
grid on;
% il residuo normalizzato decresce in scala logaritmica

% confronto tra due implementazioni
%   Si evince immediatamente che il condizionamento del sistema precondizionato 
%   si riduce rispetto al caso precedente; coerentemente anche il numero di 
%   iterazioni necessarie per convergere alla soluzione è minore.