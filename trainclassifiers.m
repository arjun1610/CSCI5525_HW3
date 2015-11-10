function [featuresInfoGain, selectedFeature]= trainclassifiers( X, y )

%TRAINCLASSIFIERS Summary of this function goes here
%   Detailed explanation goes here
[samples,features]=size(X);
classEntropy=getClassEntropy(y);
featuresInfoGain=zeros(1,features);
splitValues=zeros(1,features);
maxFeatureEntropy=0;
for i = 1 : features
    %calculate the mean of the feature
    
    
    %split on the mean
%     mu=mean(X(:,i));
%     [index,~]=find(X(:,i)>=mu);  
%     positive=length(index);
%     negative=samples-positive;
%     
%     positiveclass1=length(find(y(index)==1)); %positive samples class1 
%     positiveclass2=length(find(y(index)~=1)); %positive samples class2
%     
%     negativeclass1=length(class1index)-positiveclass1;
%     negativeclass2=length(class2index)-positiveclass2;
%     
%     conditionalEntropyLeft=calculateEntropy(positiveclass1, positiveclass2);
%     conditionalEntropyRight=calculateEntropy(negativeclass1, negativeclass2);
%     
%     totalCondEntropy=positive/samples*conditionalEntropyLeft + negative/samples*conditionalEntropyRight;
%    
%     %first calculate the Information Gain on the first level of the
%     %Decision tree
%     InfGain(i)= classEntropy - totalCondEntropy;

%feature i for all samples 
A=sort(X(:,i));
maxEntropy = 0;
splitValue = 0;
for j=1:length(A)-1
    value=(A(j)+A(j+1))/2;
    entropy=getFeatureEntropy(value,X(:,i),y);
    FeatureGain1=classEntropy-entropy;
    if(FeatureGain1 > maxEntropy) 
        splitValue = value;
        maxEntropy = FeatureGain1;
    end
end

if(maxEntropy > maxFeatureEntropy)
    maxFeatureEntropy=maxEntropy;
    maxSplitValue=splitValue;
end

% featuresInfoGain(i)=maxEntropy;
% splitValues(i)=splitValue;


end

% selectedFeature tells the index at which the IG was highest
% [~,selectedFeature]=max(featuresInfoGain);

end
