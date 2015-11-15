function errorPerFoldPerBag = myBagging2( filename, B, k)
%MYBAGGING2  This is the main file of the bagging method
%   takes the input as filename (data), B = [5 10 15 20] (bagsize), and K=
%   number of folds
% This outputs the 22*10 table with training and Test error rates with each
% K folds and across the values of B. The last two rows are mean and
% standard deviation of the error rates across the fold

data = importdata(filename);
[n, ~] = size(data);
folds=k;
indices=crossvalind('Kfold', n, folds);
trainErrorPerFoldPerBag=zeros(folds,length(B));
testErrorPerFoldPerBag=zeros(folds,length(B));
timeMatrix=zeros(folds,length(B));
for fold=1:folds
    XTrain = data(indices ~= fold, 1:end-1);
    yTrain = data(indices ~= fold, end);
    XTest = data(indices == fold, 1:end-1);
    yTest = data(indices == fold, end);
    for i = 1: length(B)
        tic;
        bagSize=B(i);
        [samples,~]=size(XTrain);
        classifiers=zeros(bagSize,10);
        for j = 1:bagSize
            % bootstrap sampling here
            index=randsample(samples,samples,true);
            XT=XTrain(index,:);
            yT=yTrain(index,:);
            % returns the classifiers (Decision Trees)
            classifiers(j,:) = trainclassifiers(XT,yT);
        end
        % calculate the training and test errors
        trainError=calculateError(XTrain,yTrain,classifiers);
        testError=calculateError(XTest,yTest,classifiers);
        trainErrorPerFoldPerBag(fold,i)=trainError;
        testErrorPerFoldPerBag(fold,i)=testError;
        errorPerFoldPerBag(2*fold-1,i)=trainError;
        errorPerFoldPerBag(2*fold,i)=testError;
        timespent=toc;
        timeMatrix(fold,i)=timespent;
    end;
end

%printing out the values to the terminal
for bag=1:length(B)
    bagSize=B(bag);
    for fold=1:folds
        fprintf('Train error for fold %d with %d base classifiers: %f\n',fold, bagSize, errorPerFoldPerBag(2*fold-1,bag));
        fprintf('Test error for fold %d with %d base classifiers : %f\n',fold, bagSize, errorPerFoldPerBag(2*fold,bag));
    end
    fprintf('-------------------------------------------------------------\n');
end
%the mean and standard deviation of the train and test error rates for
%each bag
for bag =1: length(B)
    errorPerFoldPerBag(2*folds+1,bag)=mean(errorPerFoldPerBag(:,bag));
    errorPerFoldPerBag(2*folds+2,bag)=std(errorPerFoldPerBag(:,bag));
end
% plotting the figure
figure;
title('BAGGING: Error Rate Percentages vs Bag size')
xlabel('Bag Size');
ylabel('Error percentages');
hold on;
plot(B,mean(testErrorPerFoldPerBag,1)*100);
plot(B,mean(trainErrorPerFoldPerBag,1)*100)
legend('mean test error percentages across k folds','mean train error percentages across k folds');
hold off;

end