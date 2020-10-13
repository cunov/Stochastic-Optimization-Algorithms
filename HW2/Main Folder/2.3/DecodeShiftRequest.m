function [newGear, iTimeOfLastShift] = DecodeShiftRequest(shiftRequest,currentGear,gearRatio,...
    iTimeOfLastShift,iCurrentTime,timeStep,lowBound,uppBound)

    secSinceLastShift = (iCurrentTime - iTimeOfLastShift) * timeStep;
    numberOfGears = length(gearRatio);
    
    newGear = currentGear;
    if shiftRequest > uppBound
        if secSinceLastShift > 2
            if currentGear + 1 <= numberOfGears
                newGear = currentGear + 1;
                iTimeOfLastShift = iCurrentTime;
            end
        end
    elseif shiftRequest < lowBound
        if secSinceLastShift > 2
            if currentGear - 1 >= 1
                newGear = currentGear - 1;
                iTimeOfLastShift = iCurrentTime;
            end
        end
    end
end

