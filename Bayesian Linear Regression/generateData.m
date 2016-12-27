function [X,T, trueBeta]=generateData(trueBeta)
    %% Getting data
    W = [1; 1];
    N = 100;
    X= [ones(N,1) sort(randn(N,1))];
    T = X*W + randn(N,1)*sqrt(1/trueBeta);
end
