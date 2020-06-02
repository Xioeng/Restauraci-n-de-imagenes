function [ H V ] = derivada( tam, cond )
%DERIVADA Genera las matrices derivada en el eje x e y (H V)
%   genera esto con la aproximacion f'(x_i)=f(x_i)-f(x_i-1). Necesita el
%   tama�o de la imagen y la condici�n de frontera
%Datos de entrada: tam: tama�o de la imagen, cond: condici�n de frontera.
%('zero', 'periodic', 'reflexive')
%Datos de salida: Matrices H y V que representan las derivadas.
% Autor: Jos� Fuentes 
% Fecha: 2020/06/01
% Versi�n: 1.0
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

