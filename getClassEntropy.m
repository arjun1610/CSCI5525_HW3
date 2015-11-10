function entropy= getClassEntropy(y)

entropy=0;
table=tabulate(y);
probabilities=table(:,3)/100;
entropy=-sum(probabilities.*log2(probabilities));

end
