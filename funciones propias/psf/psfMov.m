function [P,c] = psfMov(dim,a)
%  Crea una psf de movimiento a 'a' grados.
%Datos de entrada: a: ángulo, dim: dimensiones.
%Datos de salida: P: la psf, c: su centro.
% Autor: José Fuentes 
% Fecha: 2020/06/01
% Versión: 1.0
%%
A=zeros(dim);
c=floor(dim/2)+1;
for j=0:c-1
A(c+j,c+j)=1;
end
A=imrotate(A,a+45,'crop');
P=A/sum(A(:));
clearvars A
c=[c,c];
end

