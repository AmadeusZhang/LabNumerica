% Esercizio 5

% Quadratura del trapezio composita

f = @(x) sqrt( (1-x).^5 );
g = @(x) sqrt( 1-x );

xvect = linspace( -1, 1, 1e3 );

%% Rappresentazione grafica
plot( xvect, f(xvect), xvect, g(xvect) );
hold on; grid on;
legend( 'f', 'g' );

%% espressione della formula ed interpretazione grafica
% I_{1,m}(f) = H * { 1/2*f(x0) + f(x1) + ... + f(xm-1) + 1/2*f(xm) };

% suddividere l'intervallo di integrazione in m sottointervalli e su
% ciascun d'essi applicare formula di integrazione trapezio semplice:
% ovvero interpolazione con 2 nodi (estremi dell'intervallo)

% errore: E_{1,m} = -(b-a)/12 * H^2 * f''(ksi), ksi in (a,b);

% grado di esatezza = 1, ordine di accuratezza = 2;

% richiede che funzione integranda f sia C^2;

%% implementazione del metodo
NN = 5 * 2.^(0:4);
fvect = zeros( 1, length(NN) );
gvect = zeros( 1, length(NN) );
for ii = 1: length(NN)
    I = es5_trapcomp( -1, 1, NN(ii), f );
    fvect(ii) = I;
    
    I = es5_trapcomp( -1, 1, NN(ii), g );
    gvect(ii) = I;
end

%% calcolo dell'errore
I_f = sqrt(512)/7;
I_g = sqrt(32)/3;

E_f = zeros( 1, length(NN) );
E_g = zeros( 1, length(NN) );
for ii = 1: length(NN)
   err = norm( I_f - fvect(ii), inf );
   E_f(ii) = err;
   
   err = norm( I_g - gvect(ii), inf );
   E_g(ii) = err;
end

hvect = (1-(-1))./NN;

% rapprensentazione grafica in scala logaritmica
figure(2);
loglog( hvect, E_f, 'o-', hvect, E_g, '-+' )
hold on;
grid on;
loglog( hvect, hvect, '--', hvect, hvect.^2, 'k--' )
legend( 'E_{n}(f)', 'E_{n}(g)', 'H', 'H^2' );

%% COMMENTO
disp('f~H^2, g~H coincidono con le stime teoriche, poiché g non è C^2 nel intrevallo di integrazione');