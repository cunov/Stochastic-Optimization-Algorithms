function alpha = GetSlopeAngle(x, iSlope, iDataSet)

    if (iDataSet == 1) % Training
        if (iSlope == 1) 
            alpha = 4 + sin(x/100) + cos(sqrt(2)*x/50);
        elseif (iSlope == 2)
            alpha = 4.69 + sin(x/100) + cos(sqrt(2)*x/50);
        elseif (iSlope == 3)
            alpha = 4.20 - sin(x/30) - cos(x/35);
        elseif (iSlope == 4)
            alpha = 4.5 + 1.3*sin(x/30) - x/876 - 1.1*cos(x/52);
        elseif (iSlope == 5)
            alpha = 4 - 1.2*sin(x/100) + 1.5*cos(sqrt(3.2)*x/47);
        elseif (iSlope == 6)
            alpha = 4.2 - sin(x/89) - (x/1000) + cos(1.2*x/35);
        elseif (iSlope == 7)
            alpha = 5.1 - sin(sqrt(12)*x/100) - (x/765) - cos(x/55);
        elseif (iSlope == 8)
            alpha = 4.3 + sin(x/28) + 2.3*cos(x/35);
        elseif (iSlope == 9)
            alpha = 4.9 - .6*sin(x/29) - 1.2*cos(x/88);
        elseif (iSlope == 10)
            alpha = 3 + 2*sin(x/50) + cos(sqrt(2)*x/100);
        end 
        
    elseif (iDataSet == 2)  % Validation
        if (iSlope == 1) 
            alpha = 5.3 - .9*sin(x/69) - 1.6*cos(x/36);
        elseif (iSlope == 2)
            alpha = 5 - 1.1*sin(x/123) + .8*cos(x/33);
        elseif (iSlope == 3)
            alpha = 5.7 - 1.8*sin(x/27) - 1.3*cos(x/577);
        elseif (iSlope == 4)
            alpha = 2*sqrt(8) - 0.49*sin(x/43) - 1.52*cos(x/42);
        elseif (iSlope == 5)
            alpha = 8/3 + cos(x/40) + 1.36*sin(x/69);
        end

    elseif (iDataSet == 3)    % Test
        if (iSlope == 1) 
            alpha = 4 - cos(x/413) - sin(x/29);
        elseif (iSlope == 2)
            alpha = 4 + sqrt(2)*sin(x/88) - 1.1*cos(x/27);
        elseif (iSlope == 3)
            alpha = 3.5 + 1.43*sin(x/40) - cos(x/50);
        elseif (iSlope == 4)
            alpha = 4 + sin(x/100) + 1.2*sin(sqrt(2)*x/49);
        elseif (iSlope == 5)
            alpha = 5.20 + 0.420*sin(x/42) - 1.420*cos(x/28);
        end
    end

end
