function lambda = select_lambda(X,y,Lambda,K)
[D, N] = size(X);
assign = ceil(K*rand(N,1));
for j = 1:length(Lambda)
    for i = 1:K
        treat = find(assign==i)';
        control = find(1-(assign==i))';
        x.devel = X(:,treat);
        x.train = X(:,control);
        z.devel = y(:,treat);
        z.train = y(:,control);
        w = logreg_DISC(x.train,z.train,Lambda(j));
        entropy(i) = -sum(z.devel.*log(sigmoid(w'*x.devel))+(1-z.devel).*log(1-sigmoid(w'*x.devel)));
    end
    index = isnan(entropy);
    entropy(index) = 0;
    entropy_mean(j) = mean(entropy);
end
entropy_mean
[entropy,index] = min(entropy_mean);
lambda = Lambda(index);