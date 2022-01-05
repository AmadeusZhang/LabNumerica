% Implementazione del metodo di Trapezio Composito

function I = es5_trapcomp( a, b, N, f )

% ampiezza degli sottointervalli
H = (b-a)/N;

% xvect = linspace( a, b, N ); --> NO, non sono uguali
xvect = a: H: b;
yvect = f( xvect );

I = H * ( (1/2)*yvect(1) + sum( yvect(2: N) ) + (1/2)*yvect(N+1) );

end

% I_{1,m} = H * {1/2f(x0)+f(x1)+...+f(xm-1)+1/2f(xm)};