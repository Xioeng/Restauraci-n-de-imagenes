function [ b,c ] = psfMoffat( dim , M, beta )
%  Crea el difuminado atmosferico escalado
%Dim: contiene las dimensiones de la psf; el centro es el centro del
%arreglo. Se puede poner un número, eneste caso la psf es cuadrada
%M: Es una matriz dos por dos indicando la dirección del degradado o un
%número que indica que es simétrica con esa varianza.
%Beta: coeficiente de decaimiento
%Datos de salida: b: la psf, c: su centro.
% Autor: José Fuentes 
% Fecha: 2020/06/01
% Versión: 1.0
%%
if  length(dim)==1
    dim=[dim dim];
else if  length(dim)>2
           error('las  dimensiones no son adecuadas')
    else
    end
end
b=zeros(dim(1),dim(2));
i=1+floor((dim(1))/2); j=1+floor((dim(2))/2);
c=[i,j];
lambda=eig(M);
if ( (M(1,1)<=0)|| ( M(2,2)<=0) ||( M(1,2)~=M(2,1))  || (lambda(1)<0) || (lambda(2)<0) )
    error('La matriz no es simétrica definida positiva o no tiene entradas  positivas')
else 
end
if length(M)==1
    M=[M^2 0; 0 M^2]
else  if  length(M)>2
         error('la matriz no tiene las dimensiones adecuadas')
    else
    end
end
  %%      
  M=inv(M);
for l=1:dim(1)
    for k=1:dim(2)
        z=1+[l-i, k-j]*M*[l-i, k-j]';
        b(l,k)=  power(z,-beta);  
    end
end
s=sum(b(:));
b=(1/s)*b;

end


