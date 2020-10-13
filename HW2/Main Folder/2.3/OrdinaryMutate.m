function mutatedChromosome = OrdinaryMutate(chromosome,mutationProbability,variableRange)

    for i = 1:length(chromosome)
        if rand < mutationProbability
            newGene = -variableRange + 2*rand*variableRange;
            chromosome(i) = newGene;
        end
    end
    
    mutatedChromosome = chromosome;
end

