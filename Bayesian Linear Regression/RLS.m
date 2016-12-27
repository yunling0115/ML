function w=RLS(X,y,lambda)
% ridge regression 
% X is n by d, y is n by 1
A = X'*X;
w = (A+lambda*eye(size(A)))\(X'*y);