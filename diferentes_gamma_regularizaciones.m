% Algoritmo para hacer varias restauraciones con diferentes constantes
% Gamma de regularización indicados en el arreglo 'intervalo'
%%
addpath(genpath('funciones propias'))
%addpath(genpath('restauracion'))
addpath(genpath('imagenes-prueba'))

porcentaje=0.5; %porcentaje de error
Ima=imread('colibri.jpg');  %poner imagen
Ima=imresize(Ima,[220,330]);
%eligiendo la psf 
% Se pueden escoger psfGauss (exponencial), psfMoffat (turbulencia), psfMov (Movimiento)
[p,c]=psfMov(31,90);
intervalo=linspace(10^(-5),1,20);

R=[];
for j=1:3
Im=double(Ima(:,:,j));
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

 Re=[];
parfor i=1:length(intervalo)
Alpha=0*1*10^(-2); Gamma=intervalo(i);
%vectores costo y constante
c=[Alpha*ones(1,n)  ones(1,2*n)  Gamma* ones(1,4*n)];
%beta es el vector de igualdades
beta=[b' zeros(1,2*n)];

%sacando las imágenes
tic
options = optimoptions('linprog','Display','iter','Algorithm','interior-point','TolFun',5*10^(-7),'MaxIterations',80);
[x,e,f,g,h]=linprog( c ,[ ],[ ],  K, beta , zeros(7*n,1)' ,caja, [],options);
toc
%ensamble de la solución

X=x(1:n);
Re(:,:,i)=reshape(X,size(Im));

end
R(:, :, j ,:)=Re ;
end
%% Mostrando imágenes
imshow(Ima,[])
title('Real')
figure
imshow(B,[])
title('Borrosa')
figure
for i=1:size(R,4)
imshow(uint8(R(:, : , ; , i),[])
title('Restaurada')
end
save('resultados_diferentes_regularizaciones.mat','Ima','R','B','intervalo','porcentaje')