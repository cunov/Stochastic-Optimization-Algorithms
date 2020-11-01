function brakeTemp = UpdateBrakeTemp(brakeTemp,pedalPressure,tau,cH,ambientTemp,timeStep)
    relativeBrakeTemp = brakeTemp - ambientTemp;
    if pedalPressure < 0.01
        deltaRelativeBrakeTemp = -relativeBrakeTemp / tau;
    else
        deltaRelativeBrakeTemp = cH * pedalPressure;
    end
    brakeTemp = ambientTemp + relativeBrakeTemp + deltaRelativeBrakeTemp * timeStep;
end

