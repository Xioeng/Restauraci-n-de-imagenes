function [b,c] = psfGauss( dim,s,p )
%%
% Genera un psf exponencial, con s una matriz en el caso 2x2. 
%En el caso matricial el coeficiente q no aplica.  
%Si s es un número y q no se especifica,  q se asumirá como 2. 
%Si la dimensión es un número se asume cuadrada
%%
if nargin<2|| nargin>3
    error('Faltan o sobran datos')
else 
end
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
%% 
%Caso simétrico
if size(s)==[1 1]
    if nargin==2
        p=2
    else
    end
[b,c] = psfGaussSym( dim,s,p );
else
 M=s;
lambda=eig(M);
v=(size(M)==[2 2]); v=v(1)*v(2);
if ( (M(1,1)<=0)|| ( M(2,2)<=0) ||( M(1,2)~=M(2,1))  || (lambda(1)<0) || (lambda(2)<0) ) || v~=1
    error('La matriz no es simétrica definida positiva o no tiene entradas  positivas')
else 
end
 M=inv(M);
for l=1:dim(1)
    for k=1:dim(2)
        z=1+[l-i, k-j]*M*[l-i, k-j]';
        b(l,k)= exp(-z);  
    end
end
s=sum(b(:));
b=(1/s)*b;
end
end


