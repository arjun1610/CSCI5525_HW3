function [maxFeatureEntropy, maxSplitValue, maxFeatureIndex, maxDataLeft, maxDataRight, maxYLeft, maxYRight]= getFeatureForSplit( X, y, featureExclude, level )

%GETFEATUREFORSPLIT This method is used to get the best feature by
%calculating the information gain and returns the split value at which the
% IG was highest. Apart from this, it also returns the two splitted
% populations (data and labels) as left and right

[~,features]=size(X);

maxFeatureEntropy=0;

table=tabulate(y);
probabilities=table(:,3)/100;
classEntropy=-sum(probabilities.*log2(probabilities));

% on the 2nd split if we have pure nodes of a class
%probabilities(1) has the probability of -1 
%probabilities(2) has the probability of 1

if level==1 && (probabilities(1)== 1)
    maxFeatureIndex=0;
    maxSplitValue=-1;
    maxFeatureEntropy=0;
    maxDataLeft=[];
    maxDataRight=[];
    maxYRight=[];
    maxYLeft=[];

elseif level ==0 || ( level==1 && probabilities(1)~= 0 )
    for i = 1 : features
        % exclude the selected feature in the root node
        if i==featureExclude
            continue;
        end
        A=unique(X(:,i));
        % if there is only 1 unique element in the sorted array
        if length(A)==1
            A= repmat(A,2,1);
        end    
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
                dataLeft=X(indexLeft,:);
                dataRight=X(indexRight,:);
                %with the corresponding indexs
                yLeft=y(indexLeft);
                yRight=y(indexRight);
            end
        end
        if(maxEntropy > maxFeatureEntropy)
            maxFeatureEntropy=maxEntropy;
            maxFeatureIndex=i;
            maxSplitValue=splitValue;
            maxDataLeft=dataLeft;
            maxDataRight=dataRight;
            maxYLeft=yLeft;
            maxYRight=yRight;
        end
    end
end
end
