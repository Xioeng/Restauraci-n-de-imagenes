function T = buildToep(c, k)
%
% Build a banded Toeplitz matrix from a central column and an index
% denoting the central column.
%
n = length (c);
col = zeros(n,1);
row = col';
col(1:n-k+1,1) = c(k:n);
row(1,1:k) = c(k:-1:1);
T = toeplitz(col, row);
end