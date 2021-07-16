% Esercizio 1 Laboratorio 7

A = [
     4.24,   -4.32;
    -4.32,    6.76
];

b = [ 4, 8 ]';

x = linspace( -10, 10, 80 );
y = linspace( -10, 10, 80 );

[X, Y] = meshgrid(x, y);

Phi = 0.5 * ( A(1,1) * X.^2 + 2 * X.*Y * A(1,2) + A(2,2) * Y.^2 ) - ( b(1)*X + b(2)*Y );

figure;
subplot(1,2,1)
surf( X, Y, Phi, 'Lines', 'no' );
title(' \Phi - Superficie ');

subplot(1, 2, 2)
contour( X, Y, Phi, 20 );
hold on;
title(' \Phi - Linee di livello ');

%% a) metodo di Richardson Stazionario
[n, m] = size(A);
if n ~= m
    error('A non è una matrice quadrata');
end

P = eye(n);
x0 = [ -9, -9 ]';
tol = 1e-7; nmax = 1e3;
alpha = [ 0.05, 0.24 ];

for ii = 1 : length(alpha)
    [xkrc, krc] = richardsonPlus( A, b, P, x0, tol, nmax, alpha(ii) );
    figure();
    contour( X, Y, Phi, 20 );
    hold on
    title([ ' \Phi - \alpha = ', num2str(alpha(ii)) ]);
    % occorre inoltre fissare asse x in [-10, 10] perché nel caso
    % divergente il grafico viene infinitamente allontamento.
    axis([-10, 10, -10, 10])
    plot( xkrc(1,:), xkrc(2,:), '-or' )
    hold off
end

%% b) metodo del gradiente precondizionato
P = [
     1.0912,     -0.8587;
    -0.8587,      1.5921;
];

% verifica se P è sdp
if isequal( P, P' )
    if all( eig(P) > 0 )
        disp('P è una matrice sdp');
    end
else
    error('P non è una matrice sdp');
end

x0 = [ -9, 9 ]';
tol = 1e-7; nmax = 1e3;
[xkgr, kgr] = gradientePlus( A, b, P, x0, tol, nmax );

figure();
contour( X, Y, Phi, 20 );
hold on;
title( ' \Phi - Gradiente ' );
plot( xkgr(1,:), xkgr(2,:), '-or' )
hold off;

%% c) sistema precondizionato
PA = P^(-1) * A;
Pb = P^(-1) * b;

% P^(-1)*A non è simmetrica pertanto non possiamo applicare il metodo del
% gradiente.
% In generale, applicare il metodo del gradiente precondizionato al sistema Ax=b 
% NON equivale ad applicare il metodo del gradiente al sistema
% precondizionato P^(-1)Ax = P^(-1)b.