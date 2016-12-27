function experiment_blr()
    % INSTRUCTIONS: 
    % you should complete the function experiment_blr()
    % save your produced figures and insert them to your .PDF report (with 
    % detailed description).
    
    % Generate data
    rng(1); % set the random generator seed.
    trueBeta = 10;
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



function [mu, Sigma]=computePosterior(X,T,beta,alpha)
    %[FILL IN PART]
end

function [pred, variance]=predictiveDistribution(X, beta, mu, Sigma)
    %[FILL IN PART]
end

function lseW=ordinaryLS(X,T)      % ordinary regression
    lseW = inv(X'*X)*X'*T;
end

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

%%%%%%%%%%%%%%%%%% data generation %%%%%%%%%%%%%%%%%%

function [X,T, trueBeta]=generateData(trueBeta)
    %% Getting data
    W = [1; 1];
    N = 100;
    X= [ones(N,1) sort(randn(N,1))];
    T = X*W + randn(N,1)*sqrt(1/trueBeta);
end


%%%%%%%%%%%%%%%%%% plotting related functions %%%%%%%%%%%%%%%%%%

function plotData(X,T)
    %% plot data
    figure(1); clf;
    scatter(X(:,2), T, 30, 'filled');
    hold on;
end

function plotLine(X, w, color)
    pred =X*w;
    figure(1); hold on;
    plot(X(:,2),pred, color, 'LineWidth', 2);
end


function plotConfidence(X, beta, mu, Sigma)
    N = size(X,1);
    %% calculate each prediction's variance
    [pred, variance] = predictiveDistribution(X, beta, mu, Sigma);
    %% plot confidence interval using one standard deviation
    figure;
    ciplot(pred - variance.^(1/2), pred + variance.^(1/2));
    hold on;
    plot([1:N], pred, 'd', 'MarkerFaceColor', 'r', 'MarkerSize', 10);
end

function ciplot(lower,upper,x,colour)
     
    % ciplot(lower,upper)       
    % ciplot(lower,upper,x)
    % ciplot(lower,upper,x,colour)
    %
    % Plots a shaded region on a graph between specified lower and upper confidence intervals (L and U).
    % l and u must be vectors of the same length.
    % Uses the 'fill' function, not 'area'. Therefore multiple shaded plots
    % can be overlayed without a problem. Make them transparent for total visibility.
    % x data can be specified, otherwise plots against index values.
    % colour can be specified (eg 'k'). Defaults to blue.

    % Raymond Reynolds 24/11/06

    if length(lower)~=length(upper)
        error('lower and upper vectors must be same length')
    end

    if nargin<4
        colour='b';
    end

    if nargin<3
        x=1:length(lower);
    end

    % convert to row vectors so fliplr can work
    if find(size(x)==(max(size(x))))<2
    x=x'; end
    if find(size(lower)==(max(size(lower))))<2
    lower=lower'; end
    if find(size(upper)==(max(size(upper))))<2
    upper=upper'; end

    fill([x fliplr(x)],[upper fliplr(lower)],colour)
end


