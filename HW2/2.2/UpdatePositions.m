function X = UpdatePositions(X,V,timeStep)
    numberOfBoids = size(X,1);
    numberOfDimensions = size(X,2);
    for i = 1:numberOfBoids
        for j = 1:numberOfDimensions
            X(i,j) = X(i,j) + V(i,j) * timeStep;
        end
    end
end

