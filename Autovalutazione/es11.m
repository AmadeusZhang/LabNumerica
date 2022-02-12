% Esercizio 11 - Problema degli zeri

close all; clear variables; clc

%% Condizioni per l'applicazione del metodo di bisezione

% f C^0([a,b]) e f(a)f(b)<0

%% Disegnare il grafico della funzione
LIMS = [ -2, 1.2 ];
f = @(x) (x.^2-1).*sinh(x+1);
df = @(x) 2.*x.*sinh(x + 1) + cosh(x + 1).*(x.^2 - 1);

fplot( f, LIMS ); grid on; hold on;
fplot( df, LIMS ); hold off;
legend( 'f', 'df' );

% ZERI ESATTI:
%   x = -1 (m.a. 2);
%   x = +1 (m.a. 1);

%% Implementare il metodo di bisezione
toll = 1e-3;
a = 0;
b = 1.2;

[ xvect, it ] = es11_Bisezione( a, b, toll, f );
% il metodo e' applicabile solo per x = +1, per x = -1 si deve applicare il
% newton modificato

fprintf("Lo zero ricercato: %12.8f\n", xvect(it));
fprintf("Numero di Iterazioni: %d \n", it);

%% Discutere l'applicabilità del metodo di Newton

%  Il metodo di Newton è applicabile se f è C^1([-2, 1.2])
%       --> f lo e'

%  ORDINE DI CONVERGENZA per ogni zero:
%    in x = -1 la derivata e' nulla, pertanto f converge con ordine 2 e si
%    deve applicare il newton modificato (se no converge con ordine 1);
%    in x = +1 la derivata non e' nulla, dunque f converge con ordine 1;