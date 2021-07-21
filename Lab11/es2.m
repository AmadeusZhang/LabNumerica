% Esercizio 2 Laboratorio 11
% estremi di integrazione 
a = -1; b = 1;

%% a) determinare i pesi relativi t.c. grado di esattezza = 2
% punti di interpolazione
% syms alpha;       % usato per calcolare in primo mano
alpha = 0;
xnod = [ -1, alpha, 1 ];

% costruzione sistema lineare
A = [
    xnod .^ 0;
    xnod .^ 1;
    xnod .^ 2
];

v = [ 2; 0; 2/3 ];

wn = A\v;

%% b) determinare alpha
% facendo con la carta e penna, introducento la 4a equazione s'ottiene:
%       4alpha( alpha-1 ) = 0
% essendo abs(alpha) < 1 segue che:

alpha = 0;

%% c) trasformazione lineare
