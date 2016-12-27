function ben = run_2_LR_b(lambda)
% norm of residaul, norm of w, accuracy
global X y;
K = 10;
[N.train,dim] = size(X.train);
[N.test,dim] = size(X.test);
assign = ceil(K*rand(N.train,1));
norm2 = zeros(1,K);
penal = zeros(1,K);
accuracy = zeros(1,K);
for i=1:K
    treat = find(assign==i)';
    control = find(1-(assign==i))';
    x.devel = X.train(treat,:);
    x.train = X.train(control,:);
    z.devel = y.train(treat,:);
    z.train = y.train(control,:);
    w = RLS(x.train,z.train,lambda);
    norm2(i) = norm(x.devel*w-z.devel,2)^2;
    penal(i) = norm(w,2)^2;
    accuracy(i) = mean(round(x.devel*w)==z.devel);
end;
ben = [mean(norm2),mean(penal),mean(accuracy)];