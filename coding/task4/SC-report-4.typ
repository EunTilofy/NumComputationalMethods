#import "../../template.typ": *

#show: project.with(
	course: "Computing Method",
	title: "Computing Method - Programming 4",
	date: "2024.6.1",
	authors: "Zhixin Zhang, 3210106357",
	has_cover: false
)

= 问题
\
应用科学计算的方法，求下列问题的数值近似解：\
设双曲线 $C_1 : x y = 4$ 及椭圆 $C_2 : x^2 + 4 y^2 = 4$，求在曲线 $C_1, C_2$ 各找一个点 $P_1, P_2$，使得 $abs(P_1 P_2)$ 的距离最小，即
$
abs(P_1 P_2) = min_(Q_1 in C_1, Q_2 in C_2) abs(Q_1 Q_2)
$

= 算法
\
设 $P_1(x_1, 4/(x_1)), P_2 (2 cos x_2, sin x_2)$，则目标函数：$
f(x) = (x_1 - 2 cos x_2)^2 + (4/x_1 - sin x_2)^2.
$
求偏导和二阶导矩阵，得$
nabla f (x) = [2(x_1 - 2cos x_2) - 8/(x_1^2) (4/x_1 - sin x_2), 4 x_1 sin x_2 - 3 sin 2 x_2 - (8 cos x_2) / x_1]^T \
nabla^2 f(x) = bmatrix(2 + 96/x_1^4 - (16 sin x_2) / x_1^3, 4 sin x_2 + (8 cos x_2) / x_1^2;4 sin x_2 + (8 cos x_2) / x_1^2, 4 x_1 cos x_2 - 6 cos 2 x_2 + (8 sin x_2) / x_1)
$
我们采用纯 Newton 法（不带步长因子搜索）求解该问题，算法流程如下（取 $alpha = 1$）：
+ 输入 $x^((0)) in bb(R)^2, 0 leq epsilon < 1$
+ 对于 $k = 0, 1, dots$，循环：
    #set enum(numbering: "(a)")
    + $p_k arrow.l - [nabla^2 f(x^((k)))]^(-1) nabla f(x^((k)))$.
    + $x^((k+1)) arrow.l x^((k)) + alpha p_k$。
    + 如果 $norm(nabla f(x^((k+1)))) leq epsilon$，退出循环；否则，继续执行。
+ 输出 $x^((k+1))$。

= 程序

```matlab
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
```

= 数据与结果

我们以 $(x_1, x_2) = (0.5, 0.5)$，作为初始猜测执行 Newton 法，最后得到答案为 $(x_1, x_2) = (2.3910,6.9036)$。

= 结论

#figure(
      image("1.png", width: 90%),
    )
将求解出的 $P_1, P_2$ 标在图像上，可以看出，求解结果正确。
根据图的对称性，将 $P_1, P_2$ 沿坐标轴对称后的点对同样满足条件。