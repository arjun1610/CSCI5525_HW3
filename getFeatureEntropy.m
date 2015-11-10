function totalCondEntropy = getFeatureEntropy( value, X, y )
%SPLITFEATURE Summary of this function goes here
%   Detailed explanation goes here

index1=find(X>=value);
index2=find(X<value);
samples=size(X,1);
%not required as of now
samplesRight=X(index1);
samplesLeft=X(index2);

labelsRight = y(index1);
labelsLeft = y(index2);

positiveLabelsLeft = length(find(labelsLeft==1));
negativeLabelsLeft = length(find(labelsLeft~=1));
positiveLabelsRight = length(find(labelsRight==1));
negativeLabelsRight = length(find(labelsRight~=1));

conditionalEntropyLeft=calculateEntropy(positiveLabelsLeft, negativeLabelsLeft);
conditionalEntropyRight=calculateEntropy(positiveLabelsRight, negativeLabelsRight);
totalCondEntropy=length(labelsLeft)/samples*conditionalEntropyLeft + length(labelsRight)/samples*conditionalEntropyRight;

end