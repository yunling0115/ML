function opt = runViterbi()
load('hw6data.mat');
w = zeros(10,9);
id = zeros(10,8);
w(:,1) = pi0';
for i = 2:9 
    e = zeros(8,1);
    e(int8(x(i-1))) = 1;
    [a,b] = max(diag(w(:,i-1))*transP);
    id(:,i-1) = b';    
    w(:,i) = diag(obsP*e)*a';
end
[a,b] = max(w(:,9));
opt = zeros(1,8);
opt(8) = b;
for i = 7:-1:1
    opt(i) = id(opt(i+1),i);
end


