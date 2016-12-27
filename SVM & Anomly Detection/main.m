%% Hw4
%% Train the model
load('HW4-syn.mat');
d = 1;
% train the model for class 1
Ftrain = Data.train;
Ftest = Data.test;
Ltrain = Label.train;
Ltest = Label.test;
% train the model for the 1-st class
% look for the coefficient with 5% false rejection
Coeff = [0 0.025 0.5];%0.02:0.08:0.5;
data1 = Ftrain(Ltrain==1,:);
rate1 = [];
while(1)
    Coeff(2)
    [alpha1, r1, K1]=anomalyTrain(data1,Coeff(2),d);
    devel = anomalyDetect(data1,data1,alpha1,r1(1),K1,d);
    rate1 = [rate1; Coeff(2) sum(devel)/length(devel)];
    
    if(abs(rate1(end,2)-0.95)<0.01)
        break;
    elseif(rate1(end,2)>0.95+0.01)
        Coeff(3) = Coeff(2);
        Coeff(2) = (Coeff(3)+Coeff(1))/2;
    else
        Coeff(1) = Coeff(2);
        Coeff(2) = (Coeff(3)+Coeff(1))/2;
    end
    if(Coeff(3)-Coeff(2)<Coeff(3)/1000)
        Coeff(3) = Coeff(3)*2;
    end
end
Coeff1 = Coeff;
fprintf(2, 'for the class 1, we obtain the acceptance rate of %f at coefficient %f\n', rate1(end), Coeff(2));

Coeff = [0 0.025 0.05];%0.02:0.08:0.5;
data2 = Ftrain(Ltrain==2,:);
rate2 = [];
while(1)
    Coeff(2)
    [alpha2, r2, K2]=anomalyTrain(data2,Coeff(2),d);
    r2
    devel = anomalyDetect(data2,data2,alpha2,r2(1),K2,d);
    rate2 = [rate2; Coeff(2) sum(devel)/length(devel)];
    
    if(abs(rate2(end,2)-0.95)<0.01)
        break;
    elseif(rate2(end,2)>0.95+0.01)
        Coeff(3) = Coeff(2);
        Coeff(2) = (Coeff(3)+Coeff(1))/2;
    else
        Coeff(1) = Coeff(2);
        Coeff(2) = (Coeff(3)+Coeff(1))/2;
    end
    if(Coeff(3)-Coeff(2)<Coeff(3)/1000)
        Coeff(3) = Coeff(3)*2;
    end
end
Coeff2 = Coeff;
fprintf(2, 'for the class 2, we obtain the acceptance rate of %f at coefficient %f\n', rate2(end), Coeff(2));

%% number of support vectors
d = [1,2,3];
C1 = [0.047266,0.084839,0.054688];
C2 = [0.043619,0.037500,0.048438];
clear alpha1 alpha2 r1 r2
for i=1:3
    [alpha1, r1, K]=anomalyTrain(data1,C1(i),d(i));
    fprintf(2,'class 1');
    r1
    sum((alpha1>1e-6).*(alpha1<C1(i)))
    [alpha2, r2, K]=anomalyTrain(data2,C2(i),d(i));
    fprintf(2,'class 2');
    r2
    sum((alpha2>1e-6).*(alpha2<C2(i)))
end

%% testing stage
test1 = Ftest(Ltest==1,:);
test2 = Ftest(Ltest==2,:);
d = [1,2,3];
C1 = [0.047266,0.084839,0.054688];
C2 = [0.043619,0.037500,0.048438];
for i = 1:3 
    [alpha1, r1, K1]=anomalyTrain(data1,C1(i),d(i));
    [alpha2, r2, K2]=anomalyTrain(data2,C2(i),d(i));
    % testingi_j: testing dataset i using model j
    testing1_1 = anomalyDetect(test1,data1,alpha1,r1,K1,d(i));
    rate1_1 = sum(testing1_1==1)/length(testing1_1);
    falsereject1= 1-rate1_1;
    testing1_2 = anomalyDetect(test1,data2,alpha2,r2,K2,d(i));
    rate1_2 = sum(testing1_2==0)/length(testing1_2);
    falseaccept2 = 1-rate1_2;
    testing2_1 = anomalyDetect(test2,data1,alpha1,r1,K1,d(i));
    rate2_1 = sum(testing2_1==0)/length(testing2_1);
    falseaccept1 = 1-rate2_1;
    testing2_2 = anomalyDetect(test2,data2,alpha2,r2,K2,d(i));
    rate2_2 = sum(testing2_2==1)/length(testing2_2);
    falsereject2 = 1-rate2_2;
    fprintf(2,'Class %f', i);
    falsereject1
    falseaccept2
    falseaccept1
    falsereject2
end

%% Plots
d = [1,2,3];
C1 = [0.047266,0.084839,0.054688];
C2 = [0.043619,0.037500,0.048438];

x2 = data2(:,1); y2 = data2(:,2);
for i=1:2
    [alpha2, r2, K2]=anomalyTrain(data2,C2(i),d(i));
    index2 = find(alpha2>1e-6);
    index2 = intersect(find(alpha2>1e-6),find(alpha2<C2(i)));
    if (i==1) support1 = [x2(index2),y2(index2)];
    else support2 = [x2(index2),y2(index2)];
    end
end

plot(data1(:,1),data1(:,2),'.'); hold on;
plot(data2(:,1),data2(:,2),'r.');
scatter(support1(:,1),support1(:,2),100,[0,0,0]);
scatter(support2(:,1),support2(:,2),100,[1,0,1]); hold off;




