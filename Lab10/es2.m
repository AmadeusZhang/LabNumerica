% Esercizio 2 Laboratorio 10

clear; clc;

% invocazione funzione lgwt
% [xn, wn] = lgwt( n+1, -1, 1 );

%% a) formula di quadratura Gaussiana 

% fisso n
n = 3;                                  

% al variare di p: (non faccio il ciclo for per ora)
p = 0;

% definire la funzione da integrare => handle function
f = @(t) t.^p;

% calcolare i nodi e pesi => lgwt (questa può essere spostata fuori al ciclo)
[xn, wn] = lgwt( n+1,-1, 1 );

% applicare la quadratura => sommatoria
Igl = sum( wn .* f( xn ) );

% calcolare l'integrale esatto 
Iex = 1/(p+1)*(1-(-1)^(p+1));

% calcolare l'errore
err = abs( Igl - Iex );                 % = 8.881784197001252e-16

% ricordiamo che e-16 è errore macchina, pertanto possiamo considerarlo
% come fosse un 0. Quindi integrazione Gaussiana coincide col valore
% esatto.

%% b) grado di esattezza

n = 3;
[xn, wn] = lgwt( n+1,-1, 1 );

err = zeros(1,9);

for p = 0: 9
    f = @(t) t.^p;
    Igl = sum( wn .* f( xn ) );
    Iex = 1/(p+1)*(1-(-1)^(p+1));
    err(p+1) = abs( Igl - Iex );
end

%==========================================================================
% COMMENTO
%==========================================================================
% il primo termine non nullo è nel err(9) pertanto, grado di esattezza è 7
% (7 perché indice di MATLAB parte da 1, pertanto è 8th elemento, riducendo
% di un grado, torna 7)
% la presenza dei valori zeri (non approssimativamente nulli) è dovuta alla
% simmetria dei nodi, basta pensare integrale di una funzione dispari in un
% intervallo simmetrico => Iex = 0;
%
% stima teorica: grado di esattezza è 2n+1 che è in coerenza col elaborato
%==========================================================================

%% altre verifiche
clear; clc;
n = 6; k = 15;
[xn, wn] = lgwt( n+1,-1, 1 );

err = zeros(1,k);

for p = 0: k
    f = @(t) t.^p;
    Igl = sum( wn .* f( xn ) );
    Iex = 1/(p+1)*(1-(-1)^(p+1));
    err(p+1) = abs( Igl - Iex );
end
