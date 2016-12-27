%% hw3 Q4
load('HW3-USPS-split.mat');
lambda = 10;
Lambda = 5:5:25; % regularizer
C = 10; % # of classes
K = 5; % cross-validation class
%% one-to-rest
for i = 1:C
    y_one_rest = (y.train==i);
    lambda_one_rest(i) = select_lambda(X.train,y_one_rest,Lambda,K);
end
%% one-to-one
pair = nchoosek([1:C],2);
for i = 1:length(pair)
    index_one = find(y.train==pair(i,1));
    index_another = find(y.train==pair(i,2));
    y_either = [y.train(index_one),y.train(index_another)];
    X_either = [X.train(:,index_one),X.train(:,index_another)];
    y_either = (y_either==pair(i,1));
    lambda_one_one(i) = select_lambda(X_either,y_either,Lambda,K);
end  
%% a
for i = 1:C
    y_one_rest = (y.train==i);
    OBJ_save = logreg_DISC_plot(X.train,y_one_rest,lambda_one_rest(i),i);
end
lambda_one_rest
lambda_one_one
%% b (accuracy of one-to-many and one-to-one)
for i = 1:C
    y_one_rest = (y.train==i);
    w_one_rest(:,i) = logreg_DISC(X.train,y_one_rest,lambda_one_rest(i));
    pred_one_rest.train(:,i) = round(sigmoid(X.train'*w_one_rest(:,i)));
    pred_one_rest.test(:,i) = round(sigmoid(X.test'*w_one_rest(:,i)));
    acc_one_rest.train(i) = mean(pred_one_rest.train(:,i)==y_one_rest');
    y_one_rest_test = (y.test==i);
    acc_one_rest.test(i) = mean(pred_one_rest.test(:,i)==y_one_rest_test');
end
for i = 1:length(pair)
    index_one = find(y.train==pair(i,1));
    index_another = find(y.train==pair(i,2));
    y_either = [y.train(index_one),y.train(index_another)];
    X_either = [X.train(:,index_one),X.train(:,index_another)];
    y_either = (y_either==pair(i,1));
    w_one_one(:,i) = logreg_DISC(X_either,y_either,lambda_one_one(i));
    y_either_test = [y.test(find(y.test==pair(i,1))), y.test(find(y.test==pair(i,2)))];
    X_either_test = [X.test(:,find(y.test==pair(i,1))),X.test(:,find(y.test==pair(i,2)))];
    y_either_test = (y_either_test==pair(i,1));
    pred_one_one.train(:,i) = round(sigmoid(X_either'*w_one_one(:,i)));
    pred_one_one.test(:,i) = round(sigmoid(X_either_test'*w_one_one(:,i)));
    acc_one_one.train(i) = mean(pred_one_one.train(:,i)==y_either');
    acc_one_one.test(i) = mean(pred_one_one.test(:,i)==y_either_test');
end
%% c
%% d
