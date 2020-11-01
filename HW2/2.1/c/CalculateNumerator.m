function numerator = CalculateNumerator(pheromoneLevel,visibility,currentCity,nextCity,alpha,beta)
    numeratorPheromoneFactor = pheromoneLevel(currentCity,nextCity) ^ alpha;
    numeratorVisibilityFactor = visibility(currentCity,nextCity) ^ beta;
    numerator = numeratorPheromoneFactor * numeratorVisibilityFactor; 
end

