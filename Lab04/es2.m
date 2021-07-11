% Esercizio 2

A = [ 1001, 1000; 1000, 1001 ];

ee = eig(A);

kk = cond(A);

% A essendo sdp => k2 == kspettrale = rapporto tra max e min eig

%% pertubazione sul termine noto
b = [ 2001; 2001 ];
xex = A\b;

db = [ 1; 0 ];
xcap = A\(b+db);

dx = norm(xcap-xex)/norm(xex);      % 0.5

% si evince che una piccola pertubazione sul termine noto (di un millesimo)
% induce una pertubazione di 50% sulla soluzione, pertanto è
% mal-condizionato.

stima = kk*norm(db)/norm(b);

disp("diff norm vs stima"), dx, stima

% si osserva inoltre che questo risultato è in accordo con la stima.

%% pertubazione sul termine noto
b = [ 2001; -2001 ];
xex = A\b;
db = [ 1; 0 ];
xcap = A\(b+db);
dx = norm(xcap-xex)/norm(xex);      % 2.4988e-04

% in questo la pertubazione della soluzione è molto piccola, nonostante il
% caso è mal condizionato, ciò comunque è in accordo con la stima.

stima = kk*norm(db)/norm(b);

disp("diff norm vs stima"), dx, stima

% che però da ricordarsi che si tratta di una "disuguaglianza"

%% pertubazione su vettore x
xx = [ 2001; -2001 ];
dx = [ 1; 0 ];
bb = A*(xx+dx);

db = norm(A*xx - A*(xx+dx))/norm(A*xx);

% si nota che una pertubazione sulla soluzione viene amplificata nel
% calcolo del termine noto
