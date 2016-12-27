function [IDX Medians] =newclustering(X,K)
% Step 0
[N,D] = size(X);
medians=mvnrnd(mean(X,1),eye(D),K);
idx=zeros(N,1);
d_temp=1;
d=0;
while abs(d-d_temp)>1E-6
    d_temp = d;
    % step 1
    M = zeros(N,K);
    for i = 1:K
        M(:,i) = sum(abs(X-ones(N,1)*medians(i,:)),2);
    end;
    [val,idx] = min(M,[],2);
    % step 2
    d = 0;
    for i = 1:K
        group = X(find(idx==i),:);
        medians(i,:) = median(group);
        d = d+sum(sum(abs(group-ones(size(group,1),1)*medians(i,:)),2));
    end;
end;
IDX = idx;
Medians = medians;