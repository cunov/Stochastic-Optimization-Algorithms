function path = GeneratePath(pheromoneLevel, visibility, alpha, beta)
    numberOfCities = length(visibility);
    
    startingCity = randi(numberOfCities);
    currentCity = startingCity;
    path = startingCity;
    tabuList = startingCity;
    
    while length(path) < numberOfCities
        denominator = CalculateDenominator(tabuList,pheromoneLevel,visibility,currentCity,alpha,beta);
        
        for nextCity = 1:numberOfCities
            if ~ismember(nextCity,tabuList)
                numerator = CalculateNumerator(pheromoneLevel,visibility,currentCity,nextCity,alpha,beta);
                probabilityOfThisCity = numerator / denominator;
                if rand < probabilityOfThisCity
                    path = [path nextCity];
                    tabuList = [tabuList nextCity];
                    currentCity = nextCity;
                    break
                end
            end
        end
    end
    path = [path startingCity];
end

