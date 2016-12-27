function normal = anomalyDetect(test,train,alpha,r,Krr,d)
% input: 
%   alpha:  the dual optima
%   train:  the training set
%   test:   the testing set
%   r:      the learned radius
%   K:      the kernel of the training set
%   d:      the degree of the polynomial kernel

% 1. calculate some useful constants 
pseudoR = r*r-4*alpha'*Krr*alpha;
ne = size(test, 1);
nr = size(train, 1);

Kre = zeros(nr, ne);
for i=1:nr
    for j=1:ne
        Kre(i,j) = makePolyKernel(test(j,:)', train(i,:)',d);
    end
end
Ktt = zeros(ne,1);
for i=1:ne
        Ktt(i) = makePolyKernel(test(i,:)', test(i,:)', d);
end

distance = zeros(ne,1);
for i=1:ne
    distance(i) = Ktt(i) -4*alpha'*Kre(:,i);
end

normal = distance<=pseudoR;

end
