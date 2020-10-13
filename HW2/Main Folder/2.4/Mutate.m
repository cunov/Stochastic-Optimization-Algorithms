function MutatedChromosome = Mutate(Chromosome,mutationProbability,...
    numRegisters,numVariableRegisters)

    numInstructions = length(Chromosome);
    MutatedChromosome = Chromosome;
    fieldNames = fieldnames(Chromosome);
    
    for i = 1:numInstructions
        for iField = 1:length(fieldNames)
            fieldName = fieldNames{iField};
            if rand < mutationProbability
                if strcmp(fieldName,'operator')
                    MutatedChromosome(i).operator = randi(4);
                elseif strcmp(fieldName,'indexDestinationRegister')
                    MutatedChromosome(i).indexDestinationRegister = randi(numVariableRegisters);
                elseif strcmp(fieldName,'indexOperand1')
                    MutatedChromosome(i).indexOperand1 = randi(numRegisters);
                else
                    MutatedChromosome(i).indexOperand2 = randi(numRegisters);
                end
            end
        end
    end
            
end

