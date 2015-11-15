function [totalCondEntropy, index1, index2] = getRFeatureEntropy( value, X, y )
%GETRFEATUREENTROPY  This returns the entropy value with the given split value and
%the data.

index1=find(X>=value);
index2=find(X<value);
samples=size(X,1);
if isempty(index1) || isempty(index2)
    totalCondEntropy=0;

    
else
    labelsLeft = y(index1);
    labelsRight = y(index2);
    
    positiveLabelsLeft = length(find(labelsLeft==1));
    negativeLabelsLeft = length(find(labelsLeft~=1));
    
    positiveLabelsRight = length(find(labelsRight==1));
    negativeLabelsRight = length(find(labelsRight~=1));
    
    conditionalEntropyLeft=calculateREntropy(positiveLabelsLeft, negativeLabelsLeft);
    conditionalEntropyRight=calculateREntropy(positiveLabelsRight, negativeLabelsRight);
    totalCondEntropy=length(labelsLeft)/samples*conditionalEntropyLeft + length(labelsRight)/samples*conditionalEntropyRight;
end
end