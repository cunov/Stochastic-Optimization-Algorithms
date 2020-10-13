clear all
[chromosome, numberOfNeurons] = LoadBestWeights();
iDataSet = 3;
iSlope = 2;

numberOfInputs = 3;
numberOfOutputs = 2;
lowerShiftBound = .3;
upperShiftBound = .7;

% parameters
Constants = LoadProblemSpecificParameters();
gearRatio = Constants.gearRatio;
truckMass = Constants.truckMass;
tau = Constants.tau;
cH = Constants.cH;
ambientTemp = Constants.ambientTemp;
gravity = Constants.G;
cB = Constants.cB;
vMax = Constants.vMax;
vMin = Constants.vMin;
brakeTempMax = Constants.brakeTempMax;
trackLength = Constants.L;
alphaMax = Constants.alphaMax;
timeStep = Constants.timeStep;
initialVelocity = Constants.initialVelocity;
initialPosition = Constants.initialPosition;
initialBrakeTemp = Constants.initialBrakeTemp;
initialGear = Constants.initialGear;

% initialize variables
currentVelocity = initialVelocity;
currentBrakeTemp = initialBrakeTemp;
currentGear = initialGear;
currentPosition = initialPosition;
currentPedalPressure = 0;
currentAlpha = GetSlopeAngle(currentPosition,iSlope,iDataSet);
iTimeOfLastShift = -Inf;

gearCollection = []; brakeTempCollection = []; pedalPressureCollection = [];
alphaCollection = []; positionCollection = []; velocityCollection = [];
velocityCondition = (currentVelocity > vMin) && (currentVelocity < vMax);
positionCondition = currentPosition < trackLength;
brakeTempCondition = currentBrakeTemp < brakeTempMax;

iTime = 0;
while (velocityCondition) && (positionCondition) && (brakeTempCondition)
    iTime = iTime + 1;
    gearCollection = [gearCollection; currentGear];
    brakeTempCollection = [brakeTempCollection; currentBrakeTemp];
    pedalPressureCollection = [pedalPressureCollection; currentPedalPressure];
    alphaCollection = [alphaCollection; currentAlpha];
    positionCollection = [positionCollection; currentPosition];
    velocityCollection = [velocityCollection; currentVelocity];
    
    currentAlpha = GetSlopeAngle(currentPosition,iSlope,iDataSet);
    
    [vRatio, alphaRatio, brakeTempRatio] = CalculateRatios(currentVelocity,...
        vMax,currentAlpha,alphaMax,currentBrakeTemp,brakeTempMax);
    
    [currentPedalPressure, shiftRequest] = ANN(vRatio, alphaRatio,...
        brakeTempRatio, chromosome, numberOfNeurons, numberOfInputs, numberOfOutputs);
    
    [currentGear, iTimeOfLastShift] = DecodeShiftRequest(shiftRequest,currentGear,gearRatio,...
        iTimeOfLastShift,iTime,timeStep,lowerShiftBound,upperShiftBound);
    
    
    brakeForce = GetBrakeForce(currentBrakeTemp,brakeTempMax,currentPedalPressure,truckMass,gravity);
    engineForce = GetEngineBrakeForce(cB,gearRatio,currentGear);
    gravityForce = GetGravitationalForce(truckMass,currentAlpha,gravity);
    acceleration = CalculateAcceleration(gravityForce,brakeForce,...
        engineForce,truckMass);

    
    currentVelocity = UpdateVelocity(currentVelocity,acceleration,timeStep);
    currentPosition = UpdatePosition(currentPosition,currentVelocity,timeStep);
    currentBrakeTemp = UpdateBrakeTemp(currentBrakeTemp,currentPedalPressure,tau,cH,ambientTemp,timeStep);
 
    
    velocityCondition = (currentVelocity > vMin) && (currentVelocity < vMax);
    positionCondition = currentPosition < trackLength;
    brakeTempCondition = currentBrakeTemp < brakeTempMax;
end

subplot(3,2,1)
plot(positionCollection,alphaCollection)
title('Alpha')
subplot(3,2,2)
plot(positionCollection,pedalPressureCollection)
title('Pedal Pressure')
subplot(3,2,3)
plot(positionCollection,gearCollection)
title('Gear')
subplot(3,2,4)
plot(positionCollection,velocityCollection)
title('Speed')
subplot(3,1,3)
plot(positionCollection,brakeTempCollection)
title('Brake Temp')