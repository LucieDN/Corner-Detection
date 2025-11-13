function M = compute_virtual_image(I, x, y)
    ox = fix(mean(x));
    oy = fix(mean(y));
    M1 = halfplane_from_cartesian_line(I, [x(1) x(2)], [y(1) y(2)]);
    if M1(oy, ox) == 0
        M1 = 1-M1;
    end
    M2 = halfplane_from_cartesian_line(I, [x(2) x(3)], [y(2) y(3)]);
    if M2(oy, ox) == 0
        M2 = 1-M2;
    end
    M3 = halfplane_from_cartesian_line(I, [x(3) x(4)], [y(3) y(4)]);
    if M3(oy, ox) == 0
        M3 = 1-M3;
    end
    M4 = halfplane_from_cartesian_line(I, [x(4) x(1)], [y(4) y(1)]);
    if M4(oy, ox) == 0
        M4 = 1-M4;
    end
    M = double(M1.*M2.*M3.*M4);
end

function M = halfplane_from_cartesian_line(I, x, y)
    [h, w] = size(I);
    M = zeros(h, w);
    [X, Y] = meshgrid(1:w, 1:h);
    dx = x(2)-x(1);
    dy = y(2)-y(1);
    a = -dy/sqrt(dx*dx+dy*dy);
    b = dx/sqrt(dx*dx+dy*dy);
    c = -a*x(1)-b*y(1);
    M = double((a*X+b*Y+c)>=0);
end