%% hw5 Q2
clear all; close;
%% data
% mu1 = [2 3]; 
% mu2 = [12 11]; 
% mu3 = [-5 8]; 
% SIGMA = eye(2)*0.8;
% r1 = mvnrnd(mu1,SIGMA,30);
% r2 = mvnrnd(mu2,SIGMA,30);
% r3 = mvnrnd(mu3,SIGMA,30);
% r = 3;
% theta = 0.3;
% for i = 1:10
%     o1(i,:)=[cos(theta*i)*r+mu1(1),sin(theta*i)*r+mu1(2)];
%     o2(i,:)=[cos(theta*i)*r+mu2(1),sin(theta*i)*r+mu2(2)];
%     o3(i,:)=[cos(theta*i)*r+mu3(1),sin(theta*i)*r+mu3(2)];
% end
% R = [r1;r2;r3];
% O = [o1;o2;o3];
% %% clustering
% [IDX1,C1] = kmeans(R,3);
% [IDX2,C2] = kmeans([R;O],3);
% [IDX3,C3] = newclustering(R,3);
% [IDX4,C4] = newclustering([R;O],3);
% %% save data
% good_data = R';
% outliers = O';
% GaussianMeans = [mu1;mu2;mu3]';
% clustering90means = C1';
% clustering120means = C2';
% newclustering90means = C3';
% newclustering120means = C4';
% save('clustering.mat','good_data','outliers','GaussianMeans','clustering90means','clustering120means','newclustering90means','newclustering120means');
%% use data
load('clustering.mat');
R = good_data'; O = outliers'; 
mu1 = GaussianMeans(:,1)';
mu2 = GaussianMeans(:,2)';
mu3 = GaussianMeans(:,3)';
[IDX1,C1] = kmeans(R,3);
[IDX2,C2] = kmeans([R;O],3);
[IDX3,C3] = newclustering(R,3);
[IDX4,C4] = newclustering([R;O],3);
%% plot 1
figure(1);
scatter(R(:,1),R(:,2),10,'c','MarkerFaceColor',[0.8 0.8 0.8],'MarkerEdgeColor',[0.8 0.8 0.8]); hold on; 
scatter(O(:,1),O(:,2),30,'d','MarkerFaceColor','black','MarkerEdgeColor','black');
scatter(mu1(:,1),mu1(:,2),60,'x','MarkerEdgeColor','green');
scatter(mu2(:,1),mu2(:,2),60,'x','MarkerEdgeColor','green');
scatter(mu3(:,1),mu3(:,2),60,'x','MarkerEdgeColor','green'); hold off;
%% plot 2
g1 = R(find(IDX1==1),:);
g2 = R(find(IDX1==2),:);
g3 = R(find(IDX1==3),:);
figure(2);
title('K-means results on 90 data points');
scatter(g1(:,1),g1(:,2),10,'c','MarkerFaceColor','blue','MarkerEdgeColor','blue'); hold on;
scatter(g2(:,1),g2(:,2),10,'c','MarkerFaceColor','black','MarkerEdgeColor','black');
scatter(g3(:,1),g3(:,2),10,'c','MarkerFaceColor','red','MarkerEdgeColor','red');
scatter(C1(1,1),C1(1,2),60,'square','MarkerEdgeColor','green');
scatter(C1(2,1),C1(2,2),60,'square','MarkerEdgeColor','green');
scatter(C1(3,1),C1(3,2),60,'square','MarkerEdgeColor','green'); hold off;
% 0.1847,0.2101,0.3924 
%% plot 3
D = [R;O];
g1 = D(find(IDX2==1),:);
g2 = D(find(IDX2==2),:);
g3 = D(find(IDX2==3),:);
figure(3);
title('K-means results on 120 data points');
scatter(g1(:,1),g1(:,2),10,'c','MarkerFaceColor','blue','MarkerEdgeColor','blue'); hold on;
scatter(g2(:,1),g2(:,2),10,'c','MarkerFaceColor','black','MarkerEdgeColor','black');
scatter(g3(:,1),g3(:,2),10,'c','MarkerFaceColor','red','MarkerEdgeColor','red');
scatter(C2(1,1),C2(1,2),60,'square','MarkerEdgeColor','green');
scatter(C2(2,1),C2(2,2),60,'square','MarkerEdgeColor','green');
scatter(C2(3,1),C2(3,2),60,'square','MarkerEdgeColor','green'); hold off;
% 0.6359,0.5983,0.3282 
%% plot 4
g1 = R(find(IDX3==1),:);
g2 = R(find(IDX3==2),:);
g3 = R(find(IDX3==3),:);
figure(4);
title('New clustering results on 90 data points');
scatter(g1(:,1),g1(:,2),10,'c','MarkerFaceColor','blue','MarkerEdgeColor','blue'); hold on;
scatter(g2(:,1),g2(:,2),10,'c','MarkerFaceColor','black','MarkerEdgeColor','black');
scatter(g3(:,1),g3(:,2),10,'c','MarkerFaceColor','red','MarkerEdgeColor','red');
scatter(C3(1,1),C3(1,2),60,'square','MarkerEdgeColor','green');
scatter(C3(2,1),C3(2,2),60,'square','MarkerEdgeColor','green');
scatter(C3(3,1),C3(3,2),60,'square','MarkerEdgeColor','green'); hold off;
% 0.3177,0.4505,0.4481
%% plot 5
D = [R;O];
g1 = D(find(IDX4==1),:);
g2 = D(find(IDX4==2),:);
g3 = D(find(IDX4==3),:);
figure(5);
title('New clustering results on 120 data points');
scatter(g1(:,1),g1(:,2),10,'c','MarkerFaceColor','blue','MarkerEdgeColor','blue'); hold on;
scatter(g2(:,1),g2(:,2),10,'c','MarkerFaceColor','black','MarkerEdgeColor','black');
scatter(g3(:,1),g3(:,2),10,'c','MarkerFaceColor','red','MarkerEdgeColor','red');
scatter(C4(1,1),C4(1,2),60,'square','MarkerEdgeColor','green');
scatter(C4(2,1),C4(2,2),60,'square','MarkerEdgeColor','green');
scatter(C4(3,1),C4(3,2),60,'square','MarkerEdgeColor','green'); hold off;
% 0.5599,0.5882,0.2463


