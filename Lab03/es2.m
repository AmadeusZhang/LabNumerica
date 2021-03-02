% Lab3 Es2

%% verificare la banda della matrice

B = bucky;

spy(B)

%% fattorizzazione LU di B
[L,U,P] = lu(B);

% figure
% spy(L)
% title('L')
% 
% figure
% spy(U)
% title('U')
% 
% figure
% spy(P)
% title('P')      % P != I quindi fattorizzazione con pivoting

subplot(2,2,1), spy(L), title('L')
subplot(2,2,2), spy(U), title('U')
subplot(2,2,3), spy(P), title('P')
subplot(2,2,4), spy(B), title('B')

