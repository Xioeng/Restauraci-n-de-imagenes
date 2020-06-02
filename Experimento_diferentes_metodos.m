% Algoritmo para probar el método propuesto contra otros métodos:
% -Lucy-Richardson deconvolution
%-Filtro de Winner 
%-Regularización de Tychonov
%-Artículo (BSNM). 
%**No obstante, se puede cambiar la imagen en
%la línea 25  y su tamaño en la 27.
%
%  Datos de Entrada: Ninguno
% Datos de Salida: Imagenes real, borrosa, restauradas por los diferentes
% métodos, una tabla con resultados cuantitativos y un archivo .mat con los
% resultados guardados.
% Autor: José Fuentes 
% Fecha: 2020/06/01
% Versión: 1.0

%%
addpath(genpath('blind-dec2'))
addpath('HNO')
addpath('imagenes-prueba')
%addpath('restauracion')
addpath(genpath('funciones propias'))
%%
%Construcción de la PSF y la imagen borrosa
archivo='placa-roja.jpg';
Im=imread(archivo);
Im=double(rgb2gray(Im));
Im=imresize(Im,.8);

%construcción PSF 
a=15; var=8; dec=2; 
[Corr,c]=psfGauss([a,a],var,dec);
G=Psfaj(Corr,size(Im));


A=crear_A_conv(G, c,'reflexive');
%ruido e imagen borrosa
porcentaje=0.5; %porcentaje de ruido
E=(randn(size(Im))); E=E/sum(sum(abs(E))); E=(porcentaje/100)*sum(sum(Im))*E;
B=A*Im(:);
B=reshape(B,size(Im))+E; 
imwrite(uint8(B),  'bor_e.jpg' ,'jpg')
%%
%Métodos deblurrring
R_lucy = deconvlucy(B,Corr);
R_blind=deconvblind(B,Corr);
R_wiener=deconvwnr(B,Corr);
R_articulo= test_blind_deconv('bor_e.jpg'); close all
R_regularizacion=tik_sep( B, G , c);
R_propuesto=restauracion_lp_reg( B, G , c , 2*10^(-2) , 1*10^(-2) );

%%
%Resultados
metodos={'Borrosa', 'Richardson-l', 'Wiener', 'blind', 'articulo', 'regularización', 'propuesto'};
medidas={'ERR', 'SSIM',  'PSNR'};
Resultados=[sum(sum(abs(B-Im)))/sum(sum(abs(Im))),  ssim_index(B, Im), Psnr(B, Im);
sum(sum(abs(R_lucy-Im)))/sum(sum(abs(Im))),  ssim_index(R_lucy, Im), Psnr(R_lucy, Im);  
sum(sum(abs(R_wiener-Im)))/sum(sum(abs(Im))),  ssim_index(R_wiener, Im), Psnr(R_wiener, Im);   
sum(sum(abs(R_blind-Im)))/sum(sum(abs(Im))),  ssim_index(R_blind, Im), Psnr(R_blind, Im);   
sum(sum(abs(R_articulo-Im)))/sum(sum(abs(Im))),  ssim_index(R_articulo, Im), Psnr(R_articulo, Im);   
sum(sum(abs(R_regularizacion-Im)))/sum(sum(abs(Im))),  ssim_index(R_regularizacion, Im), Psnr(R_regularizacion, Im); 
sum(sum(abs(R_propuesto-Im)))/sum(sum(abs(Im))),  ssim_index(R_propuesto, Im), Psnr(R_propuesto, Im);   
];
%%
%Resultados
Tabla=array2table(Resultados, 'VariableNames', medidas, 'RowNames', metodos)

%Gráficas
subplot(3,3,1), imshow(Im,[])
subplot(3,3,2), imshow(B,[])
subplot(3,3,4), imshow(R_lucy,[])
subplot(3,3,5), imshow(R_wiener,[])
subplot(3,3,6), imshow(R_blind,[])
subplot(3,3,7), imshow(R_articulo,[])
subplot(3,3,8), imshow(R_regularizacion,[])
subplot(3,3,9), imshow(R_propuesto,[])

%guardando :v
save('Resultados varios metodos','Im','B','R_lucy','R_wiener','R_blind','R_articulo','R_regularizacion','R_propuesto','Tabla')
