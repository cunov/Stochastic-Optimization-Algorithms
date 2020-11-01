clear all
numVariableRegisters = 4;
constantRegisterSet = [-.8];
numOperators = 4;
cMax = 100000;
numberOfGenerations = 10000;
populationSize = 100;
tournamentSelectionParameter = 0.75;
tournamentSize = 5;
crossOverProbability = .2;
initialMutationConstant = 3;
initialInstructionLengthRange = [3 10];
tooManyInstructions = 30;
penaltyForTooManyInstructions = .90;

numConstantRegisters = length(constantRegisterSet);
numRegisters = numVariableRegisters + numConstantRegisters;
functionData = LoadFunctionData();

maximumFitness = zeros(numberOfGenerations,1);
fitness = zeros(populationSize,1);

population = InitializePopulation(populationSize,numOperators,...
    numVariableRegisters,numConstantRegisters,initialInstructionLengthRange);
for iGeneration = 1:numberOfGenerations
    for iPopulation = 1:populationSize
        Chromosome = population{iPopulation};
        fitness(iPopulation) = EvaluateIndividual(Chromosome,functionData,...
            numVariableRegisters,constantRegisterSet,cMax,...
            tooManyInstructions,penaltyForTooManyInstructions);
        
        if fitness(iPopulation) > maximumFitness(iGeneration)
            maximumFitness(iGeneration) = fitness(iPopulation);
            iBestIndividual = iPopulation;
            bestIndividual = Chromosome;
        end
    end
    
    tempPopulation = population;
    for i = 1:2:populationSize
        i1 = TournamentSelect(fitness,tournamentSelectionParameter,tournamentSize);
        i2 = TournamentSelect(fitness,tournamentSelectionParameter,tournamentSize);
        Chromosome1 = population{i1};
        Chromosome2 = population{i2};
        if rand < crossOverProbability
            [NewChromosome1, NewChromosome2] = Cross(Chromosome1,Chromosome2);
            tempPopulation{i} = NewChromosome1;
            tempPopulation{i+1} = NewChromosome2;
        else
            tempPopulation{i} = Chromosome1;
            tempPopulation{i+1} = Chromosome2;
        end        
    end
    
    pctGeneration = (numberOfGenerations - iGeneration) / numberOfGenerations;
    decayedMutationRate = pctGeneration * initialMutationConstant;
    for i = 1:populationSize
        OriginalChromosome = tempPopulation{i};
        chromosomeLength = length(OriginalChromosome) * 4;
        mutationProbability = decayedMutationRate / chromosomeLength;
        MutatedChromosome = Mutate(OriginalChromosome,mutationProbability,numRegisters,numVariableRegisters);
        tempPopulation{i} = MutatedChromosome;
    end
    tempPopulation{1} = population{iBestIndividual};
    population = tempPopulation;
end