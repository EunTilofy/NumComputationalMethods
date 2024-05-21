#import "../../template.typ": *

#show: project.with(
	course: "Computing Method",
	title: "Computing Method - Programming 2",
	date: "2024.4.23",
	authors: "Zhixin Zhang, 3210106357",
	has_cover: false
)

= 问题

用 Romberg 方法计算积分：
$
2 / (sqrt(pi)) integral_0^1 e^(-x^2) dx.
$

= 公式与算法
\
*Romberg 算法流程如下：*

+ 输入 $a, b, epsilon$.
+ 设置 $h = (b-a) \/ 2, T_0^((0)) = h(f(a) + f(b)) , k = 1, n = 1$.
+ 设置 $F = 0$.对 $i = 1, 2, dots.c n$，计算 $F = F + f(a + (2i - 1)h)$.
+ $T_0^((k)) = T_0^((k-1))\/2 + h F$.
+ 对 $m = 1, 2, dots.c k$，计算$
T_m^((k-m)) = (4^m T_(m-1)^((k-m+1))-T_(m-1)^((k-m)))/(4^m - 1)
$
+ 若 $abs(T_m^(0) - T_(m-1)^((0))) < epsilon$，输出 $I approx T_m^((0))$，停机；
  否则置 $h/2 arrow.double h, 2n arrow.double n, k + 1 arrow.double k$，返回步骤3.
= 程序

```matlab
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
        for row = 1:k+1-row+1
            fprintf('%.7f ', R(row, col));
        end
        fprintf('\n');
    end
    res = T(k+1, 1);
end
```

= 数据与结果
\
输入 $a = 0, b = 1, epsilon = 1e-6$，程序运行结果如下：
\
#figure(
      image("res.png", width: 90%),
      caption: [
        Result of Romberg Algorithm
      ],
    )
可以发现，一共进行了 15 次迭代，最终答案为 $T_(15)^((0)) = 0.8427007$。

= 结论

该积分的真值近似为 $T approx 0.842700792950$. 该算法的求解误差为 $abs(T - T_(15)^(0)) approx 9e-8 < 1e-7$。