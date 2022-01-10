% Esercizio 6
clear all; close all;

% Intervalli di definizione
a = -2; b = 2;

% Funzione interpolante
f = @(x) exp(1-x).*((x+1).^2);

% rappresentazione della funzione
xvect = linspace( a, b, 1e3 );
yvect = f( xvect );
% figure(1);
% plot( xvect, yvect );
% hold on; grid on;

% vettori ausiliari
HH = [];
err_interp1 = [];
err_polyfit = [];

% al variare di N:
for nn = 10 .* ( 2 .^ (3:6) )
    % ampiezza sottointervalli
    H = (b-a)/nn;
    HH = [ HH H ];
    
    % nodi di interpolazione
    x_nod = linspace( a, b, nn+1 );
    y_nod = f( x_nod );
    
    % polinomio interpolatore composito lineare - interp1
    y_interp1 = interp1( x_nod, y_nod, xvect );
    
    % troncamento dell'errore
    err = norm( y_interp1 - yvect, inf );
    err_interp1 = [ err_interp1 err ];
    
    % nodi di Chebyshev-Gauss-Lobatto
    x_tilde = -cos( pi*(1: nn+1)/(nn+1)  );
    x_cgl = (a+b)/2 + ((b-a)/2)*x_tilde;
    y_cgl = f( x_cgl );
    
    % polinomio interpolatore dei nodi CGL - polyfit
    coeff_cgl = polyfit( x_cgl, y_cgl, nn );
    y_polyfit = polyval( coeff_cgl, xvect );
    
    % errore:
    err_polyfit = [ err_polyfit norm( yvect - y_polyfit, inf ) ];
end

loglog( HH, HH, 'k--', HH, HH.^2, 'k', HH, err_interp1, 'ro-', HH.^2, err_polyfit, 'b' );

% DOMANDA: perché err_polyfit ha asse x la HH^2?

legend( 'H^1', 'H^2', 'err_{interp1}', 'err_{polyfit}' );

%======================== COMMENTO ========================%
% Il polinomio interpolatore composito lineare (interp1) converge con
% ordine 2, infatti essendo f C^2 nell'intervallo di definizione.
