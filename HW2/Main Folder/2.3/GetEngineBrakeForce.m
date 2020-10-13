function force = GetEngineBrakeForce(cB, gearRatio, iGear)
    force = cB * gearRatio(iGear);
end

