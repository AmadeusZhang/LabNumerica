% Esercizio 3 Laboratorio 14

clear; close all; clc

%% a) studiare consistenza e ordine del metodo a più passi lineare

a = [ 18; -9; 2 ]/11;

b = [ 6; 0; 0; 0; ]/11;

% facendo calcoli s'ottiene che il metodo è consistente di ordine almeno 1:
if sum(a) == 1
    partialSum_a = 0;
    for ii = 0: length(a)-1
        temp = ii * a(ii+1);
        partialSum_a = partialSum_a + temp;
    end
    if ( -partialSum_a + sum(b) == 1 )
        disp('metodo è consistente');
    end
else
    disp('metodo non è consistente');
end

% verifica per ordine superiore:        i = 2, ..., q
iter = 2; 

% ciclo while:
flag = 1;
while flag
    
    % somme parziali a
    partialSum_a = 0;
    for ii = 0: length(a)-1
        temp = (-ii)^iter * a(ii+1);
        partialSum_a = partialSum_a + temp;
    end     % breakpoint test passed
    
    % somme parziali b
    partialSum_b = 0;
    for ii = -1: length(b)-2
        temp = (-ii)^(iter-1) * b(ii+2);        % MATLAB parte da indice 1
        partialSum_b = partialSum_b + temp;
    end
    
    % somme totali
    sum = partialSum_a + iter * partialSum_b;
    tol = 1e-15;        % tolleranza
    if sum-1 < tol
        iter = iter+1;
    else
        flag = 0;
        
    end
    
end

fprintf("il metodo è di ordine %d\n", iter-1);

%% b) determinare regione di assoluta stabilità --> qssstabreg
xmi = -2; xma = 8;
ymi = -4; yma = 4;
xpti = 1e2; ypti = 1e2;

% plot:
figure();
qssstabreg( a, b, xmi, xma, ymi, yma, xpti, ypti );
grid on;

%% c) assoluta stabilità di un problema di Cauchy --> qssmultistep
% sol. esatta
f_ex = 'exp(-x.^3)';

% problema posto
f = '-3 * (x.^2) .* y';
df = '-3 * (x.^2)';

% passi temporali
H = [ 1/100 1 ];

% impostazione per qssmultistep
h = H(1);
x0 = [ 0; h; 2*h ];     xf = 10;
y0 = exp(-x0.^3);
toll = 1e-6;    it_max = 50;

% qssmultistep:
[ x, un ] = qssmultistep( a, b, xf, x0, y0, h, f, df, toll, it_max );

% confronto con la sol. esatta:
figure();
plot( x, un, ':*', x, eval(f_ex), 'k--' );
legend('uh','y_{ex}');