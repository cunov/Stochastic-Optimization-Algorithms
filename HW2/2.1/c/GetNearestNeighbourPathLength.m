function NNPathLength = GetNearestNeighbourPathLength(cityLocation)
    numberOfCities = length(cityLocation);
    path = zeros(numberOfCities + 1,1);
    NNPathLength = 0;
    distanceMatrix = GenerateDistanceMatrix(cityLocation);
    
    startingCity = randi(numberOfCities);

    path(1) = startingCity;
    currentCity = startingCity;
    numberOfVisitedCities = 1;
    while numberOfVisitedCities < numberOfCities
        distanceToNearestNeighbor = max(distanceMatrix(:)) + 1;
        for nextCity=1:numberOfCities
            if ~ismember(nextCity,path)
                if distanceMatrix(currentCity,nextCity) < distanceToNearestNeighbor
                    distanceToNearestNeighbor = distanceMatrix(currentCity,nextCity);
                    nearestNeighbor = nextCity;
                end
            end
        end
        NNPathLength = NNPathLength + distanceToNearestNeighbor;
        currentCity = nearestNeighbor;
        numberOfVisitedCities = numberOfVisitedCities + 1;
        path(numberOfVisitedCities) = currentCity;
    end
    numberOfVisitedCities = numberOfVisitedCities + 1;
    path(numberOfVisitedCities) = startingCity;
    NNPathLength = NNPathLength + distanceMatrix(currentCity,startingCity);

end