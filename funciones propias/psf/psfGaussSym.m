function [b,c] = psfGaussSym( dim,s,p )
%PSFGAUSS Summary of this function goes here
%   Detailed explanation goes here
b=zeros(dim(1),dim(2));
%  Crea el difuminado atmosferico sin escalado
i=1+floor((dim(1))/2);j=1+floor((dim(2))/2);
for l=1:dim(1)
    for k=1:dim(2)
        b(l,k)=exp(-0.5*(  (abs(l-i)/s)^p+(abs(k-j)/s)^p) );
        if b(l,k)<10^(-6)
            b(l,k)=0;
        else
        end
    end
end
s=sum(b(:));
b=(1/s)*b;
c=[i,j];
end



