% Esercizio 9

f = @(x) 2 + (x-3) .* sin( 5 .* (x-3) );
a = 0;
b = 6;
n = 500;
xvect = linspace(a, b, n);
figure
plot(xvect, f(xvect), 'LineWidth', 3)

%% retta delimitante
r1 = @(x) 2+(x-3);
r2 = @(x) 2-(x-3);
hold on
plot(xvect, r1(xvect), xvect, r2(xvect), 'LineWidth', 3);


%% legenda
title('Funzione Sin')
xlabel('ascisse')
ylabel('ordinate')
legend('f(x)','r1','r2')