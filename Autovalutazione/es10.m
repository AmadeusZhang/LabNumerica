% Esercizio 10 - Interpolazione Polinomiale

% a) Enunciare il teorema di esistenza ed unicità del polinomio
% interpolatore Pn

%    Dati n+1 punti distinti x0,...,xn e n+1 corrispondenti valori
%    y0,...,yn esiste un unico polinomio Pn tale che Pn(xi) = yi per ogni
%    i=0,...,n

% b) Dimostrare il teorema di esistenza ed unicità del polinomio
% interpolatore Pn

%    esistenza:
%        Sia {li} una base per Pn, allora Pn ammette una rappresentazione
%        del tipo Pn(x)=SUM( bi*li(x) ) tale che
%               Pn(xi) = SUM( bjlj(xi) ) = yi,    i=0,...,n
%        definendo in particolare 
%            li(x) = PROD( (x-xj)/(xi-xj) ),    i=0,...,n
%        allora li(xj)=delta{i,j} quindi Pn(bi)=yi
%
%    unicità:
%        Per assurdo sia Qn(x) un altro polinomio interpolatore di {xi, yi}
%        tale che Qn(x) sia diverso da Pn(x).
%        Posto R = Pn(x)-Qn(x) si annullerebbe negli n+1 punti distinti xi,
%        quindi per il teorema fondamentale dell'Algebra, è identicamente
%        nullo. Segue Pn(x) = Qn(x), assurdo.
%
% c) Sia n = 3 e siano x0 = -1, x1 = 0, x2 = 1, x3 = 2.
%    Calcolare il polinomio caratteristico di Lagrange associato a nodo x3.
%
%    Il polinomio caratteristico di Lagrange è la parte di li(x), pertanto
%       l3(x) = w_4(x)/[(x-x3)*w'_4(x3)] = [x(x^2-1)/6]