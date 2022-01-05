% Implementazione la formula di quadratura del trapezio composita
%
% I = trapcomp( a, b, N, f )

function I = trapcomp( a, b, N, f )

%==========================================================================
% PARAMETRI DI INGRESSO
%   a       estremo inferiore di integrazione
%   b       estremo superiore di integrazione
%   N       numero di sottointervalli di suddivisione
%  fun      funzione da integrare
%
% PARAMETRI DI USCITA
%   I       valore approssimato dell'integrale
%==========================================================================

H = ( b-a )/N;                          % ampiezza sottointervalli

xl = a: H: b-H;                         % costruzione vettore punti medi

xr = a+H: H: b;

I = H/2 * sum( f(xl) + f(xr) );

%==========================================================================
% sp = 0;
% 
% for ii = 0: N
%     xx = a + ii * H;
%     temp = f( xx );
%     sp = sp + temp;
%     
% end
% 
% I = H * ( 0.5 * f(a) + sp + 0.5 * f(b) );
%==========================================================================