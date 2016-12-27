function [mu, Sigma]=computePosterior(X,T,beta,alpha)
    [N,D] = size(X);
    Sigma = inv(alpha*eye(D)+beta*X'*X);
    mu = beta*Sigma*X'*T;
end