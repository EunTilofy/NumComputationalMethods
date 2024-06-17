#import "../template.typ": *

#show: project.with(
	course: "Computing Method",
	title: "Computing Method - Chapter10-2",
	date: "2024.6.1",
	authors: "Zhixin Zhang, 3210106357",
	has_cover: false
)

*Problems：4,6,7*

#HWProb(name: "10-4")[
  求 $f(x) = x^3 - 3x -1 = 0$ 在 $x_0 = 2$ 附近的实根，准确到小数点后第 $4$ 位，讨论其收敛性。
  #set enum(numbering: "(1)")
  + 用迭代法；
  + 用 Newton 法；
  + 用弦位法。
]

#solution[
  #set enum(numbering: "(1)") 
  + 迭代法：$x_(n+1) = (3x + 1)^(1/3)$，```python 
x = 2
x1 = (1+3*x)**(1/3)
n = 1
print(x, x1)

while abs(x - x1) > 5e-5:
    _ = x1
    x1 = (1+3*x1)**(1/3)
    x = _
    n = n + 1
    print(x1)

print(x1, n)
  ``` 7次迭代后，得到答案 $hat(x) = 1.8794$。对于 $phi(x) = (3x + 1)^(1/3)$，$phi([1, 2]) in [1, 2]$，且 $forall x in [1, 2], abs(phi'(x)) leq L < 1, phi'(2) approx 0.27$，所以该迭代法收敛。
  + Newton 法：$x_(n+1) = x_n - (f(x_n))/(f'(x_n)) = x_n - (x_n^3 - 3x_n - 1)/(3x_n^2 - 3)$,```python
x = 2
x_1 = x - (x**3-3*x-1)/(3*x**2 - 3)
n = 1
print(x, x1)
while abs(x - x1) > 5e-5:
    _ = x1
    x1 = x1 - (x1**3-3*x1-1)/(3*x1**2 - 3)
    x = _
    n = n + 1
    print(x1)
print(x1, n)
  ```2次迭代后得到 $hat(x) = 1.8794$。根据 *10-7* 该方法二阶收敛。
  + 弦位法：$x_(n+1) = x_n - (f(x_n))/(f(x_n)-f(x_(n-1)))(x_n - x_(n-1)) = x_n - (x_n^3 - 3x_n - 1)/(x_n^2 + x_n x_(n-1)+  x_(n-1)^2-3)$，取 $x_0 = 2, x_1 = 1.5$.```python
x0 = 2
x1 = 1.5
n = 1
print(x0, x1)
while abs(x0 - x1) > 5e-5:
    _ = x1
    x1 = x1 - (x1**3-3*x1-1)/(x1**2+x0*x1+x0**2-3)
    x0 = _
    n = n + 1
    print(x1)
print(x1, n)
  ``` 6次迭代后得到 $hat(x) = 1.8794$。因为 $f(x)$ 在 $x^*$ 附近有连续的二阶微商，且 $f'(x^*) eq.not 0$，当所取的初始值充分接近 $x^*$ 时，该方法收敛，收敛阶接近 $p = (sqrt(5)+ 1)/2$。
]

#HWProb(name: "10-6")[
  用牛顿法求 $x^3 - c = 0$ 的根，写出迭代公式和收敛阶。
]

#solution[
   $f(x) = x^3 - c, f'(x) = 3x^2, x_(n+1) = x_n - (x^3 - c)/(3x_n^2) = 2/3x_n+ c/(3x_n^2)$。该方法是二阶收敛的，设 $epsilon_n = x_n - c^(1/3)$，所以
   $
   epsilon_(n+1) &= 2/3 x_n + c/(3x_n^2) - c^(1/3) \
   &= x_n - c^(1/3) - 1/3 x_n + c/(3x_n^2) \
   &= x_n - c^(1/3) - (x_n^3 - c) / (3x_n^2) \
   &= (x_n - c^(1/3)) (1 - (x_n^2 + x_n c^(1/3) + c^(2/3))/(3x_n^2)) \
   &= (x_n - c^(1/3)) (2x_n^2 - x_n c^(1/3) - c^(2/3))/(3x_n^2) \
   &= (x_n - c^(1/3))^2 (2x_n + c^(1/3))/(3x_n^2) \
   &= epsilon_n^2 ((2x_n + c^(1/3))/(3 x_n^2))
   $
   所以 $epsilon_(n+1) / epsilon_n^2 = (2x_n + c^(1/3))/(3x_n^2) arrow (3 c^(1/3))/(3 c^(2/3)) = c^(-1/3)$，所以收敛阶为2.
]

#HWProb(name: "10-7")[
  试证明：
  #set enum(numbering: "(1)")
  + Newton 法在单根附近二阶收敛；
  + Newton 法在重根附近一阶收敛。
]

#Proof[
  #set enum(numbering: "(1)")
  对于方程 $f(x) = 0$，使用 Newton 法 $x_(n+1) = x_n - (f(x_n))/(f'(x_n))$，设根为 $alpha$：
  + 在根处 Taylor 展开得到：（$xi$ 在 $alpha$ 到 $x_n$ 之间）$
  f(alpha) = f(x_n) + (alpha - x_n) f'(x_n) + (alpha - x_n)^2/2 f''(xi)
  $ 因为 $f(alpha) = 0$，所以 $-alpha = - x_n + f(x_n)/(f'(x_n)) + (alpha - x_n)^2 / 2 (f''(xi))/(f'(x_n))$，所以$ x_(n+1) - alpha = 1/2 (x_n - alpha)^2 (f''(xi))/(f'(x_n)) $ 因为 $f'$ 连续，且由于 $alpha$ 是单根，所以 $f'(alpha) eq.not 0$，所以 $exists delta > 0, text("s.t. ") forall x in [alpha - delta, alpha + delta], f'(x) eq.not 0$。定义 $ M = (max_(x in [alpha - delta, alpha + delta]) abs(f''(x)))/(2 min_(x in [alpha - delta, alpha + delta]) abs(f'(x))) $ 若选择足够接近 $alpha$ 的 $x_0$，满足以下条件： $1, abs(x_0 - alpha) < delta; quad 2, M abs(x_0 - alpha) < 1$。 那么$ x_(n+1) - alpha leq M(x_n - alpha^2) arrow.double abs(x_n - alpha) leq 1/M (M abs(x_0 - alpha))^(2^n) $ 所以 ${x_n}$ 二阶收敛到 $alpha$。
  + 对于 $k$ 重根 $alpha$，设 $f(x) = g(x)(x - alpha)^k$， 那么$g(alpha) eq.not 0, g in C^1$，那么$
  x_(n+1) &= x_n - (g(x_n)(x_n - alpha)^k)/(k g(x_n)(x_n - alpha)^(k-1)+g'(x_n)(x_n - alpha)^k) \
  &= x_n - (g(x_n)(x_n-alpha))/(k g(x_n) + g'(x_n)(x_n - alpha))
  $ 所以，$
    x_(n+1) - alpha &= x_n - alpha - (g(x_n)(x_n-alpha))/(k g(x_n) + g'(x_n)(x_n - alpha)) \
    &= (x_n - alpha) (1 - (g(x_n))/(k g(x_n) + g'(x_n)(x_n - alpha))) \
    &= (x_n - alpha) [((k-1) g(x_n) + g'(x_n)(x_n - alpha)) / (k g(x_n) + g'(x_n)(x_n - alpha))] \
    &= (x_n - alpha) [1/(1 + g(x_n)/((k-1) g(x_n) + g'(x_n)(x_n - alpha)) )]
  $ 当 $abs(x_0 - alpha) < abs(((k-1) min_(x in D_f) abs(g(x)) - epsilon)/(max_(x in D_f) abs(g'(x))))，((k-1) min_(x in D_f) abs(g(x)) > epsilon > 0)$ 时,$
  (x_(n+1) - alpha) / (x_n - alpha) < M = 1/(1 + (max_(x in D_f) abs(g(x_n)))/(epsilon )) < 1
  $ 所以 ${x_n}$ 一阶收敛到 $alpha$。
]