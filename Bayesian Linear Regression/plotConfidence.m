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