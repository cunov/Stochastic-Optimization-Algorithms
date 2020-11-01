function newPopulation = InsertBestIndividual(population,bestIndividual,numCopies)
    newPopulation = population;
    for i=1:numCopies
        newPopulation(i,:) = bestIndividual;
    end
end

