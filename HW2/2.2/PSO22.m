clear all;
cla reset;

% parameters
numberOfBoids = 25;
xyMin = [-5 -5];
xyMax = [5 5];
alpha = 0.5;
timeStep = 1;
cognitiveComponentConstant = 2;
socialComponentConstant = 2;
vMax = 3;
initialInertiaWeight = 1.4;
beta = 0.95;
inertiaWeightLowerBound = .35;

% generate contour plot
linX = linspace(xyMin(1),xyMax(1));
linY = linspace(xyMin(2),xyMax(2));
[plotX, plotY] = meshgrid(linX,linY);
f = (plotX.^2 + plotY - 11).^2 + (plotX + plotY.^2 - 7).^2;
logF = log(f);
contour(plotX,plotY,logF,25)
xticks(xyMin(1):xyMax(1))
yticks(xyMin(2):xyMax(2))
hold on

localMinima = [Inf Inf Inf];
while length(localMinima) < 5
    xBest = zeros(numberOfBoids,2);
    fitnessBest = Inf(numberOfBoids,1);
    xBestOverall = zeros(1,2);
    fitnessBestOverall = Inf;
    fitness = zeros(numberOfBoids,1);
    
    inertiaWeight = initialInertiaWeight;
    xCurrent = InitializePositions(xyMin, xyMax, numberOfBoids);
    vCurrent = InitializeVelocities(xyMin, xyMax, numberOfBoids, alpha, timeStep);
    for iIteration = 1:10000
        for iBoid = 1:numberOfBoids
            x = xCurrent(iBoid,:);
            fitness(iBoid) = EvaluateBoid(x);
            if fitness(iBoid) < fitnessBest(iBoid)
                fitnessBest(iBoid) = fitness(iBoid);
                xBest(iBoid,:) = x;
            end
            if fitness(iBoid) < fitnessBestOverall
                fitnessBestOverall = fitness(iBoid);
                xBestOverall = x;
            end
        end
        
        vCurrent = UpdateVelocities(xCurrent,vCurrent,xBest,xBestOverall,timeStep,...
            cognitiveComponentConstant,socialComponentConstant,vMax,inertiaWeight);
        xCurrent = UpdatePositions(xCurrent,vCurrent,timeStep);
        
        if inertiaWeight * beta > inertiaWeightLowerBound
            inertiaWeight = inertiaWeight * beta;
        end
    end
    roundedBestOverall = round([xBestOverall fitnessBestOverall],6);
    if ~ismember(roundedBestOverall,localMinima,'rows')
        localMinima = [localMinima; roundedBestOverall];
    end
end


localMinima(1,:) = [];
localMinimaX = localMinima(:,1);
localMinimaY = localMinima(:,2);
scatter(localMinimaX,localMinimaY,'red','filled')
for i=1:4
    xString = sprintf('%.6f',localMinimaX(i));
    yString = sprintf('%.6f',localMinimaY(i));
    labels{i} = ['   ' xString newline '   ' yString];
end
text(localMinimaX,localMinimaY,labels)
disp('Local Minima and function values:')
disp(localMinima)