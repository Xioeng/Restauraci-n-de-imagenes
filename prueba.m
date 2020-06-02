% Demostración del modelo propuesto 
%compara modelo sin regularizar y modelo regularizado
%Se pueden cambiar la imagen en la linea 17, los parámetros en las líneas
%de la  23-33
%  Datos de Entrada:Ninguno- Es autocontenido
% Datos de Salida:Ninguno-Grafica resultados , imagenes real, borrosa y
% restauradas
% Autor: José Fuentes 
% Fecha: 2020/06/01
% Versión: 1.0
%%
addpath('imagenes-prueba')
addpath(genpath('funciones propias'))
addpath('restauracion')

% selección de archivos (carpeta: imagenes-prueba) se pueden agregar más
% imagenes si se desea
archivo='aurora.jpg';
Im=imread(archivo);
Im=double(rgb2gray(Im)); % imagen a blanco y negro
% Para hacer el modelo trabajable, usar imágenes de tamaño 300x300 para no saturar el computador
Im=imresize(Im,0.3);%(comentar si no es necesario)
%%
%Parámetros
porcentaje=0.5; %porcentaje de ruido
% Regularización
Alpha=1*10^(-2);
Gamma=2*10^(-2);
%%
%Construcción de la PSF y la imagen borrosa
% Se pueden escoger psfGauss (exponencial), psfMoffat (turbulencia), psfMov (Movimiento)
a=7; var=5; dec=1;  %parámetros de la psf
[Corr,c]=psfGauss(a,var,dec);

G=Psfaj(Corr,size(Im));
A=crear_A_conv(G, c,'reflexive');
%ruido e imagen borrosa
E=(randn(size(Im))); E=E/sum(sum(abs(E))); E=(porcentaje/100)*sum(sum(Im))*E;
B=A*Im(:);
B=reshape(B,size(Im))+E; 
%% Aplicación del modelo
R_reg=restauracion_lp_reg(B,G,c, Alpha, Gamma);
R_sinreg=restauracion_lp_reg(B,G,c, 0,0);
%%  Visualización
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

