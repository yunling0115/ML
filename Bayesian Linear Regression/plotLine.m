function plotLine(X, w, color)
    pred =X*w;
    figure(1); hold on;
    plot(X(:,2),pred, color, 'LineWidth', 2);
end