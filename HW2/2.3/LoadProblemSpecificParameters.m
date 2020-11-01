function Params = LoadProblemSpecificParameters()
    Params.gearRatio = [7 5 4 3 2.5 2 1.6 1.4 1.2 1];
    Params.truckMass = 20000;      % kg
    Params.tau = 30;               % s
    Params.cH = 40;                % K/s
    Params.ambientTemp = 283;      % K
    Params.G = 9.80665;            % m/ss
    Params.cB = 3000;              % N
    Params.vMax = 25;              % m/s
    Params.vMin = 1;               % m/s
    Params.brakeTempMax = 750;     % K
    Params.L = 1000;               % m
    Params.alphaMax = 10;          % degrees
    Params.timeStep = 0.2;         % s
    Params.initialVelocity = 20;   % m/s
    Params.initialPosition = 0;    % m
    Params.initialBrakeTemp = 500; % K
    Params.initialGear = 7;
end

