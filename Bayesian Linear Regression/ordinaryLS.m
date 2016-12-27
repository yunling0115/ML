function lseW=ordinaryLS(X,T)      % ordinary regression
    lseW = inv(X'*X)*X'*T;
end