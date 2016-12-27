%function plotpa2()
figure, plot(Ftrain(Ltrain==1,1), Ftrain(Ltrain==1,2), 'bd', 'markersize', 4, 'linewidth', 2)
hold on, plot(Ftrain(Ltrain==2,1), Ftrain(Ltrain==2,2), 'rd', 'markersize', 4, 'linewidth', 2)
load rund=1
idxl = find(alpha2>1e-16);
load rund=2
idxq = find(alpha2>1e-16);
n = max(find(Ltrain==1));
hold on, plot(Ftrain(n+idxl,1), Ftrain(n+idxl,2), 'ko', 'markersize', 8, 'linewidth', 3)
hold on, plot(Ftrain(n+idxq,1), Ftrain(n+idxq,2), 'mo', 'markersize', 8, 'linewidth', 3)