nn = 1:10;
%% inizializzo una matrice di Hilbert generico di ordine n
kk = zeros(1,10);

for s = nn
    A = zeros(s);
    % hilb(A)
    for r = 1:s
        for c = 1:s
            A(r,c) = 1/(r+c-1);
        end
    end

    % numero di condizionamento
    k2 = norm(A)*norm(A^(-1));      % questa sarebbe la definizione di norma;
                                    % posso anche utilizzare la funzione
                                    % built-in ovvero cond(A);
    kk(s) = k2;
end

%% grafico semi-logaritmica
semilogy(nn,kk,'-*r')
grid on, xlabel('n')

%% errore relativo
err = zeros(1,10);
KA = zeros(1,10);
for s = nn
    A = hilb(s);
    KA(s) = cond(A);
    xex = ones(s,1);    % vettore colonna
    
    b = A*xex;
    x = A\b;
    err(s) = norm(x-xex)/norm(xex);
    
end

semilogy(nn, KA, '-*r', nn, err, 'b-s')
grid on, xlabel('n'), legend('k_2(A_n)','err_n')

%% residuo
err = zeros(1,10);
KA = zeros(1,10);
res = zeros(1,10);
stima = zeros(1,10);
for s = nn
    A = hilb(s);
    KA(s) = cond(A);
    xex = ones(s,1);
    b = A*xex;
    x = A\b;
    err(s) = norm(x-xex)/norm(xex);
    res(s) = norm(A*x-b)/norm(b);
    stima(s) = KA(s)*res(s);
end

figure;
semilogy(nn,KA,'-*r','DisplayName','cond');
hold on;
semilogy(nn,err,'-ob','DisplayName','err-rel');
semilogy(nn,res,'-^k','DisplayName','res-norm');
semilogy(nn,stima,'-sg','DisplayName','stima');
grid;
xlabel('n');
legend show

    
