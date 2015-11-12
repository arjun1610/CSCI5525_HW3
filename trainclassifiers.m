function classifier = trainclassifiers( X, y)

%TRAINCLASSIFIERS Summary of this function goes here
%   Detailed explanation goes here
%first level split
[~, splitValue0, featureIndex0, xLeft0, xRight0, yLeft0, yRight0] = getFeatureForSplit(X,y,0);

% second level split
if ~isempty(xLeft0) && ~isempty(xRight0) 
    % for left side
    [~, splitValue1, featureIndex1, ~, ~, yLeft1, yRight1] = getFeatureForSplit(xLeft0(:,~ismember((1:size(xLeft0,2)),featureIndex0)), yLeft0, 1);
    
    % assign class labels
    if featureIndex1 ==0
        %set pure class labels
        if isempty(yLeft1(yLeft1==-1))
            labelsLeftLeft=1;
            labelsLeftRight=1;
        elseif isempty(yLeft1(yLeft1==1))
            %maxLabelRight/Left
            labelsLeftLeft=-1;
            labelsLeftRight=-1;
        end
    else
        % do majority voting by mode
%         if length(yLeft1(yLeft1==1))>=length(yLeft1(yLeft1==-1))
%             labelsLeftLeft=1;
%         else
%             labelsLeftLeft=-1;
%         end
%         %majority -put equals to
%         if length(yRight1(yRight1==1))>=length(yRight1(yRight1==-1))
%             labelsLeftRight=1;
%         else
%             labelsLeftRight=-1;
%         end
        labelsLeftLeft=mode(yLeft1);
        labelsLeftRight=mode(yRight1);
    end
    
    % for right side 
    [~, splitValue2, featureIndex2, ~, ~, yLeft2, yRight2] = getFeatureForSplit(xRight0(:,~ismember((1:size(xRight0,2)),featureIndex0)), yRight0, 1);
    % assign class labels 
    if featureIndex2 == 0
        %set pure class labels
        if isempty(yRight2(yRight2 == -1))
            labelsRightLeft=1;
            labelsRightRight=1;
        elseif isempty(yRight2(yRight2 == 1))
            labelsRightLeft=-1;
            labelsRightRight=-1;
        end
    else
        % do majority voting by mode
%         if length(yLeft2(yLeft2==1))>=length(yLeft2(yLeft2==-1))
%             labelsRightLeft=1;
%         else
%             labelsRightLeft=-1;
%         end
%         %majority -put equals to
%         if length(yRight2(yRight2==1))>=length(yRight2(yRight2==-1))
%             labelsRightRight=1;
%         else
%             labelsRightRight=-1;
%         end
        labelsRightLeft=mode(yLeft2);
        labelsRightRight=mode(yRight2);
    end
end
% storing it in a matrix- the tree consists of the following nodes
classifier = [featureIndex0, splitValue0, featureIndex1, splitValue1, labelsLeftLeft, labelsLeftRight, featureIndex2, splitValue2, labelsRightLeft, labelsRightRight];
end