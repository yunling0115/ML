function pred=run_1_KNN(K,p,set) 
global X y;
[dim,N.train] = size(X.train);
[dim,N.devel] = size(X.devel);
[dim,N.test] = size(X.test);
if set=='train'
    % leave one out
    dist = zeros(N.train,N.train);
    IX = zeros(N.train,N.train);
    for i=1:N.train
        dist(i,:)=Lp(X.train(:,i),X.train,p);
    end
    [B,IX]=sort(dist);
    IX_KNN = IX(:,2:K+1);
    y_KNN = y.train(IX_KNN);
    pred = (round(mean(y_KNN,2)))';
elseif set=='devel'
    dist = zeros(N.devel,N.train);
    IX = zeros(N.devel,N.train);
    for i=1:N.devel
        dist(i,:)=Lp(X.devel(:,i),X.train,p);
    end
    [B,IX]=sort(dist);
    IX_KNN = IX(:,1:K);
    y_KNN = y.train(IX_KNN);
    pred = (round(mean(y_KNN,2)))';
elseif set=='test'
    dist = zeros(N.test,N.train);
    IX = zeros(N.test,N.train);
    for i=1:N.test
        dist(i,:)=Lp(X.test(:,i),X.train,p);
    end
    [B,IX]=sort(dist);
    IX_KNN = IX(:,1:K);
    y_KNN = y.train(IX_KNN);
    pred = (round(mean(y_KNN,2)))';
else 
    % incorrect input
    disp('incorrect input for set');
    pred = 0;
end;