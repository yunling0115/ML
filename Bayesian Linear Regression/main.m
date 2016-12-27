%% hw3 Q3
cd('C:\Users\Yun Ling\Google Drive\shitty courses\567\hw3\temp\Q3_split')
%% q1
experiment_blr(10);
experiment_blr(5);
experiment_blr(15);
%% q2
load('HW3-wine');
lambda = [0,0.5,1,1.5,2];
w = RLS(X.train, y.train,lambda(1));
for i = 1:5
    w(:,i) = RLS(X.train, y.train,lambda(i));
    RSS(i) = norm(y.dev-X.dev*w(:,i),2)^2;
end
[rss_RLS, min_RLS] = min(RSS);
Lambda = lambda(min_RLS)
ARSS.train = mean((y.train-X.train*w(:,min_RLS)).^2)
ARSS.dev = mean((y.dev-X.dev*w(:,min_RLS)).^2)
ARSS.test = mean((y.test-X.test*w(:,min_RLS)).^2)
%% q3
load('HW3-wine');
clear mu Sigma;
% 1
X.comb = [X.train;X.dev];
y.comb = [y.train;y.dev];
pars = [10,50;20,50;20,20;50,10;500,10;50,30;500,30];
[M,N] = size(pars);
for i = 1:M
    [mu, Sigma] = computePosterior(X.comb,y.comb,pars(i,1),pars(i,2));
    [pred,var] = predictiveDistribution(X.comb, pars(i,2), mu, Sigma);
    RSS_bayes.train(i) = norm(y.comb-pred,2)^2/length(y.comb);
    [mu, Sigma] = computePosterior(X.test,y.test,pars(i,1),pars(i,2));
    [pred,var] = predictiveDistribution(X.test, pars(i,2), mu, Sigma);
    RSS_bayes.test(i) = norm(y.test-pred,2)^2/length(y.test);    
end
[rss_Bayes,min_Bayes] = min(RSS_bayes.test)
Pars = pars(min_Bayes,:)
RSS_bayes.train
RSS_bayes.test
% 2
for i = 1:M
    [alphaEBayes, betaEBayes] = estimateAlphaBetaViaEmpiricalBayes0(X.comb, y.comb,pars(i,1),pars(i,2));
    [mu, Sigma] = computePosterior(X.comb,y.comb,alphaEBayes, betaEBayes);
    [pred,var] = predictiveDistribution(X.comb, pars(i,2), mu, Sigma);
    RSS_bayes_e.train(i) = norm(y.comb-pred,2)^2/length(pred);
    [pred,var] = predictiveDistribution(X.test, pars(i,2), mu, Sigma);
    RSS_bayes_e.test(i) = norm(y.test-pred,2)^2/length(pred);
end
[rss_Bayes_e,min_Bayes_e] = min(RSS_bayes_e.test)
Pars = pars(min_Bayes_e,:)
RSS_bayes_e.train
RSS_bayes_e.test






