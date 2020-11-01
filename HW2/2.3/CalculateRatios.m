function [vRatio, alphaRatio, brakeTempRatio] = CalculateRatios(vCurrent,...
    vMax,alpha,alphaMax,brakeTemp,brakeTempMax)

    vRatio = vCurrent / vMax;
    alphaRatio = alpha / alphaMax;
    brakeTempRatio = brakeTemp / brakeTempMax;
end

