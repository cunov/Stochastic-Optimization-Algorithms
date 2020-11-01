numberOfVariables = 2;
populationSize = 200;
numberOfGenes = 50;
crossoverProbability = 0.8;
mutationProbability = .05;
tournamentSelectionParameter = 0.75;
tournamentSize = 2;
variableRange = 10;
numberOfGenerations = 200;
numberOfCopies = 1;

fitness = zeros(populationSize,1);
population = InitializePopulation(populationSize, numberOfGenes);
maximumFitness = 0;
xBest = zeros(1,2);
for iGeneration = 1:numberOfGenerations
    for i = 1:populationSize
        chromosome = population(i,:);
        x = DecodeChromosome(chromosome, numberOfVariables, variableRange);
        decodedPopulation(i,:) = x;
        fitness(i) = EvaluateIndividual(x);
        if (fitness(i) > maximumFitness)
            maximumFitness = fitness(i);
            bestIndividual = population(i,:);
            xBest = x;
        end
    end

    tempPopulation = population;
    for i = 1:2:populationSize
        i1 = TournamentSelect(fitness,tournamentSelectionParameter,tournamentSize);
        i2 = TournamentSelect(fitness,tournamentSelectionParameter,tournamentSize);
        chromosome1 = population(i1,:);
        chromosome2 = population(i2,:);
        r = rand;
        if (r < crossoverProbability)
            newChromosomePair = Cross(chromosome1,chromosome2);
            tempPopulation(i,:) = newChromosomePair(1,:);
            tempPopulation(i+1,:) = newChromosomePair(2,:);
        else
            tempPopulation(i,:) = chromosome1;
            tempPopulation(i+1,:) = chromosome2;
        end
    end
    for i = 1:populationSize
        originalChromosome = tempPopulation(i,:);
        mutatedChromosome = Mutate(originalChromosome,mutationProbability);
        tempPopulation(i,:) = mutatedChromosome;
    end
    population = InsertBestIndividual(tempPopulation,bestIndividual,numberOfCopies);
end

disp('Global minimum found at:')
disp(round(xBest,3))
disp("Global minimum:")
disp(round(1/EvaluateIndividual(xBest),3))
