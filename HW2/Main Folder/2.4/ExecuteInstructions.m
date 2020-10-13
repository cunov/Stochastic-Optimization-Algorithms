function newValue = ExecuteInstructions(instructions,registerValues,cMax)
    operand1 = registerValues(instructions.indexOperand1);
    operand2 = registerValues(instructions.indexOperand2);
   
    if instructions.operator == 1
        newValue = operand1 + operand2;
    elseif instructions.operator == 2
        newValue = operand1 - operand2;
    elseif instructions.operator == 3
        newValue = operand1 * operand2;
    else
        if abs(operand2) > 0
            newValue = operand1 / operand2;
        else
            newValue = cMax;
        end
    end
end

