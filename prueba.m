% Demostraci�n del modelo propuesto 
%compara modelo sin regularizar y modelo regularizado
%Se pueden cambiar la imagen en la linea 17, los par�metros en las l�neas
%de la  23-33
%  Datos de Entrada:Ninguno- Es autocontenido
% Datos de Salida:Ninguno-Grafica resultados , imagenes real, borrosa y
% restauradas
% Autor: Jos� Fuentes 
% Fecha: 2020/06/01
% Versi�n: 1.0
%%
addpath('imagenes-prueba')
addpath(genpath('funciones propias'))
addpath('restauracion')

% selecci�n de archivos (carpeta: imagenes-prueba) se pueden agregar m�s
% imagenes si se desea
archivo='aurora.jpg';
Im=imread(archivo);
Im=double(rgb2gray(Im)); % imagen a blanco y negro
% Para hacer el modelo trabajable, usar im�genes de tama�o 300x300 para no saturar el computador
Im=imresize(Im,0.3);%(comentar si no es necesario)
%%
%Par�metros
porcentaje=0.5; %porcentaje de ruido
% Regularizaci�n
Alpha=1*10^(-2);
Gamma=2*10^(-2);
%%
%Construcci�n de la PSF y la imagen borrosa
% Se pueden escoger psfGauss (exponencial), psfMoffat (turbulencia), psfMov (Movimiento)
a=7; var=5; dec=1;  %par�metros de la psf
[Corr,c]=psfGauss(a,var,dec);

G=Psfaj(Corr,size(Im));
A=crear_A_conv(G, c,'reflexive');
%ruido e imagen borrosa
E=(randn(size(Im))); E=E/sum(sum(abs(E))); E=(porcentaje/100)*sum(sum(Im))*E;
B=A*Im(:);
B=reshape(B,size(Im))+E; 
%% Aplicaci�n del modelo
R_reg=restauracion_lp_reg(B,G,c, Alpha, Gamma);
R_sinreg=restauracion_lp_reg(B,G,c, 0,0);
%%  Visualizaci�n
imshow(uint8(Im),[])
title('Real')
figure
imshow(uint8(B),[])
title('Borrosa')
figure
imshow(uint8(R_sinreg),[])
title('sin regularizar')
figure
imshow(uint8(R_reg),[])
title('Regularizada')

