clear all
functionData = LoadFunctionData();
xData = functionData(:,1);
yData = functionData(:,2);

bestChromosome = BestChromosome();
constantRegisterSet = [-.8];
numVariableRegisters = 4;

[fSym, fStr] = GenerateFinalFunction(bestChromosome,constantRegisterSet,numVariableRegisters);

numberOfDataPoints = length(xData);
yHat = zeros(numberOfDataPoints,1);

syms x
for i = 1:numberOfDataPoints
    x = xData(i);
    yHat(i) = subs(fSym);
end
sqrError = (yHat - yData) .^ 2;
sumSqrError = sum(sqrError);
rmsError = sqrt((1/numberOfDataPoints) * sumSqrError);

plot(xData,yData,'b.',xData,yHat,'r.');
title({'Original function values shown in blue','LGP-evaluated values shown in red'})
fprintf('\ng(x) = %s',fStr);
fprintf('\nRMS Error = %d\n\n',rmsError)