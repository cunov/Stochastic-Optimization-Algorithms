function f = EvaluateBoid(X)

    left = ( X(1)^2 + X(2) - 11 ) ^ 2;
    right = ( X(1) + X(2)^2 - 7 ) ^ 2;
    
    f = left + right;
end

