function ContourPlot(X)
    [plotX, plotY] = meshgrid(X(:,1),X(:,2));
    Z = (plotX.^2 + plotY - 11).^2 + (plotX + plotY.^2 - 7).^2;
    contour(plotX,plotY,Z)
end

