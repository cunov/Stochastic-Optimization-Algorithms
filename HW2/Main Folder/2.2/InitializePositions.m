function X = InitializePositions(xMin,xMax,N)
    numberOfDimensions = length(xMin);
    X = zeros(N,numberOfDimensions);
    for iBoid=1:N
        for iDimension=1:numberOfDimensions
            X(iBoid,iDimension) = xMin(iDimension) + rand * (xMax(iDimension) - xMin(iDimension));
        end
    end
end

