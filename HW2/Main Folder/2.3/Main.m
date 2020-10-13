%%%%% PROBLEM-SPECIFIC PARAMETERS %%%%%
Params = LoadProblemSpecificParameters();
gearRatio = Params.gearRatio;
truckMass = Params.truckMass;
tau = Params.tau;
cH = Params.cH;
ambientTemp = Params.ambientTemp;
gravity = Params.G;
cB = Params.cB;
vMax = Params.vMax;
vMin = Params.vMin;
brakeTempMax = Params.brakeTempMax;
trackLength = Params.L;
alphaMax = Params.alphaMax;
timeStep = Params.timeStep;
initialVelocity = Params.initialVelocity;
initialPosition = Params.initialPosition;
initialBrakeTemp = Params.initialBrakeTemp;
initialGear = Params.initialGear;
%%%%%% NEURAL NETWORK PARAMETERS %%%%%%
numberOfNeurons = 7;
variableRange = 5;
initializationRange = 1;
lowerShiftBound = .3;
upperShiftBound = .7;
numberOfInputs = 3;
numberOfOutputs = 2;
%%%%% GENETIC ALGORITHM PARAMETERS %%%%%
populationSize = 100;
creepMutationProbability = .05;
creepMutationRange = .25;
ordinaryMutationProbability = .05;
tournamentSelectionParameter = .75;
tournamentSize = 5;
crossOverProbability = .15;
numberOfGenerations = 500;
%%%%%%%% INITIALIZE VARIABLES %%%%%%%%%%
lengthOfChromosome = (numberOfNeurons * (numberOfInputs + 1)) + ((numberOfNeurons + 1) * numberOfOutputs);
fitnessTraining = zeros(populationSize,1);
fitnessValidation = zeros(populationSize,1);
trainingMaximumFitnessCollection = zeros(numberOfGenerations,1);
validationMaximumFitnessCollection = zeros(numberOfGenerations,1);
bestIndividuals = zeros(numberOfGenerations,lengthOfChromosome);
iDataSetTraining = 1;
iDataSetValidation = 2;

population = InitializePopulation(populationSize,initializationRange,...
    numberOfNeurons,numberOfInputs,numberOfOutputs);
for iGeneration = 1:numberOfGenerations
    trainingMaximumFitness = 0;
    validationMaximumFitness = 0;
    for iPopulation = 1:populationSize
        chromosome = population(iPopulation,:);

        fitnessTraining(iPopulation) = EvaluateIndividual(chromosome,...
            iDataSetTraining,gravity,cB,cH,tau,ambientTemp,timeStep,...
            truckMass,alphaMax,trackLength,initialPosition,vMax,vMin,initialVelocity,...
            brakeTempMax,initialBrakeTemp,gearRatio,initialGear,...
            lowerShiftBound,upperShiftBound,numberOfNeurons,numberOfInputs,numberOfOutputs);
        fitnessValidation(iPopulation) = EvaluateIndividual(chromosome,...
            iDataSetValidation,gravity,cB,cH,tau,ambientTemp,timeStep,...
            truckMass,alphaMax,trackLength,initialPosition,vMax,vMin,initialVelocity,...
            brakeTempMax,initialBrakeTemp,gearRatio,initialGear,...
            lowerShiftBound,upperShiftBound,numberOfNeurons,numberOfInputs,numberOfOutputs);
        
        if fitnessTraining(iPopulation) > trainingMaximumFitness
            iMaxFitness = iPopulation;
            trainingMaximumFitness = fitnessTraining(iPopulation);
            trainingMaximumFitnessCollection(iGeneration) = fitnessTraining(iPopulation);
            bestIndividuals(iGeneration,:) = chromosome;
            validationMaximumFitnessCollection(iGeneration) = fitnessValidation(iPopulation);
        end
    end

    tempPopulation = population;
    for i=1:2:populationSize
        i1 = TournamentSelect(fitnessTraining,tournamentSelectionParameter,tournamentSize);
        i2 = TournamentSelect(fitnessTraining,tournamentSelectionParameter,tournamentSize);
        chromosome1 = population(i1,:);
        chromosome2 = population(i2,:);
        if rand < crossOverProbability
            [newChromosome1, newChromosome2] = Cross(chromosome1,chromosome2);
            tempPopulation(i,:) = newChromosome1;
            tempPopulation(i+1,:) = newChromosome2;
        else
            tempPopulation(i,:) = chromosome1;
            tempPopulation(i+1,:) = chromosome2;
        end
    end

    for i=1:populationSize
        originalChromosome = tempPopulation(i,:);
        creepMutatedChromosome = CreepMutate(originalChromosome,creepMutationProbability,creepMutationRange,variableRange);
        ordinaryMutatedChromosome = OrdinaryMutate(creepMutatedChromosome,ordinaryMutationProbability,variableRange);
        tempPopulation(i,:) = ordinaryMutatedChromosome;
    end
    tempPopulation(1,:) = population(iMaxFitness,:);
    population = tempPopulation;
end