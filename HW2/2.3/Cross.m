function [crossedChromosome1,crossedChromosome2] = Cross(chromosome1,chromosome2)
    lengthOfChromosome = length(chromosome1);
    
    iRand = randi(lengthOfChromosome);
    
    crossedChromosome1 = [chromosome1(1:iRand) chromosome2(iRand+1:end)];
    crossedChromosome2 = [chromosome2(1:iRand) chromosome1(iRand+1:end)];
    
    
end

