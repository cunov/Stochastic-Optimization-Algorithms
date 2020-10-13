function mutatedChromosome = CreepMutate(chromosome,creepMutationProbability,...
    creepMutationRange,variableRange)
    
    for i = 1:length(chromosome)
        if rand < creepMutationProbability
            gene = chromosome(i);
            mutationValue = -creepMutationRange + 2*rand*creepMutationRange;
            gene = gene + mutationValue;
            if gene > variableRange
                gene = variableRange;
            elseif gene < -variableRange
                gene = -variableRange;
            end
            chromosome(i) = gene;
        end
    end
    mutatedChromosome = chromosome;
end

