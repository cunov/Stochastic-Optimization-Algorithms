function [pedalPressure, shiftRequest] = ANN(vRatio, alphaRatio, brakeTempRatio,...
    chromosome,numberOfNeurons,numberOfInputs,numberOfOutputs)

    inputs = [vRatio, alphaRatio, brakeTempRatio];
    
    [firstLayerWeights, firstLayerBiases, secondLayerWeights, secondLayerBiases] = ...
        DecodeChromosome(chromosome,numberOfNeurons,numberOfInputs,numberOfOutputs);
    
    weightedSum = inputs * firstLayerWeights;
    localField = weightedSum - firstLayerBiases;
    firstLayerActivation = 1 ./ (1 + exp(-localField));
  
    weightedSum = firstLayerActivation * secondLayerWeights;
    localField = weightedSum - secondLayerBiases;
    outputs = 1 ./ (1 + exp(-localField));
    
    pedalPressure = outputs(1);
    shiftRequest = outputs(2);
end

