%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Ant system (AS) for TSP.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
clc;
cla reset;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cityLocation = LoadCityLocations();
numberOfCities = length(cityLocation);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
numberOfAnts = numberOfCities;
alpha = 1.0;
beta = 3.5;
rho = 0.7;

nearestNeighbourPathLength = GetNearestNeighbourPathLength(cityLocation);
tao0 = numberOfAnts/nearestNeighbourPathLength;

targetPathLength = 123.0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initialization
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
range = [0 20 0 20];
tspFigure = InitializeTspPlot(cityLocation, range);
connection = InitializeConnections(cityLocation);
pheromoneLevel = InitializePheromoneLevels(numberOfCities, tao0);
visibility = GetVisibility(cityLocation);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Main loop
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

minimumPathLength = inf;
iIteration = 0;
while (minimumPathLength > targetPathLength)
    iIteration = iIteration + 1;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%
    % Generate paths:
    %%%%%%%%%%%%%%%%%%%%%%%%%%
    
    pathCollection = [];
    pathLengthCollection = [];
    for k = 1:numberOfAnts
        path = GeneratePath(pheromoneLevel, visibility, alpha, beta);
        pathLength = GetPathLength(path,cityLocation);
        if (pathLength < minimumPathLength)
            minimumPathLength = pathLength;
            disp(sprintf('Iteration %d, ant %d: path length = %.5f',iIteration,k,minimumPathLength));
            PlotPath(connection,cityLocation,path);
            bestPath = path;
        end
        pathCollection = [pathCollection; path];           
        pathLengthCollection = [pathLengthCollection; pathLength];
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%
    % Update pheromone levels
    %%%%%%%%%%%%%%%%%%%%%%%%%%
    deltaPheromoneLevel = ComputeDeltaPheromoneLevels(pathCollection,pathLengthCollection);
    pheromoneLevel = UpdatePheromoneLevels(pheromoneLevel,deltaPheromoneLevel,rho);
end







