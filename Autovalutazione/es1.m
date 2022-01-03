% Fattorizzazione LU

clear all; clc;

% CNS: i sottomatrici principali sono non-singolari

%% verificare che la matrice A soddisfa condizioni di LU
A = [
    3, 2, 1, 1;
    1, 2, 3, 0;
    2, 1, 2, 3;
    0, 1, 1, 2
];

% quando una sottomatrice è singolare? --> quando la sua det è 0
ll = length( A );
ii = 1; dc = 1;

while ( (ii<=ll) && (dc~=0) )
    dc = det( A(1:ii, 1:ii) );
    ii = ii+1;
end

if ( dc == 0 )
    disp("A non è fattorizzabile");
else
    disp("A è fattorizzabile");
end

%% si calcolino le matrici L e U
[L, U] = lu(A);

%% implementare funzione solve
b = [ 1 1 1 1 ]';
xx = es1solve( L, U, b );

% xx coincide con la soluzione ottenuta per A\b, c.v.d
xvect = A\b;

toll = 1e-6;
if ( norm( xx-xvect, Inf ) < toll )
    disp('algoritmo esatto');
end