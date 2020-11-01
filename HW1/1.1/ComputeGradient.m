function gradient = ComputeGradient(x,mu)

    if x(1)^2 + x(2)^2 >= 1
        gradient = [
            2*(x(1)-1) + 4*mu*( x(1)^3 + x(1)*x(2)^2 - x(1) )
            4*(x(2)-2) + 4*mu*( x(2)^3 + x(2)*x(1)^2 - x(2) )
            ];
    else
        gradient = [
            2*(x(1)-1)
            4*(x(2)-2)
            ];
    end
end

