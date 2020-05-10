%evaluacion
%este código debe ser ejecutado después de el script
%'diferentes_gama_regularizaciones.m'
addpath(genpath('funciones propias'))
addpath(genpath('restauracion'))
addpath(genpath('imagenes-prueba'))
load('resultados_diferentes_regularizaciones.mat');
im=double(Ima);
err=[];
psnr=[];
ssim=[];
for l=1:size(R,4)
    er=0;
    ps=0;
    ss=0;
    for i=1:3
        er=er+sum(sum(abs(im(:,:,i)-R(:,:,i,l))))/sum(sum(im(:,:,i)));
        ps=ps+Psnr(im(:,:,i),R(:,:,i,l));
        ss=ss+ssim_index(im(:,:,i),R(:,:,i,l));
    end
    err(l)=100*er/3;
    psnr(l)=ps/3;
    ssim(l)=ss/3;
end
[ a b]=min(err)
[c d]=max(psnr)
[e f]=max(ssim)
figure
plot(err,'--dm','MarkerEdgeColor','b')
grid on
xlabel('Case')
legend('Err curve')
ylabel(' Err %')
title('Err mesaure')

figure
plot(ssim,'--dm','MarkerEdgeColor','b')
grid on
xlabel('Case')
legend('SSIM curve')
ylabel(' SSIM index')
title('SSIM mesaure')
figure
plot(psnr,'--dm','MarkerEdgeColor','b')
grid on
xlabel('Case')
legend('PSNR curve')
ylabel(' dB')
title('PSNR mesaure')
