function [alpha, beta]=estimateAlphaBetaViaEmpiricalBayes(X, T)
    %% automatically determine alpha, beta
    N = size(X,1);
    alpha = 20;  % initial value
    beta = 42;
    
    XX = X'*X;
    for iter = 1:10,
        [mu,~] = computePosterior(X,T,beta,alpha);        
        % figure out lambda
        [~, E] = eig(beta*XX);
        E = diag(E);
        gamma = sum( E ./ (E+alpha));
        fprintf('iter=%d, alpha=%f, beta =%f, gamma = %f\n', iter, alpha, beta, gamma);
        % reestimate alpha, beta
        alpha = gamma / (mu'*mu);
        beta = (N - gamma)/sum( (T - X*mu).^2);
    end
end