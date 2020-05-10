function H = buildHank(c, k)
%
% Build a Hankel matrix for separable PSF and reflexive boundary
% conditions.
%
n = length(c);
col = zeros(n,1);
col(1:n-k) = c(k+1:n);
row = zeros (n,1);
row(n-k+2:n) = c(1:k-1);
H = hankel(col, row);

end

