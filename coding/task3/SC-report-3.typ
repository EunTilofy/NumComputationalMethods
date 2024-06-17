#import "../../template.typ": *

#show: project.with(
	course: "Computing Method",
	title: "Computing Method - Programming 3",
	date: "2024.6.1",
	authors: "Zhixin Zhang, 3210106357",
	has_cover: false
)

= 问题
\
编写列主元的 Gauss 消去法求解线性方程组。\
尝试不同的测试例子，其中可能的一个例子：Hilbert 矩阵 $H = (h_(i j))$，$
h_(i j) = 1 / (i + j - 1)
$

= 算法
\
+ 输入系数矩阵 $A$，右端项 $b$，阶 $n$。
+ 对 $k = 1,2, dots, n-1$，循环：
    #set enum(numbering: "(a)")
    + 按列选主元 $alpha = max_(k leq i leq n) abs(a_(i k))$，保存主元所在的行指标 $i_k$。
    + 若 $alpha = 0$，则系数矩阵奇异，计算停止；否则顺序进行。
    + 若 $i_k = k$，则转向 (d)；否则换行:$
    a_(i_k, j) arrows.lr a_(k j), j = 1, 2, dots, n \
    b_(i_k) arrows.lr b_(k).
    $
    + 计算乘子 $m_(i k) = a_(i k) / a_(k k) arrow.double a_(i k), i = k + 1, dots, n$。
    + 消元：$
    a_(i j) := a_(i j) - m_(i k) a_(k j), i, j = k+1, dots, n\
    b_i := b_i - m_(i k) b_k, i = k + 1, dots, n
    $
+ 回代：$
    b_i := (b_i - sum_(j = i +1)^n a_(i j) b_j) / a_(i i), i = n, n -1, dots, 1
$

= 程序

== 构造 Hilbert 矩阵和右端项

```matlab
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
```

== 列主元 Gauss 消元

```matlab
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
```


= 数据与结果

为了方便比较误差，我们对于 5 阶到 17 阶的 Hilbert 矩阵分别构造了解为 $x_1 = x_2 = \cdots = x_n = 1$ 的右端项。并进行 Gauss 消元求解测试。

测试代码如下：
```matlab
for n = 5:17
    H = Hilbert(n);
    b = construct_RHS(H, n);
    x = Gauss(H, b, n);
    % x
    x_ = ones(1,n);
    e = norm(abs(x-x_))/sqrt(n);
    e
end
```
我们定义误差的计算公式为：
$
    epsilon = sqrt((sum_(i=1)^n (vb("x")_i-hat(x)_i)^2)/(n))
$
最后得到不同 $n$ 的求解误差如下：
#tablex(
  columns: 7,
  // auto-hlines: false,
  // auto-vlines: false,
  [$n$], [5], [6], [7], [8], [9], [10], 
  [$epsilon$], "6.0808e-13", "3.0340e-10", "1.2428e-08", "1.9735e-07", "8.5773e-06", "1.8210e-04", [11], [12], [13], [14], [15], [16], [17], "0.0063", "0.0727", "6.3890", "3.2200", "4.6501","4.1133","7.6828"
)

可以看出在 $n leq 10$ 的时候，算法得到的误差较小（小于 $2e-4$），但是当 $n geq 11$ 之后，算法误差变得不可接受。

= 结论

列主元消元法对条件数不是很大的方程组都可以得到精确解，但对高阶Hilbert方程组这类病态的方程组，消元求出的数值解是完全没有意义的。