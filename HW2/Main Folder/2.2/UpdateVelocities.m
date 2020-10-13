function vCurrent = UpdateVelocities(xCurrent,vCurrent,xBest,xBestOverall,timeStep,c1,c2,vMax,inertiaWeight)
    numberOfBoids = size(xCurrent,1);
    numberOfDimensions = size(xCurrent,2);
    for i = 1:numberOfBoids
        for j = 1:numberOfDimensions
            cognitiveComponent = c1 * rand * (xBestOverall(j) - xCurrent(i,j)) / timeStep;
            socialComponent = c2 * rand * (xBest(i,j) - xCurrent(i,j)) / timeStep;
            vCurrent(i,j) = inertiaWeight * vCurrent(i,j) + cognitiveComponent + socialComponent;
            if vCurrent(i,j) > vMax
                vCurrent(i,j) = vMax;
            elseif vCurrent(i,j) < -vMax
                vCurrent(i,j) = -vMax;
            end
        end
    end
end

