function [xvect,xdif,fx,it]=qssbisez(a,b,nmax,toll,fun)
%
%  [xvect,xdif,fx,it]=qssbisez(a,b,nmax,toll,fun) 
%
%  Metodo di bisezione per la risoluzione
%  dell'equazione non lineare f(x)=0
%
%  Parametri di ingresso:
%
%  a,b       Estremi intervallo di ricerca radice
%  nmax      Numero massimo di iterazioni
%  toll      Tolleranza sul test d'arresto
%  fun       Macro contenente la funzione
%
%  Parametri di uscita:
%
%  xvect     Vett. contenente tutte le iterate
%            calcolate (l'ultima componente e' la soluzione)
%  xdif      Vett. contenente l'avanzamento tra due iterate
%  fx        Vett. contenente le valutazioni di 'fun' in 'xvect'
%  it        Iterazioni effettuate
%
err=1; 
it=0; 
xvect=[]; 
fx=[]; 
xdif=[];
while (it < nmax & err > toll)
    c=(a+b)/2; 
    x=c; 
    fc=eval(fun); 
    xvect=[xvect;x]; 
    fx=[fx;fc]; 
    x=a; 
    if (fc == 0)
       err=0;
    else
       if (fc*eval(fun) > 0), 
          a=c; 
       else, 
          b=c; 
       end; 
       err=abs(b-a)/2; 
    end
    xdif=[xdif;err];
    it=it+1;
end; 
%
fprintf(' \n Numero di Iterazioni : %d \n',it);
fprintf(' Radice calcolata     : %12.8f \n',xvect(it));
%
return
