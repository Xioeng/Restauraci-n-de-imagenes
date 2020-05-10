function [P ] = Psfaj( psf, tam)
% ajusta la psf para que tenga el mismo tamaño que la imagen. El centro es
% el mismo
n=tam(1);
if size(tam,2)==1
    m=n
else m=tam(2);
end
    P=zeros(n,m);
    P(1:size(psf,1),1:size(psf,2))=psf;
end

