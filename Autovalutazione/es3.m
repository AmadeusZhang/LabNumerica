% Esercizio 3
%% a)
% Si descrivano le formule di integrazione semplice e composita del trapezio,
% fornendone l’interpretazione geometrica.

% Integrazione semplice:
%    sostituire alla funzione f il polinomio interpolare \Pi_n_f e
%    integrare in modo esatto \Pi_n_f (facile, poiché è un polinomio)
%
% Integrazione composita:
%    se l'intervallo è molto grande, non è detto che l'errore di
%    interpolazione sia piccolo, pertanto si procede partizionando
%    intervallo [a, b] in m sottointervalli, e integrare in modo semplice
%    su ogni intervallo
%
% caso particolare del trapezio: n=1
%    semplice: I_1(f) = (b-a)/2 * [ f(a)+f(b) ];
%    composta: I_{1,m}(f) = H * [ 1/2*f(x0)+f(x1)+ ··· + f(xm-1)+ 1/2*(fxm) ] 
%                           H := (b-a)/m

%% b) 
% Si riporti la formula dell’errore nel caso composito.

% E_{1,m}(f) = - (b-a)/12 * H^2 * f''(ksi), a < ksi < b

% Specificare il grado di esattezza e l’ordine di accuratezza.

% grado di esattezza = 1, ordine di accuratezza = 2
%% c) 
% Si descriva la formula di integrazione semplice del punto medio,
% se ne dimostri la formula dell’errore.

% punto medio: I_0(f) = (b-a) * f( (a+b)/2 );
% errore:      E_0(f) = h^3/3 * f''(ksi), h = (b-a)/2;
%    - dim: sviluppo di Taylor al secondo ordine della f(x) in
%               E(f) = I(a,b)f(x) - (b-a)*f(xm), xm = (a+b)/2
%           e usando il Thm. media integrale s'arriva alla tesi