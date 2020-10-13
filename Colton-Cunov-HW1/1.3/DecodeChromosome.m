function x = DecodeChromosome(chromosome,numVariables,variableRange)
    numGenes = length(chromosome);
    numBits = numGenes/numVariables;
    if floor(numBits) ~= numBits
        error('numBits = numGenes/numVariables = k = m/n is not an integer')
    end
    x = zeros(numVariables,1);

    for i = 1:numVariables
        iExponent = 1;
        for j = 1+numBits*(i-1) : i*numBits
            x(i) = x(i) + chromosome(j)*2^(-iExponent);
            iExponent = iExponent + 1;
        end
        x(i) = -variableRange + 2*variableRange*x(i)/(1-2^(-numBits));
    end
end