% Esercizio 1 Laboratorio 11

clear; clc;

%% a) calcolo i pesi

% x0 = - sqrt(3/5);
% 
% x1 = 0;
% 
% x2 = sqrt(3/5);
% 
% M = [
%       1       1       1;
%      x0      x1      x2;
%     x0^2    x1^2    x2^2
% ];

% scritta abbreviata
xnod = [ -sqrt(3/5)   0   sqrt(3/5) ];
A = [ xnod.^0;  xnod.^1;    xnod.^2 ];          % simile alla matrice di Vandermonde

b = [ 2; 0; 2/3 ];

% pesi
wn = A\b;

%% b) trasformazione lineare
xtilde = 1/2 * xnod + 1/2;
wtilde = 1/2 * wn;      % !! ricordarsi da trasformarsi anche i pesi

%% c) approssimazione dell'integrale con la formula di Gauss
n = 2;

% definire le funzioni da integrare
f = @(t) 1 ./ (t+2);
g = @(t) sqrt(t);   

% applicare la formula di quadratura --> sommatoria
Igl_f = sum( wtilde .* f( xtilde )' );      % ATTENZIONE ALLA DIMENSIONE
Igl_g = sum( wtilde .* g( xtilde )' );

% calcolo integrale esatto ( by heart! )
Iex_f = log(3/2);
Iex_g = 2/3;

% calcolo errore nell'approssimazione
err_f = norm( Iex_f - Igl_f );
err_g = norm( Iex_g - Igl_g );

fprintf("errore nell'integrazione di f: %g\n", err_f);
fprintf("errore nell'integrazione di g: %g\n", err_g);

%==========================================================================
% COMMENTO
%==========================================================================
% Prima di eseguire il code, aspetto di trovare g è quello mal approssimato,
% in quanto la funzione g non è C1 (non è definito per x=0 la sua derivata);
% Infatti i risultati numerici contestano questa previsione
% err_f ~ 1e-7  vs  err_g ~ 1e-3
%==========================================================================

%% d) formula di quadratura gaussiana
a = 0; b = 1;

% funzioni da integrare
f = @(t) 1./(t+2);
g = @(t) sqrt(t);

% integrali esatti
Iex_f = log(3/2);
Iex_g = 2/3;

% creazione vettori nulli per errori
err_f = zeros(1,7);
err_g = zeros(1,7);

% approssimazione degli integrali
for n = 1:7
    % chiamo function lgwt per ottenere nodi di integrazione e pesi
    [xn, wn] = lgwt( n+1, a, b );
    
    % calcolo integrale approssimato
    Igl_f = sum( wn .* f(xn) );
    Igl_g = sum( wn .* g(xn) );
    
    % calcolo errore
    err_f(n) = abs( Iex_f - Igl_f );
    err_g(n) = abs( Iex_g - Igl_g );
    
end

% plot dell'andamento degli errori
semilogy( 1: n, err_f, '-*', 1: n, err_g, '-o', 'LineWidth', 1 );
legend( 'err_f', 'err_g' );
grid on;

%==========================================================================
% COMMENTO (teorema sul grado di esattezza)
%==========================================================================
% f abbatte velocemente errore: essendo C^inf la sua convergenza è
% esponenziale, con 8 nodi si ottiene una accuratezza dell'epsilon macchina.
%
% g essendo una funzione non regolare, suo errore relativo decresce lentalmente.
%==========================================================================

%% e) metodo dei trapezi
hold on;            % confronto col es. precedente

err_trap_f = zeros(1,7);
err_trap_g = zeros(1,7);
for n = 1: 7
    Itrap_f = trapcomp( a, b, n, f );
    Itrap_g = trapcomp( a, b, n, g );
    
    % calcolo errore
    err_trap_f(n) = abs( Iex_f - Itrap_f );
    err_trap_g(n) = abs( Iex_g - Itrap_g );
end

semilogy( 1:n, err_trap_f, 1:n, err_trap_g, 'LineWidth', 1 );
legend( 'err_f', 'err_g', 'err_{trap, f}', 'err_{trap,g}' );
xlabel( 'err: grado n; trap: N sottointervalli' );

%==========================================================================
% COMMENTO
%==========================================================================
% Per quanto riguarda la funzione f:
% il metodo del trapezio converge molto lentamente rispetto alla formula di
% quadratura gaussiana.
% Per quanto riguarda la funzione g:
% la diff. nella velocità di convergenza non è cosi notevole, in quanto g è
% continua e non derivabile nll'intervallo di integrazione.
%==========================================================================

%% f) Stima dell'errore del metodo del Trapezio
% tolleranza e max(f'') (valori calcolati a mano)
tol = 1e-6;
xi = 1/4;

% calcolo passo
H = sqrt( 12*tol/xi );

% calcolo numero minimo di intervalli
N = ceil(1/H);                  % approssimazione ad intero per eccesso

% calcolo errore
I_trap_f = trapcomp( a, b, N, f );
error_trap_f = abs( Iex - I_trap_f );

fprintf("errore per %d sottointervalli: %g\n", N, error_trap_f);

%==========================================================================
% COMMENTO
%==========================================================================
% N = 145: il metodo del trapezio ha bisogno del 145 sotto-intervalli per
% raggiungere alla tolleranza di 1e-6, tale valore è soddisfatto per n=2
% della formula gaussiana.

% N.B.: grado n e numero di sottointervalli N sono due concetti diversi.
%==========================================================================
% funzione g invece non posso applicare la stima, in quanto esso non
% è regolare quindi non abbiamo modo per calcolare la N.
%==========================================================================