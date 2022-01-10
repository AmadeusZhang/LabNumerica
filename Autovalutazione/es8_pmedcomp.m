% Esercizio 8 - Implementazione "Integrazione per Punto Medio Composita"
%
% function I_N = pmedcomp(a, b, N, f)
%
% Descrizione degli input :
% — a,b : estremi di integrazione,
% — N : numero di sottointervalli
% — f : funzione da integrare (definita come inline o anonymous)
%
% Descrizione degli output :
% — I_N : integrale calcolato
%
% Formula di Quadratura: I_{pm, c} = H * sum( 1, M )( f( x_hat(k) ) )

function I_N = es8_pmedcomp( a, b, N, f )
% ampiezza sottointervallo
H = (b-a)/N;

% vettore punti medi
xpm = a+(H/2) : H : b-(H/2);

% Formula di Quadratura
I_N = H * sum( f( xpm ) );

end