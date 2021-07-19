% Esercizio 1 Laboratorio 10

clear all, clc

a = 0; b = 1;

% f = @(t) cos( pi/2 * t );           % esa

f = @(t) sqrt(t);                     % esb

Ipmed = 0; Isimp = 0; Itrap = 0;

% vettori errori
err_pmed = [];
err_trap = [];
err_simp = [];

% integrale esatto ( valore ottenuto per calcolo )
% Iex = 2/pi;       % esa
Iex = 2/3;          % esb             

nvect = 2.^(1:7);

for ii = nvect
    Ipmed = pmedcomp( a, b, ii, f );
    
    Isimp = simpcomp( a, b, ii, f );
    
    Itrap = trapcomp( a, b, ii, f );
    
    % ordine di convergenza
    err_pmed = [ err_pmed abs( Ipmed - Iex ) ];
    err_simp = [ err_simp abs( Isimp - Iex ) ];
    err_trap = [ err_trap abs( Itrap - Iex ) ];
    
end

% per confronto plot:
hvect = (b-a) ./ nvect;
loglog( hvect, err_pmed, hvect, err_simp, hvect, err_trap );
grid on;
legend( 'err. punto medio', 'err. Simpson', 'err. trapezio' );
title( 'confronto tra diverse formule composite' );

% retta per confronto dell'ordine
hold on;
loglog( hvect, hvect, 'k--' );
loglog( hvect, hvect.^2, 'r--' );
loglog( hvect, hvect.^4, 'g--');
legend( 'err. punto medio', 'err. Simpson', 'err. trapezio', 'H', 'H^2', 'H^4' );

xlabel('\leftarrow');
ylabel('\leftarrow');

%==========================================================================
% COMMENTO
%==========================================================================
%  ordine di convergenza:
%       | E_n(f) | := | f - \Pi_n f | <= C * H^(n),     n = ordine
%==========================================================================
% - err. del punto medio:
%       parallelo alla retta di H^2 cioò ha lo stesso andamento di H^2, e
%       errore della formula del punto medio decresce come H^2;
% - err. del trapezio:
%       idem;
% - err. di Simpson:
%       parallela alla retta di H^4, pertanto converge con ordine 4.
%
% ATTENZIONE: in questo caso il grafico è in asse negativa, pertanto
% leggere dalla dx alla sx
%==========================================================================

%% stima dell'ordine dell'errore a mano
% err = C*H^P
% err1 al passo N = H,
% ess2 al passo N+1 = H/2;
% => err1/err2 = [H/(H+2)]^P = 2^P
% ==> P = log2( err1/err2 );

p_pmed = log2( err_pmed( 1: end-1 ) ./ err_pmed( 2: end ) );
p_trap = log2( err_trap( 1: end-1 ) ./ err_trap( 2: end ) );
p_simp = log2( err_simp( 1: end-1 ) ./ err_simp( 2: end ) );

% commento: abbiamo ottenuto risultati in coerenza con le stime teoriche