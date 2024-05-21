a = 0;
b = 1;
e = 1e-6;
syms x;
f(x) = exp(-x^2) * 2 / sqrt(pi);
Romberg(f, a, b, e);

function res = Romberg(f, a, b, eps)
    T = zeros(1, 1);
    n = 1;
    k = 1;
    h = (b-a)/2;
    T(1, 1) = h * (f(a) + f(b));
    
    while true
       F = 0;
       for i = 1 : n
           F = F + f(a + (2*i-1)*h);
       end
       T(k+1, k+1) = 0;
       T(1, k+1) = T(k, 1) / 2 + h * F;
       for m = 1 : k
           T(m+1, k-m+1) = (4^m * T(m, k-m+2) - T(m, k-m+1)) / (4^m - 1);
       end
       if(abs(T(k+1, 1) - T(k, 1)) < eps)
           break;
       end
       h = h/2;
       n = 2*n;
       k = k+1;
    end
    disp('Romberg Table: ')
    for col = 1:k+1
        for row = 1:k+1-col+1
            fprintf('%.7f ', T(row, col));
        end
        fprintf('\n');
    end
    res = T(k+1, 1);
end