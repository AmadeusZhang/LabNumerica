% Esercizio 3 Laboratorio 14

clear; close all; clc

%% metodo a più passi lineare

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