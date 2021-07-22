% Esercizio 1 Laboratorio 12

clear; close all; clc

%% a) implementazione del metodo di Eulero in Avanti

f = @(t,y) -2 * t .* y;

% DOMANDA: perché non abbiamo usato il prodotto vettoriale (.*)? bensì il
% prodotto puntata (*)?
% SPIEGAZIONE: in questo caso particolare non è necessario perché la
% funzione eulero in avanti lavora con gli scalari. Questa scrittura ha
% però dei limiti.

t_0 = 0; t_max = 3;

y0 = -2;

%% b) soluzione del metodo di Eulero Avanti

% plot sol. esatta per confronto
figure(); 
xvect = linspace( t_0, t_max, 1e3 );
yvect = -2 * exp(- xvect.^2);                   % sol. esatta
plot( xvect, yvect, 'k--', 'LineWidth', 1 );
hold on; grid on;

% errore di approssimazione
err = zeros(1, 2);

% risoluzione problema di Cauchy
hvect = [ 3/6 3/20 ];
for ii = 1: 2
    [ th, uh ] = eulero_avanti( f, t_0, t_max, y0, hvect(ii) );
    yvect = -2 * exp(- th.^2);                  % ridimensionamento di y
    err( ii ) = norm( uh-yvect, inf );
    plot( th, uh );
end

% legenda e assi
title('metodo del Eulero Avanti');
legend( 'sol. esatta', 'h = 3/6', 'h = 3/20' );
xlabel( 't' );
ylabel( 'uh' );

% errore:
disp('metodo del Eulero in Avanti:');
for ii = 1:2
    fprintf(">> per h = %g, errore nell'approssimazione è: %g \n", hvect(ii), err(ii));
end

%% c) implementazione del metodo di Eulero Indietro

% f(t,y) = a(t)y + b(t)
a = @(t) -2 * t ; 
b = @(t) 0;

%% d) risoluzione del problema di Cauchy col metodo di Eulero Indietro
% plot sol. esatta per confronto
figure(); 
xvect = linspace( t_0, t_max, 1e3 );
yvect = -2 * exp(- xvect.^2);                   % sol. esatta
plot( xvect, yvect, 'k--', 'LineWidth', 1 );
hold on; grid on;

% errore di approssimazione
err = zeros(1, 2);

% risoluzione problema di Cauchy
hvect = [ 3/6 3/20 ];
for ii = 1: 2
    [ th, uh ] = eulero_indietro( a, b, t_0, t_max, y0, hvect(ii) );
    yvect = -2 * exp(- th.^2);                  % ridimensionamento di y
    err( ii ) = norm( uh-yvect, inf );
    plot( th, uh );
end

% legenda e assi
title('metodo del Eulero Indietro');
legend( 'sol. esatta', 'h = 3/6', 'h = 3/20' );
xlabel( 't' );
ylabel( 'uh' );

% errore:
disp('metodo del Eulero Indietro:');
for ii = 1:2
    fprintf(">> per h = %g, errore nell'approssimazione è: %g \n", hvect(ii), err(ii));
end

%==========================================================================
% COMMENTO
%==========================================================================
% A quanto pare metodo del Eulero Indietro converga più rapidamente rispetto
% al Eulero Avanti, ma come sappiamo dalla teoria, convergono alla stessa
% velocità; Però una differenza per h grande c'è, infatti osservando errore
% del E.A. per h=0.5: 0.442398, mentre errore del E.I. per h=0.5: 0.224268,
% quasi dimezzato.

%% e) andamento dell'errore

% calcolare il vettore dei passi temporali H (potenze di 2)
H = 2 .^ -(2:6);
N = length(H);

% creare vettori errore
err_ea = zeros(1,N);
err_ei = zeros(1,N);

% valore esatto --> function handle
y_ex = @(t) - 2 * exp( - t .^ 2 );
 
% per implementazione dei parametri di ingresso di EA EI richiamare i
% blocchi precedenti in particolare a) e c)

% ciclo for per diversi valori di H per risoluzione del problema
for ii = 1: N
    % calcolo soluzioni col metodo di Eulero Avanti/Indietro
    [ th_ea, uh_ea ] = eulero_avanti( f, t_0, t_max, y0, H(ii) );
    [ th_ei, uh_ei ] = eulero_indietro( a, b, t_0, t_max, y0, H(ii) );
    
    % calcolare l'errore
    err_ea(ii) = norm( uh_ea - y_ex(th_ea), inf );
    err_ei(ii) = norm( uh_ei - y_ex(th_ei), inf );
    
end

% plot in scala logaritmica
loglog( H, err_ea, H, err_ei, H, H, '--', H, H.^2, '--' );
title('Andamento degli errori');
legend( 'err_{EA}', 'err_{EI}', 'ref: H', 'ref: H^2' );
xlabel( 'passi di discretizzazione: H' );   % leggere da dx a sx
ylabel( 'errore' );
grid on;

%==========================================================================
% COMMENTO
%==========================================================================
% 1. Errori decrescono al decrescere di H, quindi convergono.
% 2. Gli errori si prensentano come una retta, pertanto hanno un andamento
%    logaritmica.
% 3. Rette di errori hanno una pendenza simile ad H^1 => convergenza ord. 1
% 4. Le rette di errori si differiscono solo all'inizio (come abbiamo
%    osservato in precedenza), poi convergono alla stessa velocità (H^1).