function fitness = EvaluateIndividual(chromosome,functionData,numVariableRegisters,...
    constantRegisters,cMax,tooManyInstructions,penaltyForTooManyInstructions)
    
    numberOfDataPoints = length(functionData);
    numberOfInstructions = length(chromosome);
    squareError = zeros(numberOfDataPoints,1);

    for i = 1:numberOfDataPoints
        x = functionData(i,1);
        y = functionData(i,2);
        registerValues = [x, zeros(1,numVariableRegisters-1), constantRegisters];
        for j = 1:numberOfInstructions
            indexDestinationRegister = chromosome(j).indexDestinationRegister;
            registerValues(indexDestinationRegister) = ExecuteInstructions(...
                chromosome(j),registerValues,cMax);
        end
        yHat = registerValues(1);
        squareError(i) = (yHat - y) ^ 2;
    end
    e = sqrt((1/numberOfDataPoints) * sum(squareError));
    fitness = 1/e;
    if numberOfInstructions > tooManyInstructions
        numOverLimit = numberOfInstructions - tooManyInstructions;
        fitness = fitness * penaltyForTooManyInstructions ^ numOverLimit;
    end
end

