function value = calculateEntropy(positive, negative)

total=positive+negative;
if total== 0 
    value= 0;
    return 
end    

positiveFraction=positive/total;
negativeFraction=negative/total;
if positiveFraction~=0 && negativeFraction~=0 
    value= -(positiveFraction*log2(positiveFraction)+negativeFraction*log2(negativeFraction));
elseif positiveFraction==0 
    value= -(negativeFraction*log2(negativeFraction));
elseif negativeFraction==0 
    value= -(positiveFraction*log2(positiveFraction));
end
end