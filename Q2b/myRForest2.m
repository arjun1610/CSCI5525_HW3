function errorPerFoldPerFeature = myRForest2( filename, M, k )
%MYRFOREST2  This is the main file of the Random Forest method
%   takes the input as filename (data), M =1:34 (Features size), and K=
%   number of folds
% This outputs the 22*34 table with training and Test error rates with each
% K folds and across the values of M. The last two rows are mean and
% standard deviation of the error rates across the fold

data = importdata(filename);
[n, ~] = size(data);
folds=k;
indices=crossvalind('Kfold', n, folds);
trainErrorPerFoldPerFeature=zeros(folds,length(M));
testErrorPerFoldPerFeature=zeros(folds,length(M));
timeMatrix=zeros(length(M),folds);
for fold=1:folds
    XTrain = data(indices ~= fold, 1:end-1);
    yTrain = data(indices ~= fold, end);
    XTest = data(indices == fold, 1:end-1);
    yTest = data(indices == fold, end);
    % each element of M decides the no. of features to be used in the data
    for i = 1: length(M)
        tic;
        bagSize=100;
        [samples,~]=size(XTrain);
        classifiers=zeros(bagSize,10);
        for j = 1:bagSize
            index=randsample(samples,samples,true);
            XT=XTrain(index,:);
            yT=yTrain(index,:);
            % returns the classifiers (Decision Trees)
            classifiers(j,:) = trainRFclassifiers(XT, yT, M(i));
        end
        % calculate the training and test errors
        trainError=calculateRError(XTrain,yTrain,classifiers);
        testError=calculateRError(XTest,yTest,classifiers);
        trainErrorPerFoldPerFeature(fold,i)=trainError;
        testErrorPerFoldPerFeature(fold,i)=testError;
        errorPerFoldPerFeature(2*fold-1,i)=trainError;
        errorPerFoldPerFeature(2*fold,i)=testError;
        timespent=toc;
        timeMatrix(fold,i)=timespent;
    end;
end
%printing out the values to the terminal
for f=1:length(M)
    featureSize=M(f);
    for fold=1:folds
        fprintf('Train error for fold %d with %d random features : %f\n',fold, featureSize, errorPerFoldPerFeature(2*fold-1,f));
        fprintf('Test error for fold %d with %d random features : %f\n',fold, featureSize, errorPerFoldPerFeature(2*fold,f));
    end
    fprintf('-------------------------------------------------------------\n');
end
%the mean and standard deviation of the train and test error rates for
%each feature
for feature =1: length(M)
    errorPerFoldPerFeature(2*folds+1,feature)=mean(errorPerFoldPerFeature(:,feature));
    errorPerFoldPerFeature(2*folds+2,feature)=std(errorPerFoldPerFeature(:,feature));
end
% plotting the figure
figure;
title('RANDOM FOREST: Error percentages vs no. of Random Features')
xlabel('No. of Random Features');
ylabel('Error percentages');
hold on;
plot(M,mean(testErrorPerFoldPerFeature,1)*100);
plot(M,mean(trainErrorPerFoldPerFeature,1)*100);
legend('mean test error rates across k folds','mean train error rates across k folds');
hold off;

end