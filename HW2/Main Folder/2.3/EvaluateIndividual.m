function fitness = EvaluateIndividual(chromosome,iDataSet,...
    g,cB,cH,tau,ambientTemp,timeStep,truckMass,alphaMax,L,initialPosition,...
    vMax,vMin,initialVelocity,brakeTempMax,initialBrakeTemp,gearRatio,initialGear,...
    lowerShiftBound,upperShiftBound,numberOfNeurons,numberOfInputs,numberOfOutputs)
    
    if iDataSet == 1
        numberOfSlopes = 10;
    else
        numberOfSlopes = 5;
    end
    slopeFitnessCollection = zeros(numberOfSlopes,1);

    for iSlope = 1:numberOfSlopes
        currentPosition = initialPosition;
        currentVelocity = initialVelocity;
        currentBrakeTemp = initialBrakeTemp;
        currentGear = initialGear;
        velocityCollection = [];
        iTimeOfLastShift = -Inf;
        
        iTime = 0;
        velocityCondition = (currentVelocity < vMax) && (currentVelocity > vMin);
        positionCondition = (currentPosition < L);
        brakeTempCondition = (currentBrakeTemp < brakeTempMax);
        while (velocityCondition && positionCondition && brakeTempCondition)
            iTime = iTime + 1;
            velocityCollection = [velocityCollection; currentVelocity];

            alpha = GetSlopeAngle(currentPosition,iSlope,iDataSet);
            
            [vRatio, alphaRatio, brakeTempRatio] = CalculateRatios(currentVelocity,...
                vMax,alpha,alphaMax,currentBrakeTemp,brakeTempMax);
            
            [currentPedalPressure, shiftRequest] = ANN(vRatio, alphaRatio,...
                brakeTempRatio, chromosome, numberOfNeurons, numberOfInputs, numberOfOutputs);
            
            [currentGear, iTimeOfLastShift] = DecodeShiftRequest(shiftRequest,currentGear,...
                gearRatio,iTimeOfLastShift,iTime,timeStep,lowerShiftBound,upperShiftBound);
            
            
            brakeForce = GetBrakeForce(currentBrakeTemp,brakeTempMax,...
                currentPedalPressure,truckMass,g);
            engineForce = GetEngineBrakeForce(cB,gearRatio,currentGear);
            gravityForce = GetGravitationalForce(truckMass,alpha,g);
            acceleration = CalculateAcceleration(gravityForce,brakeForce,...
                engineForce,truckMass);

            
            currentVelocity = UpdateVelocity(currentVelocity,acceleration,timeStep);
            currentPosition = UpdatePosition(currentPosition,currentVelocity,timeStep);
            currentBrakeTemp = UpdateBrakeTemp(currentBrakeTemp,...
                currentPedalPressure,tau,cH,ambientTemp,timeStep);
            
      
            velocityCondition = (currentVelocity < vMax) && (currentVelocity > vMin);
            positionCondition = (currentPosition < L);
            brakeTempCondition = (currentBrakeTemp < brakeTempMax);
        end
        averageVelocity = mean(velocityCollection);
        if currentPosition >= L
            currentPosition = L;
        end
        distanceTravelled = currentPosition;
        slopeFitnessCollection(iSlope) = averageVelocity * distanceTravelled;
        if currentPosition < L
            slopeFitnessCollection(iSlope) = .8 * slopeFitnessCollection(iSlope);
        end
    end
    fitness = mean(slopeFitnessCollection);
end

