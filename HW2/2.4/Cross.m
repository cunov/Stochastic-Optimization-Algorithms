function [NewChromosome1, NewChromosome2] = Cross(Chromosome1,Chromosome2)
    
    numInstructions1 = length(Chromosome1);
    numInstructions2 = length(Chromosome2);

    crossOverPoints(1,1) = randi([                       1 , numInstructions1 - 2]);
    crossOverPoints(1,2) = randi([1 + crossOverPoints(1,1) , numInstructions1 - 1]);
    crossOverPoints(2,1) = randi([                       1 , numInstructions2 - 2]);
    crossOverPoints(2,2) = randi([1 + crossOverPoints(2,1) , numInstructions2 - 1]);
    
    leftPortionOfChromosome1 = Chromosome1 (                       1  : crossOverPoints(1,1) );
    innerPortionOfChromosome1 = Chromosome1( 1 + crossOverPoints(1,1) : crossOverPoints(1,2) );
    rightPortionOfChromosome1 = Chromosome1( 1 + crossOverPoints(1,2) : end );
    leftPortionOfChromosome2 = Chromosome2 (                       1  : crossOverPoints(2,1) );
    innerPortionOfChromosome2 = Chromosome2( 1 + crossOverPoints(2,1) : crossOverPoints(2,2) );
    rightPortionOfChromosome2 = Chromosome2( 1 + crossOverPoints(2,2) : end );
    
    NewChromosome1 = [leftPortionOfChromosome1, innerPortionOfChromosome2, rightPortionOfChromosome1];
    NewChromosome2 = [leftPortionOfChromosome2, innerPortionOfChromosome1, rightPortionOfChromosome2];
end

