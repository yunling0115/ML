function dist=Lp(a,b,p)
% x has 1 column
% y has n columns
% x and y have the same dimension
[d,n] = size(b);
A = abs(a*ones(1,n)-b);
if isequal(p,'inf')
    dist = mean(A);
else
    dist = sum(A.^p).^(1/p);
end