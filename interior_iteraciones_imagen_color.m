% Algoritmo aplicado a una imagen de color. Ejemplo de la restauración de cada canal de color de
%la imagen 'colibri.jpg'. Este script es autocontenido por lo que no
%requiere argumentos de entrada. **No obstante, se puede cambiar la imagen en
%la cuarta linea y su tamaño en la quinta. Al final proyecta la imagen
%real, la restaurada y la borrosa.
% 
%  Datos de Entrada: Ninguno
% Datos de Salida: Imagenes real, borrosa, restauradas por los diferentes
% coeficientes, una tabla con resultados cuantitativos y un archivo .mat con los
% resultados guardados.
% Autor: José Fuentes 
% Fecha: 2020/06/01
% Versión: 1.0
%%
addpath(genpath('funciones propias'))
addpath(genpath('restauracion'))
addpath(genpath('imagenes-prueba'))


Ima=imread('colibri.jpg');  %poner imagen
Ima=imresize(Ima,0.55); %Tamaño de la imagen
R=[];
parfor j=1:3
Im=double(Ima(:,:,j));
porcentaje=0.5; %porcentaje de error
Alpha=1*10^(-2); Gamma=4.5*10^(-2);
%%
%eligiendo la psf
[p,c]=psfMov(31,90);
p=Psfaj(p,size(Im));
%hacer función para psf
A=crear_A_conv(p,c,'reflexive');


%%
%creando la imagen borrosa
b=A*Im(:);
E=randn(length(b),1); E=E/(sum(abs(E))); E=(porcentaje/100)*sum(abs(Im(:)))*E;
b=b+E;
B(:,:,j)=reshape(b,size(Im));
%imagesc(B)
%%
%Matrices previas para el modelo de LP
n=length(b);
[ H V ] = derivada(size(Im),'reflexive' );
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
%%
%sacando las imágenes
for i=-1: 24
 Re=[];
tic
options = optimoptions('linprog','Display','iter','Algorithm','interior-point','ConstraintTolerance',2^(-i+1),'TolFun',2^(-i),'MaxIterations',80);
[x,e,f,g,h]=linprog( c ,[ ],[ ],  K, beta , zeros(7*n,1)' ,caja, [],options);
toc
%ensamble de la solución

X=x(1:n);
Re(:,:,i+2)=reshape(X,size(Im));
end
R(:, :, j ,:)=Re ;
end
figure 
imshow(Im,[])
figure 
imshow(R,[])
figure 
imshow(B,[])