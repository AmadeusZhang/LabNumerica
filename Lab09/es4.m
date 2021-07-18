% Esercizio 2 Laboratorio 9

% creazione vettori dati sperimentali
xnod = [ 0.1800 0.3000 0.5000 0.6000 0.7200 0.7500 0.8000 0.9000 1.0000 ];
ynod = [ 0.0005 0.0010 0.0013 0.0015 0.0020 0.0045 0.0060 0.0070 0.0085 ];

figure(1);
plot( xnod, ynod, 'o' );
xlabel('Sforzo \sigma');
ylabel({'Deformazione $\varepsilon$'},'FontSize', 13, 'Interpreter','latex');
title('Dati Sperimentali');

n = length( xnod ) - 1;

xvect = linspace( min(xnod), max(xnod), 1e3 );

%% interpolazione polinomiale di Lagrande
p_lag = polyfit( xnod, ynod, n );
y_lag = polyval( p_lag, xvect );

figure(2);
plot( xnod, ynod, 'ko', xvect, y_lag, 'r', 'LineWidth', 1 );
grid on;
xlabel('Sforzo \sigma');
ylabel({'Deformazione $\varepsilon$'},'FontSize', 13, 'Interpreter','latex');
title('Interpolazione Polinomiale di Lagrange');

%% interpolazione polinomiale composita lineare

% >> help interp1

% Vq = interp1(X,V,Xq) interpolates to find Vq, the values of the
% underlying function V=F(X) at the query points Xq.

y_interp = interp1( xnod, ynod, xvect);

figure(3);
plot( xnod, ynod, 'ko', xvect, y_interp, 'r', 'LineWidth', 1 );
grid on;
xlabel('Sforzo \sigma');
ylabel({'Deformazione $\varepsilon$'},'FontSize', 13, 'Interpreter','latex');
title('Interpolazione Polinomiale composita lineare');

%% approssimazione dei minimi quadrati

deg = [ 1 2 4 ];

figure(4);
plot( xnod, ynod, 'ko' );
hold on; grid on;

for ii = 1: length(deg)
    y_lsq = polyval( polyfit( xnod, ynod, deg(ii) ), xvect );
    
    plot( xvect, y_lsq, 'LineWidth', 1 );
    
end

xlabel('Sforzo \sigma');
ylabel({'Deformazione $\varepsilon$'},'FontSize', 13, 'Interpreter','latex');
title('Approssimazione Minimi Quadrati');
legend('dati sperimentali', 'mq ord. 1', 'mq ord. 2', 'mq ord. 4');

%% confronto tra diversi metodi di interpolazione
figure(5);
plot( xnod, ynod, 'ko' );
hold on; grid on;
% plot( xvect, y_lag, 'r', 'LineWidth', 1 );
plot( xvect, y_interp, 'g', 'LineWidth', 1 );
plot( xvect, y_lsq, 'b', 'LineWidth', 1 );
title('confronto tra interpolazioni');
legend('dati', 'polinomio di Lagrange', 'interpolazione mista', 'appross. minimi quadrati ord. 4' );

%==========================================================================
% COMMENTO
%==========================================================================
% L'interpolazione polinomiale di Lagrange è meno adatto ai dati in ingresso,
% in quanto risulta oscillante negli estremi.
% Mentre altri due metodi sembrano avere una buona approssimazione.

%% confronto valutazione nei punti
sigma = [ 0.4 0.65 ];

y_lag = polyval( p_lag, sigma );
y_interp = interp1( xnod, ynod, sigma );
y_lsq = polyval( polyfit( xnod, ynod, 4 ), sigma );

fprintf('Sigma: %f %f\n', sigma)
fprintf('Epsilon Lagrangiana: %f %f\n', y_lag)
fprintf('Epsilon Interp. mista: %f %f\n', y_interp)
fprintf('Epsilon Minimi Quadrati ord. 4: %f %f\n', y_lsq)

%==========================================================================
% COMMENTO
%==========================================================================
% L'interpolazione polinomiale di Lagrange resta ancora non adatto, in
% quanto fornisce deformazioni negative per sforzi positivi, ciò è assurdo.
% Riguardando altri due metodi invece forniscono valutazioni ragionevoli,
% tuttavia il metodo dei minimi quadrati essendo una funzione di grado > 1
% fornisce una maggiore regolarità rispetto all'interpolazione composita,
% che è lineare ( in particoalre C^0) nell'intervallo considerato.
