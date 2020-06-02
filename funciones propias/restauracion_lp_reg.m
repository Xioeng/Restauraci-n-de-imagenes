function R=restauracion_lp_reg(B,psf,c, Alpha, Gamma)
%%
%realiza la restauración teniendo en cuenta los parámetros de regularización
%Datos de entrada: B es la imagen borrosa,  psf es la PSF,c su centro.
%Factores de regularizacion: Alpha para la norma y Gamma para la derivada.
%Datos de salida: Imagen restaurada R
% Autor: José Fuentes 
% Fecha: 2020/06/01
% Versión: 1.0
%%
%Descomposición de la PSF
A=crear_A_conv(psf, c, 'reflexive');
b=B(:);  n=length(b);
%%
%Matrices previas para el modelo de LP
[ H V ] = derivada(size(B),'reflexive' );
caja=255*ones(7*n,1)';
K=sparse(3*n,7*n);
Id=sparse([1:n],[1:n],ones(n,1));
K(1:3*n,1:n)=[A;H;V];
K(1:n,n+1:3*n)=[-Id Id];
K(n+1:2*n,3*n+1:5*n)=[-Id Id];
K(2*n+1:3*n,5*n+1:7*n)=[-Id Id];

%vectores costo y constante
c=[Alpha*ones(1,n)  ones(1,2*n)  Gamma* ones(1,4*n)];
%beta es el vector de igualdades
beta=[b' zeros(1,2*n)];

%liberando memoria 
clear A Ac Ar
%%
%Programación lineal
tic
options = optimoptions('linprog','Display','Iter','Algorithm','interior-point','TolFun',1e-6)
[x,e,f,g]=linprog( c ,[ ],[ ],  K, beta , zeros(7*n,1)' ,caja, [],options);
toc
%%
%Ensamble de la solución
X=x(1:n);
R=reshape(X,size(B));
end
