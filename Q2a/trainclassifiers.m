function classifier = trainclassifiers( X, y)

%TRAINCLASSIFIERS Summary of this function goes here
%   Detailed explanation goes here
%first level split
[~, splitValue0, featureIndex0, xLeft0, xRight0, yLeft0, yRight0] = getFeatureForSplit(X,y,0);
% second level split
if ~isempty(xLeft0) && ~isempty(xRight0) 
    % for left side
    [~, splitValue1, featureIndex1, ~, ~, yLeft1, yRight1] = getFeatureForSplit(xLeft0, yLeft0, 1);
    % assign class labels
    if featureIndex1 ==0
        %set pure class labels
        if isempty(yLeft0(yLeft0==-1))
            labelsLeftLeft=1;
            labelsLeftRight=1;
        elseif isempty(yLeft0(yLeft0==1))
            labelsLeftLeft=-1;
            labelsLeftRight=-1;
        end
    else
        % do majority voting
        if length(yLeft1(yLeft1==1))>length(yLeft1(yLeft1==-1))
            labelsLeftLeft=1;
        else
            labelsLeftLeft=-1;
        end
        %majority -put equals to
        if length(yRight1(yRight1==1))>length(yRight1(yRight1==-1))
            labelsLeftRight=1;
        else
            labelsLeftRight=-1;
        end
    end
    % for right side 
    [~, splitValue2, featureIndex2, ~, ~, yLeft2, yRight2] = getFeatureForSplit(xRight0, yRight0, 1);
    % assign class labels 
    if featureIndex2 == 0
        %set pure class labels
        if isempty(yRight0(yRight0 == -1))
            labelsRightLeft=1;
            labelsRightRight=1;
        elseif isempty(yRight0(yRight0 == 1))
            labelsRightLeft=-1;
            labelsRightRight=-1;
        end
    else
        % do majority voting 
        if length(yLeft2(yLeft2==1))>length(yLeft2(yLeft2==-1))
            labelsRightLeft=1;
        else
            labelsRightLeft=-1;
        end
        % greater than eq2
        if length(yRight2(yRight2==1))>length(yRight2(yRight2==-1))
            labelsRightRight=1;
        else
            labelsRightRight=-1;
        end
    end
end
% storing it in a matrix- the tree consists of the following nodes
classifier = [featureIndex0, splitValue0, featureIndex1, splitValue1, labelsLeftLeft, labelsLeftRight, featureIndex2, splitValue2, labelsRightLeft, labelsRightRight];
end