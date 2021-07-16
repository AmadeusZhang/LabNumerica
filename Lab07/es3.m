% Esercizio 3 Laboratorio 7

%% a) implementazione FEM4MI dati.m

%% b) implementazione FEM4MI main1D.m

nRef = [ 5, 6, 7 ];

for ii = 1: length(nRef)
    [errors,solutions,femregion,Dati, k_iter, num_cond] = es3b_main1D( 'Test1', nRef(ii) );
    fprintf( "per nRef = %d \n - numero di condizionamento: %g \n - numero di iterazioni: %d \n", nRef(ii), num_cond, k_iter );
    Cgrad = ( num_cond - 1 ) / ( num_cond + 1 );
    fprintf( "coefficiente di abbatimento dell'errore: %g\n", Cgrad );
end

% Riporto gli OUTPUT
%
% per nRef = 5 
%  - numero di condizionamento: 414.345 
%  - numero di iterazioni: 5600 
% coefficiente di abbatimento dell'errore: 0.995185
% 
% per nRef = 6 
%  - numero di condizionamento: 1659.38 
%  - numero di iterazioni: 22489 
% coefficiente di abbatimento dell'errore: 0.998795
% 
% per nRef = 7 
%  - numero di condizionamento: 6639.52 
%  - numero di iterazioni: 89811 
% coefficiente di abbatimento dell'errore: 0.999699
%
% Osserviamo che raffinando la griglia di calcolo, il numero di
% condizionamento del sistema aumenta, dunque l'errore si abbatte più
% lentamente e servono più iterazioni per raggiungere la convergenza.

%% c) implementazione col metodo del gradiente coniugato precondizionato (pcg)

nRef = [ 5, 6, 7 ];

for ii = 1: length(nRef)
    [errors,solutions,femregion,Dati, k_iter, c_grad] = es3c_main1D( 'Test1', nRef(ii) );
    fprintf( "per nRef = %d \n - numero di iterazioni: %d \n", nRef(ii), k_iter );
end

% Riporto gli OUTPUT
% per nRef = 5
%  - numero di iterazioni: 16
% 
% per nRef = 6
%  - numero di iterazioni: 32
% 
% per nRef = 7
%  - numero di iterazioni: 64

%% d) confronto tra stimatori dei due metodi

nRef = [ 5, 6, 7 ];

for ii = 1: length(nRef)
    [ k_iter ] = es3d_main1D( 'Test1', nRef(ii) );
end

% Il fattore di abbatimento decresce all'aumentare del numero di
% iterazioni. Per questo il numero di iterazioni del metodo di PCG risulta
% essere significativamente minore rispette al metodo del gradiente.