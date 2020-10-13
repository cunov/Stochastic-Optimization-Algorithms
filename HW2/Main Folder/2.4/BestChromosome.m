function BestChromosome = BestChromosome()
    bestChromosomeVector = [
        [1,3,1,4,3,1,2,3,2,2,4,4,2,3,3,2,4,1,3,1,1,1,1,4,4,3,4,2,1];
        [3,4,4,3,2,2,4,3,2,2,3,4,3,3,2,3,3,2,2,1,2,3,3,3,1,1,1,4,4];
        [1,4,3,5,4,1,2,5,1,5,3,4,5,1,1,2,2,5,1,2,4,4,4,2,1,2,4,4,3];
        [2,1,3,2,5,3,3,4,5,3,1,1,4,2,3,5,3,5,3,1,2,3,5,5,5,1,2,5,2]
        ];

    BestChromosome = struct();
    for i=1:length(bestChromosomeVector)
        BestChromosome(i).operator = bestChromosomeVector(1,i);
        BestChromosome(i).indexDestinationRegister = bestChromosomeVector(2,i);
        BestChromosome(i).indexOperand1 = bestChromosomeVector(3,i);
        BestChromosome(i).indexOperand2 = bestChromosomeVector(4,i);
    end
end