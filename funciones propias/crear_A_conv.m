function A=crear_A_conv(P, c, condicion)
%Crea la matriz A que la convolución para usar programación lineal. Trunca
%los valores de las matrices Ac_i Ar_i que son menores que 10^-12, así como
%los valores singulares menores a ese valor.

%P: Psf del tamaño de la imagen 
%c: Coordenadas del centro de la Psf
%condicion: Especifica la condición de frontera ('zero', 'periodic',
%'reflexive'). SI no se especifica será 'zero'.
% Autor: José Fuentes 
% Fecha: 2020/06/01
% Versión: 1.0
%%
if (nargin<2)|| (nargin>3)
    error('La cantidad de argumentos no corresponde');
else if nargin==2
        condicion='zero'
    else 
    end
end
%%
[U,S, V]=svd(P);
n=min([length(U) length(V)]);
A=sparse( length(U)*length(V), length(U)*length(V));
tol=10^(-12);
i=1;
%%
while (i<n+1)
    B=S(i,i)*U(:,i)*V(:,i)';
    [Ar,Ac]=kronDecomp(B,c,condicion);
    Ac=sparse(Ac.*(abs(Ac)>tol));
    Ar=sparse(Ar.*(abs(Ar)>tol));
    C=kron(Ar,Ac); 
    A=A+C;
    disp(i)
    if (i~=n)
        if ( S(i+1,i+1)/S(i,i) < power(tol,0.25) || S(i,i)<tol)
            break
        else
        end
    else if S(i,i) < sqrt(tol)
            break
        else
        end
    end
    i=i+1
end
%%
i=num2str(i);
disp(['La psf tiene rango ' i]) 
clearvars B C i
end
    