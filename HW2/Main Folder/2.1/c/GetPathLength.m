function pathLength = GetPathLength(path,cityLocations)
    numberOfCities = length(path) - 1;
    distanceMatrix = GenerateDistanceMatrix(cityLocations);
    
    pathLength = 0;
    for iCity=1:numberOfCities 
        currentCity = path(iCity);
        nextCity = path(iCity + 1);
        lengthTravelled = distanceMatrix(currentCity,nextCity);
        pathLength = pathLength + lengthTravelled;
    end
end

