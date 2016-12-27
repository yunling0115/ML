function [value,index] = max2(A)
% find the index of A's element
[a,m] = max(A);
[b,n] = max(a');
value = b;
index = [m(n),n];
