function [layerOneWts, layerOneBiases, layerTwoWts, layerTwoBiases] = DecodeChromosome(chromosome,...
    numberOfNeurons,numberOfInputs,numberOfOutputs)

    layerOne = chromosome(1 : numberOfNeurons * (numberOfInputs + 1) );
    sizeOfLayerOne = length(layerOne);
    
    layerOneWts = layerOne(1 : numberOfNeurons * numberOfInputs);
    layerOneWts = reshape(layerOneWts,numberOfInputs,numberOfNeurons);
    layerOneBiases = layerOne(numberOfNeurons * numberOfInputs + 1 : sizeOfLayerOne);
    
    layerTwo = chromosome(sizeOfLayerOne + 1 : end);
    
    layerTwoWts = layerTwo(1 : numberOfNeurons * numberOfOutputs);
    layerTwoWts = reshape(layerTwoWts,numberOfNeurons,numberOfOutputs);
    layerTwoBiases = layerTwo(numberOfNeurons * numberOfOutputs + 1 : end);
end

