f = @(x) 1./(1 + 25*x.^2);
xa = ((1:11)-6)./5;
ya = f(xa);
y1 = -50 * xa ./ (1 + 25 * xa.^2).^2;
xb = cos((2*(0:20) + 1)*pi/42);
yb = f(xb);

ans11 = @(x) lagrange(xa, ya, x);
Difftable = diffTable(xa, ya);
ans12 = @(x) newton(xa, Difftable, x);
ans2 = @(x) lagrange(xb, yb, x);
ans3 = @(x) linear(xa, ya, x);
ans4 = @(x) hermite(xa, ya, y1, x);

x_ = ((1:1001)-501)./500;

ploto = f(x_);
plot11 = ans11(x_);
plot12 = ans12(x_);
plot2 = ans2(x_);
plot3 = ans3(x_);
plot4 = ans4(x_);

figure;
subplot(2,2,1);
plot(x_, ploto, 'b--', 'DisplayName', 'Original');
hold on;
plot(x_, plot11, 'k-', 'DisplayName', 'Lagrange-1');
plot(x_, plot12, 'r-.', 'DisplayName', 'Newton');
legend('show');
title('(a) Lagrange vs Newton');
xlabel('x');
ylabel('y');

subplot(2,2,2);
plot(x_, ploto, 'b--', 'DisplayName', 'Original');
hold on;
plot(x_, plot2, 'k-', 'DisplayName', 'Lagrange-2');
legend('show');
title('(b) Lagrange');
xlabel('x');
ylabel('y');

subplot(2,2,3);
plot(x_, ploto, 'b--', 'DisplayName', 'Original');
hold on;
plot(x_, plot3, 'k-', 'DisplayName', 'Linear');
legend('show');
title('(c) Linear');
xlabel('x');
ylabel('y');

subplot(2,2,4);
plot(x_, ploto, 'b--', 'DisplayName', 'Original');
hold on;
plot(x_, plot4, 'k-', 'DisplayName', 'Hermite');
legend('show');
title('(d) Hermite');
xlabel('x');
ylabel('y');


function P = lagrange(X, Y, x)
    n = length(X);
    L = ones(n, length(x));
    for i = 1:n
        for j = 1:n
            if i ~= j
                L(i,:) = L(i,:).*(x-X(j))./(X(i)-X(j));
            end
        end
    end
    P = Y*L;
end

function P = newton(X, Table, x)
    n = length(X);
    P(length(x)) = 0;
    for ii = 1:length(x)
        num = 1;
        P(ii) = 0;
        for i = 1:n
            P(ii) = P(ii) + num * Table(i);
            num = num * (x(ii) - X(i));
        end
    end
end

function table = diffTable(X, Y)
    n = length(X);
    table(n) = 0;
    for i = 1:n
        table(i) = Y(i);
    end
    for j = 2:n
        for i = n+j-(j:n)
            table(i) = (table(i) - table(i-1)) / (X(i)-X(i-j+1));
        end
    end
end

function P = linear(X, Y, x)
    P(length(x)) = 0;
    for i = 1:length(x)
        for j = 1:length(X)-1
            if x(i) >= X(j) && x(i) <= X(j+1)
                P(i) = Y(j) + (Y(j+1) - Y(j)) / (X(j+1) - X(j)) * (x(i) - X(j));
                break;
            end
        end
    end
end

function P = hermite(X, Y, Y1, x)
    P(length(x)) = 0;
    for i = 1:length(x)
        for j = 1:length(X)-1
            if x(i) >= X(j) && x(i) <= X(j+1)
                P(i) = hermite_(X(j), X(j+1), Y(j), Y(j+1), Y1(j), Y1(j+1), x(i));
            end
        end
    end
end

function P = hermite_(x0, x1, y0, y1, y0p, y1p, x)
    P = 0;
    P = P + y0;
    P = P + (x - x0) * y0p;
    fx0x1 = (y1 - y0) / (x1 - x0);
    P = P + (x - x0) * (x - x0) * (y0p - fx0x1) / (x0 - x1);
    P = P + (x - x0) * (x - x0) * (x - x1) * (y1p + y0p - 2 * fx0x1) / (x1 - x0) / (x1 - x0);
end