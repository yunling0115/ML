function pred=run_2_LR_a
global X y;
[N.train,dim] = size(X.train);
[N.test,dim] = size(X.test);
% linear 
w1 = RLS(X.train, y.train, 0);
linear.train = X.train*w1;
linear.test = X.test*w1;
% quadratic 
comb2 = nchoosek([1:dim],2);
X2.train = zeros(N.train,length(comb2));
X2.test = zeros(N.test,length(comb2));
for i=1:length(comb2) 
    X2.train(:,i)=X.train(:,comb2(i,1)).*X.train(:,comb2(i,2));
    X2.test(:,i)=X.test(:,comb2(i,1)).*X.test(:,comb2(i,2));
end
X2.train = horzcat(X.train,X2.train);
X2.test = horzcat(X.test,X2.test);
w2 = RLS(X2.train, y.train, 0);
quad.train = X2.train*w2;
quad.test = X2.test*w2;
% cubic 
comb3 = nchoosek([1:dim],3);
X3.train = zeros(N.train,length(comb3));
X3.test = zeros(N.test,length(comb3));
for i=1:length(comb3)
    X3.train(:,i)=X.train(:,comb3(i,1)).*X.train(:,comb3(i,2)).*X.train(:,comb3(i,3));
    X3.test(:,i)=X.test(:,comb3(i,1)).*X.test(:,comb3(i,2)).*X.test(:,comb3(i,3));
end
X3.train = horzcat(X2.train,X3.train);
X3.test = horzcat(X2.test,X3.test);
w3 = RLS(X3.train, y.train, 0);
cubic.train = X3.train*w3;
cubic.test = X3.test*w3;
pred.train = horzcat(linear.train,quad.train,cubic.train);
pred.test = horzcat(linear.test,quad.test,cubic.test);