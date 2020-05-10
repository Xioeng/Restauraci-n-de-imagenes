function [ H V ] = derivada( tam, cond )
%DERIVADA Genera las matrices derivada en el eje x e y (H V)
%   genera esto con la aproximacion f'(x_i)=f(x_i)-f(x_i-1). Necesita el
%   tamaño de la imagen y la condición de frontera
h=[ 0 0 0; -1 1 0; 0 0 0];
H=Psfaj(h,tam);
[B A]=kronDecomp(H,[2,2],cond);
B=sparse(B.*(abs(B)>10^(-6)) ); A=sparse(A.*(abs(A)>10^(-6)) ); 
H=kron(B,A);
v=[ 0 -1 0; 0 1 0; 0 0 0];
V=Psfaj(v,tam);
[B A]=kronDecomp(V,[2,2],cond);
B=sparse(B.*(abs(B)>10^(-6)) ); A=sparse(A.*(abs(A)>10^(-6)) ); 
V=kron(B,A);
end

