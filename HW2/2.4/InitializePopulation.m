function population = InitializePopulation(populationSize,numOperators,...
    numVariableRegisters,numConstantRegisters,initialInstructionLengthRange)

    numRegisters = numVariableRegisters + numConstantRegisters;
    population = cell(populationSize,1);
    fields = {'operator','indexDestinationRegister','indexOperand1','indexOperand2'};
    
    for iPopulation = 1:populationSize
        instructionLength = randi(initialInstructionLengthRange);
        tmp = cell(length(fields),1);
        TempStruct = cell2struct(tmp,fields);
        for iInstruction = 1:instructionLength
            TempStruct(iInstruction).operator = randi(numOperators);
            TempStruct(iInstruction).indexDestinationRegister = randi(numVariableRegisters);
            TempStruct(iInstruction).indexOperand1 = randi(numRegisters);
            TempStruct(iInstruction).indexOperand2 = randi(numRegisters);
        end
        population{iPopulation} = TempStruct;
    end
end

