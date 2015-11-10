%function [ output_args ] = mybagging2( input_args )
%MYBAGGING2 Summary of this function goes here
%   Detailed explanation goes here
data = importdata('/home/arjun/Desktop/machinelearning-hw3/ionoshpere3.txt');
data={data};
X={data{1}(:,1:end-1)};
y={data{1}(:,end)};
% get number of positive samples
a=length(find(y{1}==1));
B=[5];
% numCrossVal=10;
[n, p] = size(data{1});
% indices=crossvalind('Kfold', n, numCrossVal);
% Y = data{1}(indices ~= 1, end);
% X = data{1}(indices ~= 1, 1:end-1);        
% folds=10;
% partitionIndex=partitionDataIndex(data{1},folds);
% for j=1:folds
%     %divide the data indexes and fetch the train and test set in such a way
%     %that it takes n equal partitions and form a test set of 1 partition
%     %and a training set for remaining n-1 partitions        
%     TestSet=data{1}(partitionIndex(j,:),:);
%     TrainSet=data{1}(partitionIndex(~ismember(1:folds,j),:),:);
% end
for i = 1: length(B)
    bagSize=B(i);
    classifiers=cell(1,bagSize);
    for j = 1:bagSize
        index=ceil(n*rand(20,1));
        XTrain=X{1}(index,:);
        yTrain=y{1}(index,:);
        [Gain{j},featureIndex(j)]=trainclassifiers(XTrain,yTrain);
    end
end

%end
