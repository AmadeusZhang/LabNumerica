% Implementazione del metodo di Runge-Kutta a 2 stadi

function [ th, uh ] = RK2( f, t_0, t_max, y0, h )

%==========================================================================
% PARAMETRI DI INGRESSO:
%   f       funzione a 2 variabili, function handle @(t,y)
%   t_0, t_max      estremi dell'intervallo di definizione
%   y0      dat0 iniziale
%   h       passo di avanzamento
%
% PARAMETRI DI USCITA:
%   th      vettore degli istanti temporali
%   uh      vettore della soluzione approssimata
%==========================================================================

% creare vettore temporale ad passo h --> :
th = t_0: h: t_max;

% lunghezza vettore
N = length(th);

% impostazione problema
uh = zeros(1, N);
uh(1) = y0;

% ciclo for:
for ii = 1: N-1
    fn = f( th(ii), uh(ii) );       % evito di richiamarlo più volte
    u_star = uh(ii) + h * fn;       % variabile ausiliario
    uh(ii+1) = uh(ii) + (h/2) * ( fn + f( th(ii+1), u_star ) );
end

end