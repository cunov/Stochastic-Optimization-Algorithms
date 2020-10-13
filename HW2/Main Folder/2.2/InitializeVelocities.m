function V = InitializeVelocities(xyMin, xyMax, N, alpha, timeStep)
    numberOfDimensions = length(xyMin);
    V = zeros(N,numberOfDimensions);
    for iBoid=1:N
        for iDimension=1:numberOfDimensions
            leftInner = -(1/2) * (xyMax(iDimension) - xyMin(iDimension));
            rightInner = rand() * (xyMax(iDimension) - xyMin(iDimension));
            inner = leftInner + rightInner;
            outer = alpha / timeStep;
            V(iBoid,iDimension) = outer * inner;
        end
    end

end

