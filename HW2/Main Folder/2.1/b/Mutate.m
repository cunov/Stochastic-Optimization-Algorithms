function mutatedChromosome = Mutate(chromosome,mutationProbability)
    nGenes = length(chromosome);
    mutatedChromosome = chromosome(1:end-1);
    for j=1:nGenes-1
        if rand<mutationProbability
            iGeneToSwap = randi(nGenes-1);
            jthGeneValue = mutatedChromosome(j);
            mutatedChromosome(j) = mutatedChromosome(iGeneToSwap);
            mutatedChromosome(iGeneToSwap) = jthGeneValue;
        end
    end
    mutatedChromosome(nGenes) = mutatedChromosome(1);
end

