cd('C:\Users\Yun Ling\Google Drive\shitty courses\567\hw2');

%% 3 Digit Classification using K-Nearest Neighbors

clear all;
close;
global X y;
load('USPS-split1.mat');

% imshow(double(reshaPpe(X.devel(:,3),16,16)));
Pp=[0.5,1,1.5,2,3];
K=[1,3,5,7,9,11,13,15,17,19];
acc.train = zeros(length(Pp)+1,length(K));
acc.devel = zeros(length(Pp)+1,length(K));
acc.test = zeros(length(Pp)+1,length(K));
for i=1:length(Pp)
    for j=1:length(K)
        K(j)
        Pp(i)
        Pred.train=run_1_KNN(K(j),Pp(i),'train');
        Pred.devel=run_1_KNN(K(j),Pp(i),'devel');
        Pred.test=run_1_KNN(K(j),Pp(i),'test');
        acc.train(i,j)=mean(y.train==Pred.train);
        acc.devel(i,j)=mean(y.devel==Pred.devel);
        acc.test(i,j)=mean(y.test==Pred.test);
    end
end
for j=1:length(K)
    Pred.train=run_1_KNN(K(j),'inf','train');
    Pred.devel=run_1_KNN(K(j),'inf','devel');
    Pred.test=run_1_KNN(K(j),'inf','test');
    acc.train(length(Pp)+1,j)=mean(y.train==Pred.train);
    acc.devel(length(Pp)+1,j)=mean(y.devel==Pred.devel);
    acc.test(length(Pp)+1,j)=mean(y.test==Pred.test);
end
clc
acc.train
acc.devel
acc.test
[best.train,index.train]=max2(acc.train);
[best.devel,index.devel]=max2(acc.devel);
[best.test,index.test]=max2(acc.test);

% PredTrain = 
PredTrain=run_1_KNN(K(index.train(1)),Pp(index.train(2)),'train');
% PredDevel = 
PredDevel=run_1_KNN(K(index.devel(1)),Pp(index.devel(2)),'devel');
% PredTest =
PredTest=run_1_KNN(K(index.test(1)),Pp(index.test(2)),'test');


%% 4 Linear Regression
clear all;
close;
global X y;
load('wine.mat');

% (1) Feature Design
Pred = run_2_LR_a;
rss.test = sum((Pred.test-y.test*ones(1,3)).^2);
accuracy.test = mean(round(Pred.test)==y.test*ones(1,3));
rss.train = sum((Pred.train-y.train*ones(1,3)).^2);
accuracy.train = mean(round(Pred.train)==y.train*ones(1,3));
mean((Pred.test-y.test*ones(1,3)).^2)
mean((Pred.train-y.train*ones(1,3)).^2)

% (2) Regularization
lambda = [0:0.5:10];
ben = zeros(3,length(lambda));
for i=1:length(lambda)
    ben(:,i) = run_2_LR_b(lambda(i))';
end
accuracy = ben(3,:);
norm2 = ben(1,:);
w2 = ben(2,:);

% find lambda mximize accuracy
goal = norm2+lambda.*w2;
[maxb,m] = min(goal);
[maxa,n] = max(accuracy);
lambda_max = lambda(n);
lambda_min = lambda(m);

% Plot of norm2 and w2
subplot(1,2,1);
plotyy(lambda,norm2,lambda,w2);
penal = lambda_max*w2;
subplot(1,2,2);
plotyy(lambda,norm2,lambda,penal);

