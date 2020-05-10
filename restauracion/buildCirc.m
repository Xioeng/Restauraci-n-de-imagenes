function C = buildCirc(c, k)
%
% Build a banded circulant matrix from a central column and an index
% denoting the central column.
%
n = length(c) ;
col = [c(k:n) ; c(1:k-1) ] ;
row = [c(k:-1:1)', c(n:-1:k+1)'];
C = toeplitz(col, row);


end

