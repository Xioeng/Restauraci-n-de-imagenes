function a=Psnr(Im,Ref)
x=max(max(Im))^2;
m=(norm(Im-Ref,'fro')^2)/(size(Im,1)*size(Im,2));
a=10*log10(x/m);
end