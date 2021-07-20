% Implementazione della formula del punto medio composita

function I = pmedcomp( a, b, N, f )

%==========================================================================
% PARAMETRI DI INGRESSO
%   a       estremo inferiore di integrazione
%   b       estremo superiore di integrazione
%   N       numero di sottointervalli di suddivisione
%   f       funzione da integrare
%
% PARAMETRI DI USCITA
%   I       valore approssimato dell'integrale
%==========================================================================

H = ( b-a ) / N;            % ampiezza di suddivisione

% costruzione punti intermedi
% a|-x-|-x-|-x-|-x-|-x-|b      |-x-| == H, x si trova in H/2
xm = linspace( a+H/2, b-H/2, N );

% in alternativa:   xm = [ a+H/2: H: b-H/2 ];

% valutazione dei punti

func = f( xm );

% calcolo sommatoria (integrale approssimato)

I = H * sum(func);

return 

%==========================================================================
% sp = 0;                           % somme parziali
% 
% for ii = 0: N-1
%     x_ii = a + H/2 + (ii)*H;
%     sp = sp + f(x_ii)
% end
% 
% I = H * sp;
%==========================================================================