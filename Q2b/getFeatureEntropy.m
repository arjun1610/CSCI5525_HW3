function [totalCondEntropy, index1, index2] = getFeatureEntropy( value, X, y )
%SPLITFEATURE Summary of this function goes here
%   Detailed explanation goes here

index1=find(X>=value);
index2=find(X<value);
samples=size(X,1);
if isempty(index1) || isempty(index2)
    totalCondEntropy=0;
    index1=[];
    index2=[];
    
else
    labelsLeft = y(index1);
    labelsRight = y(index2);
    
    positiveLabelsLeft = length(find(labelsLeft==1));
    negativeLabelsLeft = length(find(labelsLeft~=1));
    
    positiveLabelsRight = length(find(labelsRight==1));
    negativeLabelsRight = length(find(labelsRight~=1));
    
    conditionalEntropyLeft=calculateEntropy(positiveLabelsLeft, negativeLabelsLeft);
    conditionalEntropyRight=calculateEntropy(positiveLabelsRight, negativeLabelsRight);
    totalCondEntropy=length(labelsLeft)/samples*conditionalEntropyLeft + length(labelsRight)/samples*conditionalEntropyRight;
end
end