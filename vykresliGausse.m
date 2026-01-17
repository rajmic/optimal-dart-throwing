function vykresliGausse(mu,invSigma,detSigma,sirka)

% Gaussovka
x = linspace(-sirka, sirka, 101);
y = linspace(-sirka, sirka, 101);
[X, Y] = meshgrid(x, y);

XY = [X(:) Y(:)];

g = gauss2d(XY,mu,invSigma,detSigma);
G = reshape(g, size(X));

figure;
h = surf(X, Y, G);
set(h,'FaceAlpha', 0.35)
shading interp
colormap('jet')
zlabel('g(x, y)')
title('2D Gaussovo rozdělení pravděpodobnosti fitované na data')
colorbar
hold on
grid on
box on

%vrchol Gaussovky
max_point = mu;
max_val = gauss2d(mu,mu,invSigma,detSigma);
plot3(max_point(1), max_point(2), max_val, 'g.', 'MarkerSize', 15);
plot3([max_point(1) max_point(1)], [max_point(2) max_point(2)], [0 max_val], 'k', 'LineWidth', 1.5);
plot3(max_point(1), max_point(2), 0, 'g.', 'MarkerSize', 15);