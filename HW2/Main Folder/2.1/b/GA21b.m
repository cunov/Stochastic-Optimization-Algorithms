clear all;
cla reset;
cityLocations = LoadCityLocations();
N = length(cityLocations);
populationSize = 200;
mutationProbability = .03;
tournamentSelectionParameter = 0.75;
tournamentSize = 8;
numberOfGenerations = 2500;
maximumFitness = 0;

fitness = zeros(populationSize,1);
tspFigure = InitializeTspPlot(cityLocations,[0 20 0 20]);
connection = InitializeConnections(cityLocations);
bestPath = zeros(N+1);

population = InitializePopulation(populationSize,N);

for iGeneration=1:numberOfGenerations
    for i=1:populationSize
        chromosome = population(i,:);
        fitness(i) = EvaluateIndividual(chromosome,cityLocations);
        if fitness(i) > maximumFitness
            maximumFitness = fitness(i);
            bestPath = population(i,:);
            indexBestPath = i;
            PlotPath(connection,cityLocations,bestPath);
        end
    end
    tempPopulation = population;
    for i=1:2:populationSize
        i1 = TournamentSelect(fitness,tournamentSelectionParameter,tournamentSize);
        i2 = TournamentSelect(fitness,tournamentSelectionParameter,tournamentSize);
        chromosome1 = population(i1,:);
        chromosome2 = population(i2,:);
        tempPopulation(i,:) = chromosome1;
        tempPopulation(i+1,:) = chromosome2;
    end
    for i = 1:populationSize
        originalChromosome = tempPopulation(i,:);
        mutatedChromosome = Mutate(originalChromosome,mutationProbability);
        tempPopulation(i,:) = mutatedChromosome;
    end
    tempPopulation(1,:) = population(indexBestPath,:);
    population = tempPopulation;
end
disp('Maximum Fitness:')
disp(maximumFitness)
disp('Shortest Path Length:')
disp(1/maximumFitness)
fmt = ['Best Path:\n' repmat(' %1.0f',1,numel(bestPath)) '\n'];
fprintf(fmt,bestPath)
