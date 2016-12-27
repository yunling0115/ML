function experiment_blr(trueBeta)
    % INSTRUCTIONS: 
    % you should complete the function experiment_blr()
    % save your produced figures and insert them to your .PDF report (with 
    % detailed description).
    
    % Generate data
    rng(1); % set the random generator seed.
    % trueBeta = 10;
    [X,T] = generateData(trueBeta);
    plotData(X,T);
    
    % Get the least-squares estimation
    lseW = ordinaryLS(X,T);
    plotLine(X,lseW, 'k');
    
    % Bayesian estimation, using 0-mean gaussian with precision alpha as a prior.
    beta = trueBeta;
    alpha1 = 100*beta;          % strong prior
    alpha2 = 30*beta;           % weaker prior.
    
    % Compute posterior distribution
    [mu1, Sigma1] = computePosterior(X,T,beta,alpha1); 
    [mu2, Sigma2] = computePosterior(X,T,beta,alpha2);
    plotLine(X, mu1, 'r');
    plotLine(X, mu2, 'M');
    
    % Estimate the hyperparmaeters.
    [alphaEBayes, betaEBayes] = estimateAlphaBetaViaEmpiricalBayes(X, T);
    [muEBayes, sigmaEBayes]   = computePosterior(X,T,betaEBayes,alphaEBayes)
    plotLine(X, muEBayes, 'b');
    
    % BLR is more than ordinary least squares.
    % It also provide confidence, based on the variance.
    plotConfidence(X, beta, muEBayes, sigmaEBayes)
end