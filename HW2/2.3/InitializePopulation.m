function population = InitializePopulation(populationSize,initializationRange,...
    numberOfNeurons,numberOfInputs,numberOfOutputs)

    population = [];
    for i = 1:populationSize
        w1 = -initializationRange + 2 * initializationRange .* rand(1,numberOfNeurons*numberOfInputs);
        b1 = zeros(1,numberOfNeurons);
        layer1 = [w1 b1];
        
        w2 = -initializationRange + 2 * initializationRange .* rand(1,numberOfNeurons*numberOfOutputs);
        b2 = zeros(1,numberOfOutputs);
        layer2 = [w2 b2];
        
        population = [population; [layer1 layer2]];
    end
end

