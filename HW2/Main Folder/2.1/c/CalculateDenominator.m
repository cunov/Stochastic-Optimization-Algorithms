function denominator = CalculateDenominator(tabuList,pheromoneLevel,visibility,currentCity,alpha,beta)
    
    numberOfCities = length(visibility);
    denominator = 0;
    
    for nextCity = 1:numberOfCities
        if ~ismember(nextCity,tabuList)
            pheromoneFactor = pheromoneLevel(currentCity,nextCity) ^ alpha;
            visibilityFactor = visibility(currentCity,nextCity) ^ beta;
            denominator = denominator + ( pheromoneFactor * visibilityFactor );
        end
    end
    
end

