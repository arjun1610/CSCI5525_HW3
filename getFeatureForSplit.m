function [maxFeatureEntropy, maxSplitValue, maxFeatureIndex, maxDataLeft, maxDataRight, maxYLeft, maxYRight]= getFeatureForSplit( X, y, level )

%GETFEATUREFORSPLIT Summary of this function goes here
%   Detailed explanation goes here
% returning
%
%

[~,features]=size(X);

maxFeatureEntropy=0;
maxFeatureIndex=0;
maxSplitValue=0;
table=tabulate(y);
probabilities=table(:,3)/100;
classEntropy=-sum(probabilities.*log2(probabilities));

% on the 2nd split if we have pure nodes of a class
%probabilities(1) has the probability of -1 
%probabilities(2) has the probability of 1

if level==1 && (probabilities(1)== 1)
    maxFeatureIndex=0;
    %potential problem
    maxSplitValue=-1;
    maxFeatureEntropy=0;
    maxDataLeft=[];
    maxDataRight=[];
    maxYRight=[];
    maxYLeft=[];

elseif level ==0 || ( level==1 && probabilities(1)~= 0 )
    for i = 1 : features
        %feature i for all samples
        A=sort(X(:,i));
        maxEntropy = 0;
        splitValue = 0;
        for j=1:length(A)-1
            value=(A(j)+A(j+1))/2;
            [entropy, indexLeft, indexRight]=getFeatureEntropy(value,X(:,i),y);
            % neglecting if we dont have any branch on either left or right
            % side
            if isempty(indexLeft)|| isempty(indexRight)
                continue;
            end
            FeatureGain1=classEntropy-entropy;
            if(FeatureGain1 > maxEntropy)
                splitValue = value;
                maxEntropy = FeatureGain1;
                %with all the features
                dataLeft=X(indexLeft,:);
                dataRight=X(indexRight,:);
                %with the corresponding indexs
                yRight=y(indexRight);
                yLeft=y(indexLeft);
            end
        end
        if(maxEntropy > maxFeatureEntropy)
            maxFeatureEntropy=maxEntropy;
            maxFeatureIndex=i;
            maxSplitValue=splitValue;
            maxDataLeft=dataLeft;
            maxDataRight=dataRight;
            maxYRight=yRight;
            maxYLeft=yLeft;
        end
    end
end
% include test data
% include train data
end
