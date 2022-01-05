% Esercizio 4

%% Assoluta stabilità (problema di Cauchy)

% Un metodo numerico che ha generato u_n per risolvere PM è assolutamente
% stabile se lim_{n->+inf) u_n = 0;

% EE: u_{n+1} = u_n + h*lambda*u_n
%     --> u_n = (1+h*lambda)^{n+1}
%        u_n -> 0 <==> |1+h*lambda| < 1
%           ==> 0 < h < (-2*Re(lambda))/(|lambda|^2)
%               --> EE è condizionatamente A-stabile

%% Risoluzione del problema con EE
y = @(t) 2 * ( 2+t ) .* exp(-3.*t);
f = @(t,y) -((3*t+5) ./ (t+2)) .* y;
t_0 = 0;
t_max = 10;
y0 = 4;
h = 0.1;

[ th, uh ] = es4_ee( f, t_0, t_max, y0, h );

% Plot
figure(1)
hold on; grid on;
tvect = linspace( t_0, t_max, 1e3 );
yvect = y(tvect);
plot( tvect, yvect, th, uh );
legend('y','uh');

%% errore
hh = [ 0.2 0.05 0.005 0.001 ];
eh = zeros(length(hh));
for ii = 1: length(hh)
    [ th, uh ] = es4_ee( f, t_0, t_max, y0, hh(ii) );
    eh(ii) = norm( y(th) - uh, inf );
end

figure(2);
loglog( hh, eh, 'o--', hh, hh);
grid on;
legend( 'e_{h}', 'h' );

% converge con ordine 1