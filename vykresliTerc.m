function vykresliTerc(param_terce)

% Terc
radii = [param_terce.r_bull_big, param_terce.r_bull_small, param_terce.r_double_in, param_terce.r_double_out, param_terce.r_triple_in, param_terce.r_triple_out];
theta = linspace(0, 2*pi, 400);

%kruhy
for r = radii
    x = r * cos(theta);
    y = r * sin(theta);
    plot(x, y, 'k', 'LineWidth', .8);
end

%cary
r_start = param_terce.r_bull_big; % začínají od big bullu
r_end = param_terce.r_double_out; % končí u double

% segment 20 bývá nahoře (90°), teď rotace o +9°
shift = 90 + 9;

for ang = 0:18:360
    a = deg2rad(ang + shift);

    x1 = r_start*cos(a);
    y1 = r_start*sin(a);
    x2 = r_end*cos(a);
    y2 = r_end*sin(a);

    plot([x1 x2],[y1 y2],'k','LineWidth',.8)
end

xlabel('x [cm]')
ylabel('y [cm]')