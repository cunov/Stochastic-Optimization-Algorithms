function distance = GenerateDistanceMatrix(cityLocation)
    numberOfCities = length(cityLocation);
    distance = zeros(numberOfCities);
    for i=1:numberOfCities
        for j=1:numberOfCities
            fromX = cityLocation(i,1);
            fromY = cityLocation(i,2);
            toX = cityLocation(j,1);
            toY = cityLocation(j,2);
            dx = (toX - fromX);
            dy = (toY - fromY);
            distance(i,j) = sqrt(dx^2 + dy^2);
        end
    end
end

