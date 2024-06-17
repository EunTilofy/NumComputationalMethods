x0 = [0.5; 0.5];
X = Newton(x0,1e-6);
X

function P = Newton(X, eps)
    while norm(Diff(X)) > eps
        p = - inv(Hess(X)) * Diff(X);
        X = X + p;
    end
    P = X;
end

function P = Diff(x)
    x1 = x(1);
    x2 = x(2);
    y1 = 2*(x1-2*cos(x2))-8*(4/x1-sin(x2))/(x1^2);
    y2 = 4*x1*sin(x2)-3*sin(2*x2)-8*cos(x2)/x1;
    P = [y1; y2];
end

function P = Hess(x)
    x1 = x(1);
    x2 = x(2);
    y11 = 2 + 96/(x1^4)-16*sin(x2)/(x1^3);
    y12 = 4*sin(x2)+8*cos(x2)/(x1^2);
    y21 = y12;
    y22 = 4*x1*cos(x2)-6*cos(2*x2)+8*sin(x2)/x1;
    P = [y11, y12; y21, y22];
end