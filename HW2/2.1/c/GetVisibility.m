function visibility = GetVisibility(cityLocation)
    distanceMatrix = GenerateDistanceMatrix(cityLocation);
    visibility = 1 ./ distanceMatrix;
end

