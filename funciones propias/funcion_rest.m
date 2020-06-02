function [f]= funcion_rest(A, b ,  x , Real)
%  Realiza y compara la restauración de una imagen A con la imagen real
%Datos de entrada: Matriz que representa la convolución A, imagen borrosa
%vectorizada b, x=[alpha, gamma] factores de regularizacion, Real imagen
%real
%Datos de salida: error relativo en porcentaje
% Autor: José Fuentes 
% Fecha: 2020/06/01
% Versión: 1.0
%%
Alpha=x(1); Gamma=x(2);
n=length(b);
[ H V ] = derivada(size(Real),'reflexive' );
caja=255*ones(7*n,1)';
K=sparse(3*n,7*n);
Id=sparse([1:n],[1:n],ones(n,1));
K(1:3*n,1:n)=[A;H;V];
K(1:n,n+1:3*n)=[-Id Id];
K(n+1:2*n,3*n+1:5*n)=[-Id Id];
K(2*n+1:3*n,5*n+1:7*n)=[-Id Id];
%factores de regularizacion. Alpha para la norma y gamma para la derivada
resa=0.25;
c=[Alpha*ones(1,n)  ones(1,2*n)  Gamma* ones(1,4*n)];
%beta es el vector de igualdades
beta=[b' zeros(1,2*n)];
%liberando memoria 
clear A Ac Ar

%options = optimoptions('linprog','Display','Iter','Algorithm','interior-point','TolFun',1e-6)
[x,e,f,g]=linprog( c ,[ ],[ ],  K, beta , zeros(7*n,1)' ,caja, []);

restauracion=x(1:n);
f=100*sum(abs(restauracion-Real(:)))/sum(abs(Real(:)));
end