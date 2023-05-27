function estInt = monte_carlo_int(f,a,b,n)

% f is function, a,b are lower and upper limits, n is data points

    x = a + (b - a) * rand(n, 1);
    fx = f(x);
    avFx = mean(fx);
    estInt = (b - a) * avFx;

end