function acceleration = CalculateAcceleration(gravitationalForce, brakeForce, engineBrakeForce, truckMass)
   acceleration = (1/truckMass) * (gravitationalForce - brakeForce - engineBrakeForce);
end

