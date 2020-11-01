function deltaPheromoneLevels = ComputeDeltaPheromoneLevels(pathCollection,pathLengthCollection)
    
    numberOfCities = size(pathCollection,2) - 1;
    numberOfAnts = size(pathCollection,1);
    deltaPheromoneLevels = zeros(numberOfCities);
    
    for iAnt = 1:numberOfAnts
        distanceTravelled = pathLengthCollection(iAnt);
        path = pathCollection(iAnt, :);
        for i = 1:numberOfCities
            fromCity = path(i);
            toCity = path(i + 1);
            deltaPheromoneLevels(fromCity,toCity) = deltaPheromoneLevels(fromCity,toCity) + 1/distanceTravelled;
        end
    end
end

