function x = RunGradientDescent(x0,mu,step,T)
    x = x0;
    gradient = [T T];
    while norm(gradient) > T
        gradient = ComputeGradient(x,mu);
        x = x - step * gradient;
    end
end

