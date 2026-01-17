function g = gauss2d(X,mu,invSigma,detSigma)
%vypočítá hodnotu 2D Gaussovy funkce v bodě [x,y]

g = exp(-0.5 * sum((X - mu) * invSigma .* (X - mu), 2)) ...
/ (2 * pi * sqrt(detSigma));
end