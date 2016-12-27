function kij = makePolyKernel(x,y,d)
kij=(x.'*y+1)^d;
end