%% Q2 - b
clear all; close;
matrix = imread('photo.jpg');
for i = 1:200
    for j = 1:200
        Data((i-1)*200+j,1)=matrix(i,j,1);
        Data((i-1)*200+j,2)=matrix(i,j,2);
        Data((i-1)*200+j,3)=matrix(i,j,3);
    end;
end;
Data = double(Data)/255;
[IDX1,K1] = clustering(Data,10);
[IDX2,K2] = clustering(Data,100);
[IDX3,K3] = clustering(Data,200);
[IDX4,K4] = clustering(Data,400);
Data1 = Data;
for i = 1:10
    Data1(find(IDX1==i),:)=ones(size(find(IDX1==i),1),1)*K1(i,:);
end;
Data2 = Data;
for i = 1:20
    Data2(find(IDX2==i),:)=ones(size(find(IDX2==i),1),1)*K2(i,:);
end;
Data3 = Data;
for i = 1:30
    Data3(find(IDX3==i),:)=ones(size(find(IDX3==i),1),1)*K3(i,:);
end;
Data4 = Data;
for i = 1:40
    Data4(find(IDX4==i),:)=ones(size(find(IDX4==i),1),1)*K4(i,:);
end;
matrix1 = matrix;
matrix2 = matrix;
matrix3 = matrix;
matrix4 = matrix;
for i = 1:200
    for j = 1:200
        matrix1(i,j,1)=int8(Data1((i-1)*200+j,1)*255);
        matrix1(i,j,2)=int8(Data1((i-1)*200+j,2)*255);
        matrix1(i,j,3)=int8(Data1((i-1)*200+j,3)*255);
        matrix2(i,j,1)=int8(Data2((i-1)*200+j,1)*255);
        matrix2(i,j,2)=int8(Data2((i-1)*200+j,2)*255);
        matrix2(i,j,3)=int8(Data2((i-1)*200+j,3)*255);
        matrix3(i,j,1)=int8(Data3((i-1)*200+j,1)*255);
        matrix3(i,j,2)=int8(Data3((i-1)*200+j,2)*255);
        matrix3(i,j,3)=int8(Data3((i-1)*200+j,3)*255);
        matrix4(i,j,1)=int8(Data4((i-1)*200+j,1)*255);
        matrix4(i,j,2)=int8(Data4((i-1)*200+j,2)*255);
        matrix4(i,j,3)=int8(Data4((i-1)*200+j,3)*255);
    end;
end;
imwrite(matrix1,'P1.png','png');
imwrite(matrix2,'P2.png','png');
imwrite(matrix3,'P3.png','png');
imwrite(matrix4,'P4.png','png');
