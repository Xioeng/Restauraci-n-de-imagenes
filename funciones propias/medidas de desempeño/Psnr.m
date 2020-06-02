function a=Psnr(Im,Ref)
%  Calcula el PSNR entre una imagen y una de referencia
%Datos de entrada: Im, imagen a calular con respecto a la imagen de
%referencia Ref.
%Datos de salida: a:PSNR
% Autor: José Fuentes 
% Fecha: 2020/06/01
% Versión: 1.0
%%
x=max(max(Im))^2;
m=(norm(Im-Ref,'fro')^2)/(size(Im,1)*size(Im,2));
a=10*log10(x/m);
end