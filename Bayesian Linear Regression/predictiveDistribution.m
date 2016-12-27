function [pred, variance]=predictiveDistribution(X, beta, mu, Sigma)
    [N,D] = size(X);
    pred = X*mu;
    variance = inv(beta)*ones(N,1)+diag(X*Sigma*X');
end