function [x,u] = qssmultistep (a, b, xf, x0, u0, h, fun, dfun, toll, it_max)
%
%        [x,u] = qssmultistep (a, b, xf, x0, u0, h, fun, dfun, toll, it_max)
%
%	 Metodo multistep per la risoluzione di EDO
%
%	 Parametri di ingresso:
%	 (N.B.: tutti i vettori di ingresso DEVONO essere colonna!)
%	   a           vettore dei coeff. a_j (dim. p+1)
%      b           vettore dei coeff. b_j (dim. p+2)
%	               (se implicito, b(1) contiene b_(-1))
%      x0	       vettore degli istanti iniziali
%	   xf          estremo finale intervallo temporale di integrazione
%	   u0          vettore dei dati iniziali (dim. p+1)
%	   h           passo di integrazione
%	   fun, dfun   *stringhe* contenenti f(x,y) e df/dy 
%		       (usare il puntino, se necessario !)
%
%      N.B.:    fun, dfun in stringhe e variabile di x,y
%
%          SOLO SE IMPLICITO: 
%
%	   toll        tolleranza metodo di Newton
%	   it_max      numero max di iterazioni di Newton
%
%	 Parametri di uscita:
%	   x, u        vettori contenenti le coordinate dei nodi
%		       di discretizzazione e i valori di u_n 
%
y = u0; 
x = x0; 
f = eval(fun);
p = length(a) - 1;
u = u0;
nt = fix((xf - x0(1))/h);
for k = 1:(nt-p)
  lu = length(u);
  G = a' * u(lu:-1:lu-p)+ h * b(2:p+2)' * f(lu:-1:lu-p);
  lt = length(x0); 
  x0 = [x0; x0(lt)+h];
  x = x0(lt+1); 
% metodo implicito ==> Newton
  if (b(1) ~= 0),
    u_new = u(lu); 
    err = toll + 1; 
    it = 0;
    while (err >= toll) & (it <= it_max)
      y = u_new;
      den = 1 - h * b(1) * eval(dfun);
      f_new = eval(fun);
      if den == 0
        it = it_max + 1;
        fprintf('Annullamento del denominatore\n')
      else
        it = it + 1;
        u_new = u_new - (u_new - G - h * b(1) * f_new)/den;
        err = abs (u_new - y);
      end
    end
% metodo esplicito
  else  
    u_new = G;
    y = u_new;
    f_new = eval(fun);
  end 
  u = [u; u_new]; f = [f; f_new];
end   
x = x0;
