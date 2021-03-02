% Esercizio 2

n = 15;
I = zeros(n);

for ii = 1:n
    for jj = 1:n
        if ( mod((ii+jj),2) == 0 )
            I(ii,jj)=0;
        else
            I(ii,jj)=1;
        end
    end
end
