function value = calculateEntropy(positive, negative)
% CALCULATEENTROPY - This function is used to calculate the entropy value
% if we have pure populations we have zero entropy at that value
total=positive+negative;
if total== 0 
    value= 0;
    return ;
end    

positiveFraction=positive/total;
negativeFraction=negative/total;
if positiveFraction~=0 && negativeFraction~=0
    value= -(positiveFraction*log2(positiveFraction)+negativeFraction*log2(negativeFraction));
elseif positiveFraction==0 
    value= 0;
elseif negativeFraction==0 
    value= 0;
end
end