% Esercizio 8
T1=[
1
2
3
4
5
6
7
8
];

T2=[
0.00
0.06
0.14
0.25
0.31
0.47
0.60
0.70
];

T3=[
0.00
0.08
0.14
0.20
0.23
0.25
0.28
0.29
];

figure();
plot(T2, T3)

% inserisco titolo e nome degli assi
title('Grafico Sforzo-Deformazione')
xlabel('Sforzo \sigma')
ylabel('Deformazione \epsilon')