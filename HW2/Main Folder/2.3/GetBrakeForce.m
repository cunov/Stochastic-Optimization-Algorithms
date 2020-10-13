function brakeForce = GetBrakeForce(brakeTemp,maxBrakeTemp,pedalPressure,truckMass,g)
    constant = truckMass * g / 20;
    if brakeTemp < (maxBrakeTemp - 100)
        brakeForce = constant * pedalPressure;
    else
        exponential = exp(-(brakeTemp - (maxBrakeTemp-100))/100);
        brakeForce = constant * pedalPressure * exponential;
    end
end

