% Esercizio 1 Laboratorio 8

func = @(x) 1 ./ (1+x.^2);                  % funzione di Runge

% estremi di intervallo
a = -5; b = 5;

%% a) Interpolazione col polyfit e polyval

n = [ 10, 20 ];

figure();

for ii = 1: 2
    % vettore di nodi equispaziati da interpolare => linspace con (n+1)
    xnod = linspace( a, b, n(ii)+1 );
    ynod = func(xnod);
    
    % h = ( b-a ) / ( n(ii)+1 );
    
    % Fit a polynomial p of degree n to the (x,y) data:
    p_fit = polyfit( xnod, ynod, n(ii) );
    
% P = P(1)*X^N + P(2)*X^(N-1) +...+ P(N)*X + P(N+1), ordine decrescente
    
    % Evaluate the fitted polynomial p and plot:
    xvect = linspace( a, b, 1e3 );
    fit_poly = polyval( p_fit, xvect );
    
% valuto in xvect e non in xnod, perchè ricordo che p è costuitto dal
% xnod, inoltre ottengo pochi punti (n+1); invece col xvect ho una
% costruzione più fitta.
%
% fit_poly := p(xvect)
    
    subplot(2, 1, ii);
    plot( xvect, func(xvect), 'k', xvect, fit_poly, 'r' );
    grid on;
    hold on;
    
    % evidenza l'interpolante nei nodi di interpolazione
    plot( xnod, ynod, '*' );
    hold off
    title( ['Interpolazione Polimoniale con n=', num2str( n(ii) )] );
    legend( 'funzione: f(x)', 'interpolante: \Pi_n f(x)', 'nodi equispaziati' );
    set( legend, 'Location', 'Best' );
    
    % calcolo errore
    err = norm( func(xvect)-fit_poly, inf );
    
% errore nei valori di xvect, non nei nodi; anche perchè l'errore nei nodi
% sarà approssimativamente 0.

    fprintf('Errore in norma del massimo: %g\n', err);
    
end

%==========================================================================
% COMMENTO PERSONALE
%==========================================================================
%
% Infatti questo è il controesempio di Runge: afferma che NON SEMPRE
% all'aumentare del numero di nodi diminuisce l'errore (nodi equispaziati).
% Come si osserva in questo caso, la norma per grado n=20 è aumentato
% significativamente, inoltre MATLAB segnala che il polinomio è mal
% condizionato.

%% b) Implementazione della funzione poly

%==========================================================================
% RIPASSO 
%==========================================================================
% il polinomio nodale di grado n+1
%
%           \omega_n+1 (x) = Produttoria ( x-x_i )

n = [ 10, 20 ];

figure();

for ii = 1: 2
    % nodi equispaziati
    xnod = linspace( a, b, n(ii)+1 );
    
    w = poly( xnod );
    % poly:
    % INGRESSO: x dei nodi
    % OUTPUT: P polinomio dei coefficienti
    
    yw = polyval( w, xvect );
    
    subplot(2, 1, ii);
    plot( xvect, yw, xnod, zeros(1, n(ii)+1), 'o' );
    grid on;
    title( ['Polinomio nodale con n=', num2str( n(ii) )] );
    
end

%==========================================================================
% COMMENTO PERSONALE
%==========================================================================
%
% Grosse oscillazioni negli estremi, coerentemente non è interpolabile come
% visto in precedenza. 

%% Interpolazione con nodi NON equispaziati
% inserisco più nodi negli estremi per cercare di tenerlo sotto controllo

n = [ 10, 20 ];

for ii = 1: 2
    jj = 0: n(ii);
    x_hat = -cos( pi*jj / n(ii) );          % nodi non equispaziati
    % ricordiamo che la funzione cos(x) ha immagine in [-1,1], perciò
    % dobbiamo fare anche una conversione:
    xnod = (a+b)/2 + x_hat*(b-a)/2;         % trasformazione lineare
    x_vect = linspace( a, b, n(ii)+1 );     % nodi equispaziati
    subplot(2, 1, ii);
    plot( xnod, zeros(1, n(ii)+1), 'o', x_vect, zeros(1, n(ii)+1), 'x');
    title(['numero di nodi: ',num2str(n(ii)+1)]);
    legend('nodi non equispaziati', 'nodi equispaziati');
end

%% c) implementazione di interpolazione coi nodi di Chebyshev

n = [ 10, 20 ];

for ii = 1:2
    
    % costruisco nodi di Chebyshev
    x_hat = -cos( pi * (0:n(ii)) / n(ii) );
    xnod = ( a+b )/2 + x_hat * ( b-a )/2;
    
    % determino i punti y
    ynod = func( xnod );
    
    % determino polinomio di interpolazione
    p_fit = polyfit( xnod, ynod, n(ii) );
    
    % costruzione vettore punti equispazione
    xvect = linspace( a, b, 1e3 );
    
    % valutazione del polinomio P con xvect
    y_val = polyval( p_fit, xvect );
    
    % plot:
    subplot(2, 2, ii );
    plot( xvect, func(xvect), 'k', xvect, y_val, 'r' );
    grid on;
    hold on;
    
    % evidenza l'interpolante nei nodi di interpolazione
    plot( xnod, ynod, '*' );
    hold off
    title( ['Interpolazione polimoniale con n=', num2str( n(ii) )] );
    legend( 'funzione: f(x)', 'interpolante: \Pi_n f(x)', 'nodi di Chebyshev' );
    set( legend, 'Location', 'Best' );
    
    % errore
    err = norm( func(xvect)-y_val, inf );
    fprintf('(n = %d) Errore in norma del massimo: %g\n', n(ii), err);
    
    % polinomio nodale
    w = poly( xnod );
    yw = polyval( w, xvect );
    
    subplot(2, 2, 2+ii );
    plot( xvect, yw, xnod, zeros(1, n(ii)+1), 'o' );
    grid on;
    title( ['Polinomio nodale con n = ', num2str( n(ii) )] );
    
end

%==========================================================================
% COMMENTO PERSONALE
%==========================================================================
% Empiricamente, si può aspettare che col aumento del numero dei nodi di Chebyshev,
% l'errore riduce tendendo a 0. In realtà, già per n = [10, 20], MATLAB
% segnala che la matrice di Vandermonde è  mal condizionato, pertanto per n
% grandi è un lavoro quasi impossibile. Bisogna sempre bilanciare tra
% crescere del grado di n ed errore che verrà commesso.
