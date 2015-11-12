function [ errorFraction ] = calculateError( X,y, classifiers )
%CALCULATEERROR Summary of this function goes here
%   Detailed explanation goes here
error=0;
for sample=1: size(X,1)
    predictedLabel=[];
    for classifier =1 : size(classifiers,1)
        % if the Xvalue at the kth feature is >= split value
        if X(sample,round(classifiers(classifier,1)))>=classifiers(classifier,2)
            if round(classifiers(classifier,3))==0
                predictedLabel = [predictedLabel classifiers(classifier,5)];
            else
                if X(sample,round(classifiers(classifier,3)))>=classifiers(classifier,4)
                    predictedLabel=[predictedLabel classifiers(classifier,5)];
                else
                    predictedLabel=[predictedLabel classifiers(classifier,6)];
                end
            end
        else
            if round(classifiers(classifier,7))==0
                predictedLabel = [predictedLabel classifiers(classifier,9)];
            else
                if X(sample,round(classifiers(classifier,7)))>=classifiers(classifier,8)
                    predictedLabel=[predictedLabel classifiers(classifier,9)];
                else
                    predictedLabel=[predictedLabel classifiers(classifier,10)];
                end
            end
        end
    end
    % do majority voting for all the classifiers
%     votedPredLabel=mode(predictedLabel);
            if mean(predictedLabel)>=0
                votedPredLabel=1;
            else
                votedPredLabel=-1;
            end
    if votedPredLabel ~= y(sample)
        error=error+1;
    end
end
errorFraction=error/size(X,1);
end

