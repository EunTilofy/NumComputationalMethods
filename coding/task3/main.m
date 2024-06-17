for n = 5:17
    H = Hilbert(n);
    b = construct_RHS(H, n);
    x = Gauss(H, b, n);
    % x
    x_ = ones(1,n);
    e = norm(abs(x-x_))/sqrt(n);
    e
end

function P = Hilbert(n)
    P = zeros(n, n);
    for i = 1:n
        for j = 1:n
            P(i, j) = 1.0/(i+j-1);
        end
    end
end

function P = construct_RHS(H, n)
    P = zeros(n, 1);
    for i = 1:n
        for j = 1:n
            P(i) = P(i) + H(i, j);
        end
    end
end

function P = Gauss(A, b, n)
    P = zeros(1, n);
    for k = 1:n
        id_ = k;
        for j = k:n
            if abs(A(id_, k)) < abs(A(j, k))
                id_ = j;
            end
        end
        for j = k:n
            t = A(id_, j);
            A(id_, j) = A(k, j);
            A(k, j) = t;
        end
        t = b(id_);
        b(id_) = b(k);
        b(k) = t;
        num = A(k, k);
        for j = k:n
            A(k, j) = A(k, j) / num;
        end
        b(k) = b(k) / num;
        if k ~= n
            for i = k+1:n
                num = A(i, k);
                for j = k:n
                    A(i, j) = A(i, j) - num * A(k, j);
                end
                b(i) = b(i) - num * b(k);
            end
        end
    end
    P(n) = b(n);
    for j=(-1)*(1:n-1)+n
        P(j) = b(j);
        for k = j+1:n
            P(j) = P(j) - A(j, k) * P(k);
        end
    end
end