function w = logreg_DISC(X,y,lambda)
[D,N] = size(X);
gamma = 1/2;
R = 15;
eps = 10^(-5);
T = 50;
w0 = zeros(D,1);
w = w0;
OBJ = -sum(y.*log(sigmoid(w'*X))+(1-y).*log(1-sigmoid(w'*X)))+lambda/2*norm(w,2)^2;
H = X*diag(sigmoid(w'*X).*(1-sigmoid(w'*X)))*X'+lambda*eye(D);
DF = X*(sigmoid(w'*X)-y)'+lambda*w;
w1 = w - gamma*H\DF;
OBJ_n = -sum(y.*log(sigmoid(w1'*X))+(1-y).*log(1-sigmoid(w1'*X)))+lambda/2*norm(w1,2)^2;
flag1 = 1;
while (abs((OBJ_n-OBJ)/OBJ) > eps) & (flag1<=T)
    w = w1;
    OBJ = -sum(y.*log(sigmoid(w'*X))+(1-y).*log(1-sigmoid(w'*X)))+lambda/2*norm(w,2)^2;
    H = X*diag(sigmoid(w'*X).*(1-sigmoid(w'*X)))*X'+lambda*eye(D);
    DF = X*(sigmoid(w'*X)-y)'+lambda*w;
    w1 = w - gamma*H\DF;
    OBJ_n = -sum(y.*log(sigmoid(w1'*X))+(1-y).*log(1-sigmoid(w1'*X)))+lambda/2*norm(w1,2)^2;
    flag2 = 1;
    while (OBJ_n>OBJ) & (flag2<=R)
        flag2 = flag2+1;
        gamma = gamma*gamma;
        w1 = w - gamma*H\DF;
        OBJ_n = -sum(y.*log(sigmoid(w1'*X))+(1-y).*log(1-sigmoid(w1'*X)))+lambda/2*norm(w1,2)^2;
    end;
    flag1 = flag1+1;
end;
w = w1;

    