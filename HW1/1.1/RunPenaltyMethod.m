step = 0.0001;
T = 10^-6;
mu = [1;10;100;1000];
x0 = [1;2];

optimi = zeros(length(mu),2);
for i = 1:length(mu)
    optimi(i,:) = RunGradientDescent(x0,mu(i),step,T);
end

x1 = optimi(:,1);
x2 = optimi(:,2);
disp(table(mu,x1,x2))