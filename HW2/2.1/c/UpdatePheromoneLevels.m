function pheromoneLevel = UpdatePheromoneLevels(pheromoneLevel,deltaPheromoneLevel,rho)
    numberOfCities = length(deltaPheromoneLevel);
    for i=1:numberOfCities
        for j=1:numberOfCities
            pheromoneLevel(i,j) = pheromoneLevel(i,j) + deltaPheromoneLevel(i,j) * rho;
        end
    end
end

