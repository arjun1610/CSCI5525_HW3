function [indices]= partitionDataIndex(data, folds)
% this function creates a folds*partitionsize matrix which have indexes
% arranged in serial order. It creates equal partition of the data set
m= size(data,1);
partitionSize=floor(m/10);
startingIndex=1;
endingIndex=partitionSize;
indices=zeros(folds,partitionSize);
%define size of the partitioned matrix
for i=1:folds
    indices(i,:)=startingIndex:endingIndex;
    startingIndex=endingIndex+1;
    endingIndex=endingIndex+partitionSize;
end;
end