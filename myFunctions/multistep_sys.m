function [t,u] = multistep_sys (a, b, tf, t0, u0, h, fun, jacfun)
%
%        [t,u] = multistep_sys (a, b, tf, t0, u0, h, fun, jacfun)
%
%	 Metodo multistep per la risoluzione di sistemi di EDO
%
%	 Parametri di ingresso:
%	   a             vettore (colonna) dei coeff. a_j (dim. p+1)
%      b             vettore (colonna) dei coeff. b_j (dim. p+2)
%	                 (se implicito, b(1) contiene b_(-1))
%      t0	         vettore (riga) degli istanti iniziali
%	   tf            estremo finale intervallo temporale di integrazione
%	   u0            matrice dei dati iniziali (dim. p+1):
%                    una riga per ogni componente del sistema
%	   h             passo di integrazione
%	   fun, jacfun   function handle contenenti f(t,y) e df/dy 
% 
%	 Parametri di uscita:
%	   t, u        vettore e matrice contenenti le coordinate dei nodi
%		           di discretizzazione e i valori di u_n 
%
y = u0; 
t = t0; 
f = fun(t0,u0(:,1));
for i = 2:length(t0)
    f = [f, fun(t0, u0(:,i))];
end
p = length(a) - 1;
u = u0;
nt = fix((tf - t0(1))/h);
for k = 1:(nt-p)
  lu = size(u,2);
  G = u(:,lu:-1:lu-p) * a + h * f(:,lu:-1:lu-p)* b(2:p+2);
  lt = length(t0); 
  t0 = [t0, t0(lt)+h];
  t = t0(lt+1); 
% metodo implicito ==> Newton
  if (b(1) ~= 0)
    u_new = u(:,lu); 
    err = toll + 1; 
    it = 0;
    while (err >= toll) && (it <= it_max)
      y = u_new;
      jac = eye(length(y)) - h * b(1) * jacfun(t,y);
      f_new = fun(t,y);
      if det(jac) == 0
        it = it_max + 1;
        fprintf('Jacobiana singolare\n')
      else
        it = it + 1;
        u_new = u_new - jac \ (u_new - G - h * b(1) * f_new);
        err = norm (u_new - y);
      end
    end
% metodo esplicito
  else  
    u_new = G;
    y = u_new;
    f_new = fun(t,y);
  end 
  u = [u, u_new]; f = [f, f_new];
end   
t = t0;
