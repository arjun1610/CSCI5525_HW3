%function [ output_args ] = mybagging2( input_args )
%MYBAGGING2 Summary of this function goes here
%   Detailed explanation goes here
data = importdata('/home/arjun/Desktop/machinelearning-hw3/ionoshpere3.txt');
X=data(:,1:end-1);
y=data(:,end);
% get number of positive samples
a=length(find(y==1));
B=[25 50];
% numCrossVal=10;
[n, p] = size(data);
folds=10;
indices=crossvalind('Kfold', n, folds);
%partitionIndex=partitionDataIndex(data,folds);
trainError=zeros(1,length(B));
testError=zeros(1,length(B));
trainErrorPerFoldperBag(fold,i)=zeros(folds,length(B));
testErrorPerFoldperBag(fold,i)=zeros(folds,length(B));
timeMatrix=zeros(folds,length(B));
for fold=1:folds
    %divide the data indexes and fetch the train and test set in such a way
    %that it takes n equal partitions and form a test set of 1 partition
    %and a training set for remaining n-1 partitions
    XTrain = data(indices ~= fold, 1:end-1);
    yTrain = data(indices ~= fold, end);
    XTest = data(indices == fold, 1:end-1);
    yTest = data(indices == fold, end);
    for i = 1: length(B)
        tic;
        bagSize=B(i);
        [samples,features]=size(XTrain);
        classifiers=zeros(bagSize,10);
        for j = 1:bagSize
            index=randperm((samples),100);
%           index=ceil(samples*rand(ceil(0.6* samples),1));
            XT=XTrain(index,:);
            yT=yTrain(index,:);
            % returns the classifiers (Decision Trees)
            classifiers(j,:) = trainclassifiers(XT,yT);
        end
        % calculate the training and test errors
        trainError(i)=calculateError(XTrain,yTrain,classifiers);
        testError(i)=calculateError(XTest,yTest,classifiers);
        trainErrorPerFoldperBag(fold,i)=trainError(i);
        testErrorPerFoldperBag(fold,i)=testError(i);
        timespent=toc;
        %fprintf('time spent for %d bag size for fold %d: %d\n',i,fold,timespent);
        timeMatrix(fold,i)=timespent;
    end;
end
figure;
title('Error Rates vs Bag size')
xlabel('Bag Size');
ylabel('Error rate');
hold on;
plot(mean(testErrorPerFoldperBag,1));
plot(mean(trainErrorPerFoldperBag,1))
legend('mean test error rates across k folds','mean train error rates across k folds');
hold off;
