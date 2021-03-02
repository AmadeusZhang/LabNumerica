%% Inizializzazione matrici

A = [
    50  1   3
    1   6   0
    3   0   1
];

B = [
    50  1   10
    3   20  1
    10  4   70
];

C = [
    7   8   9
    5   4   3
    1   2   6
];

%% condizioni LU

%% matrice C - situazione generale: CNS
n = length(C);
i = 1; dc = 1;

while ( (i<=n) && (dc~=0) )
    dc = det( C(1:i, 1:i) );
    i = i+1;
end
    
if dc == 0
    disp('Non fattorizzabile')
else
    disp('Fattorizzabile')
end

%% matrice B - metodo del dominanza diagonale: CN
dd = diag(B)';
sumB = sum(B,1)-dd;

if dd > sumB
    disp('Fattorizzabile')
else
    disp('Non fattorizzabile')
end
    

%% matrice A - criterio di Sylvester (matrice sdp)
if A == A'
    disp('[OK] check: simmetria');
    for i = 1: length(A)
        if ( det( A([1:i], [1:i]) ) > 0 )
            if ( i == length(A) )
                disp('[OK] criterio di Sylvester: fattorizzabile')
            end
        else
            error('[FAILED] criterio di Sylvester non applicabile');
        end
    end
            
else
    error('[FAILED] check: simmetria');
end

%% fattorizzazione LU

[La, Ua] = lu(A);
[Lb, Ub] = lu(B);
[Lc, Uc] = lu(C);

%% soluzione esatta

xex = ones(3, 1);

b = A*xex;

y = fwsub(La, b);

x = bksub(Ua, y);
