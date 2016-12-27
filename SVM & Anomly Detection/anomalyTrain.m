function [alpha, r,K]=anomalyTrain(train,C,d)
% input:
%   train:  nxd training data points
%   C:      the margin weight coefficient
%   d:      the degree of the polynomial kernel
n = size(train, 1);
K=zeros(n, n);
for i= 1:n
    for j=i:n
        K(i,j) = makePolyKernel(train(i,:)',train(j,:)',d);
        K(j,i) = K(i,j);
    end
end

H=4*K;
f = -1*diag(K);

Aeq = ones(1,n);
beq = 0.5;
%Aeq = ones(size(K,1),1).';
%beq = 0.5;

lb = zeros(n,1);
ub = lb+C;
%lb=zeros(size(K,1),1);
%ub=zeros(size(K,1),1);
%for i =1:size(K,1)
%    ub(i) = C;
%end

opts = optimset('Algorithm','active-set','Display','off');
alpha = quadprog(H,f,[],[],Aeq,beq,lb,ub,[],opts);

% estimate r from support vectors
idx =find(alpha>1e-16 & alpha<C);
for i=1:length(idx)
    sv = idx(i);
    r2 = K(sv,sv) + 4*alpha'*K*alpha-4*alpha'*K(:,sv);
    r(i) = sqrt(r2);
end
if(max(r)-min(r)>1e-6)
    fprintf(2,'the optimization result is inconsitent with theoretical expectation\n');
end
%r = r(1);



end
