hh = zeros(1,4);
nRef = zeros(1,4);
for ii = 2:5
    nRef(ii) = ii;
    hh(ii) = pi ./ (2.^nRef(ii));
    [errors,solutions,femregion,Dati, K2A(ii)]=es3_main1D('Test1',nRef(ii));
end

% log log plot
figure
loglog(hh, K2A, '+-', 'LineWidth', 2)
hold on
loglog(hh, hh.^(-1),'k--','LineWidth',2)
loglog(hh, hh.^(-2),'r:','LineWidth',2)
loglog(hh, hh.^(-3),'g-.','LineWidth',2)
hold off
xlabel('h');
legend('K_2(A)',('h^(-1)'),('h^(-2)'),('h^(-3)'));

% osservando che l'andamento di K2(A) è parellelo alla retta di h^(-2),
% possiamo concludere che il valore dell'esponente è a=2 in particolare
%                       k2(A) = h^(-2)+c