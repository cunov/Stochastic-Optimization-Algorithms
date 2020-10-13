function population = InitializePopulation(populationSize,N)
    population = zeros(populationSize,N+1);
    for iPopulation=1:populationSize
        population(iPopulation,1:N) = randperm(N);
        population(iPopulation,N+1) = population(iPopulation,1);
    end
end

