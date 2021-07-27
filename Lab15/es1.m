% Esercizio 1 Laboratorio 15

clear; close all; clc

% definizione f
f = @(x) cos(x-1).^2 - x.^2;

% derivata prima di f
df = @(x) 2*cos(x-1).*(-sin(x-1)) - 2*x;

% dominio
a = 0;
b = 2.7;

%% a) determinare le radici e la loro molteplicità

% plot delle funzioni f, df (metodo grafico)
xvect = linspace( a, b, 1e3 );
plot( xvect, f(xvect), 'k--', xvect, df(xvect), ':', 'LineWidth', 1 );
legend( 'f', 'df' );
grid on;

% commento:
%  f(1)  = 0 --> zero della funzione
% df(1) != 0 --> molteplicità 1

%% b-c) implementazione del metodo delle corde

% definizione tolleranza e max #iterazioni
tol = 1e-10;
kmax = 1e2;     % opportuno ==> che sia non-vincolante per ciclo

% definire diversi valori di x0 iniziale
xx = [ 0.3  0.6  1.2 ];

% ciclo: 
for ii = 1: length(xx)
    x0 = xx(ii);
    % richiamo metood delle corde implementato
    [ xvect_corde, niter_corde ] = corde( a, b, x0, kmax, tol, f );
    
    % plot in scala semilogaritmica degli ERRORI
    err = abs( xvect_corde-1 );   % abbiamo trovato in precedenza x=1 è uno zero
    figure();
    semilogy( 0: niter_corde, err );    % be careful about dimension
    grid on; hold on;
    title(['errore per x0 = ', num2str(x0)]);
    
    % d) metodo di bisezione
    f_str = 'cos(x-1).^2 - x.^2';
    [ xvect_bisez, ~, ~, it_bisez ] = qssbisez( a, b, kmax, tol, f_str);
    
    % d) metodo di secante
    x1= x0; x0 = b;
    [ xvect_secanti, ~, ~, it_secanti ] = qsssecanti( x0, x1, kmax, tol, f_str);
    
    % plot:
    semilogy( 1: it_bisez, abs( xvect_bisez-1 ) );
    semilogy( -1: it_secanti, abs( xvect_secanti-1 ) );
    legend('corde', 'bisezione', 'secanti');
    
    % e) qssstimap
    disp('il metodo delle corde');
    qssstimap(xvect_corde);
    
    disp('il metodo delle secanti');
    qssstimap(xvect_secanti);
    
    disp('il metodo della bisezione');
    qssstimap(xvect_bisez);
    
end
