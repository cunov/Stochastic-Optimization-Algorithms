function [symF, strF] = GenerateFinalFunction(Chromosome,constantRegisterSet,...
    numVariableRegisters)

    numConstantRegisters = length(constantRegisterSet);
    numRegisters = numVariableRegisters + numConstantRegisters;
    registerValues = cell(1,numRegisters);
    registerValues(:)={''};
    
    for iVariableRegister = 1:numVariableRegisters
        strVariableRegister = num2str(iVariableRegister);
        tmp = strcat('x',strVariableRegister);
        registerValues(iVariableRegister) = cellstr(tmp);
    end
    
    for iConstantRegister = 1:numConstantRegisters
        strConstantRegister = num2str(constantRegisterSet(iConstantRegister));
        registerValues(numVariableRegisters + iConstantRegister) = cellstr(strConstantRegister);
    end
    
    for i = 1:length(Chromosome)
        if Chromosome(i).operator == 1
            operator = '+';
        elseif Chromosome(i).operator == 2
            operator = '-';
        elseif Chromosome(i).operator == 3
            operator = '*';
        else
            operator = '/';
        end
        indexDestinationRegister = Chromosome(i).indexDestinationRegister;
        indexOperand1 = Chromosome(i).indexOperand1;
        indexOperand2 = Chromosome(i).indexOperand2;
        operand1 = registerValues(indexOperand1);
        operand2 = registerValues(indexOperand2);
        strOperand1 = char(operand1);
        strOperand2 = char(operand2);
        strOperation = strcat('(',strOperand1,operator,strOperand2,')');
        
        registerValues(indexDestinationRegister) = cellstr(strOperation);
    end
    
    symF = str2sym(registerValues(1));
    syms x
    symF = subs(symF,x);
    symF = simplify(symF);
    strF = char(symF);

end

