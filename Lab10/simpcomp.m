% Implementazione la formula di quadratura di Cavalieri-Simpson composita

function I = simpcomp( a, b, N, f )

%==========================================================================
% PARAMETRI DI INGRESSO
%   a       estremo inferiore di integrazione
%   b       estremo superiore di integrazione
%   N       numero di sottointervalli di suddivisione
%   f       funzione da integrare (function handle)
%
% PARAMETRI DI USCITA
%   I       valore approssimato dell'integrale
%==========================================================================

H = ( b-a ) / N;                            % ampiezza sottointervalli

% a | XL-X-XR | XL-X-XR | XL-X-XR | b       % costruzione punti medi
xm = (a+H/2: H: b-H/2);

xl = (a: H: b-H);

xr = (a+H: H: b);

I = (H/6) * sum( f(xl) + 4*f(xm) + f(xr) );
