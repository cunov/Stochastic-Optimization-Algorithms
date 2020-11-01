function fitness = EvaluateIndividual(path,cityLocations)
    numberOfCities = length(path);
    distances = zeros(numberOfCities,1);
    for iCity=1:numberOfCities - 1
        xFrom = cityLocations(path(iCity),1);
        yFrom = cityLocations(path(iCity),2);
        xTo = cityLocations(path(iCity+1),1);
        yTo = cityLocations(path(iCity+1),2);
        dx = xTo - xFrom;
        dy = yTo - yFrom;
        distances(iCity) = sqrt(dx^2 + dy^2);
    end
    pathLength = sum(distances);
    fitness = 1/pathLength;
end

