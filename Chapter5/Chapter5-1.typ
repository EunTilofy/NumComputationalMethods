#import "../template.typ": *

#show: project.with(
	course: "Computing Method",
	title: "Computing Method - Chapter5",
	date: "2024.4.5",
	authors: "Zhixin Zhang, 3210106357",
	has_cover: false
)

*Problems：1,2(1),5,6*

#HWProb(name: "1")[
  试证明：

  #set enum(numbering: "(1)")
  + $integral_a^b f(x) dx = (b - a)f(a) + (b-a)^2 / 2 f'(xi), a < xi < b$.
  + $integral_a^b f(x) dx = (b - a)f(b) - (b-a)^2 / 2 f'(eta), a < eta < b$.
  + $integral_a^b f(x) dx = (b - a)f((a+b)/2) + (b-a)^3/24 f''(zeta), a < zeta < b$.
]

#Proof[
  #set enum(numbering: "(1)")
  + $
  integral_a^b f(x) dx = integral_a^b f(a) + (x - a) f'(xi_x) dx = (b - a) f(a) + integral_a^b (x - a) f'(xi_x) dx,
  $ 根绝 $f'(x)$ 在 $[a, b]$ 有界可设 $m leq f'(x) leq M$，所以 $
  integral_a^b m(x - a) dx < integral_a^b (x - a) f'(xi_x) dx < integral_a^b M(x - a) dx \
  arrow.double
  ((b-a)^2)/2 m < integral_a^b (x - a) f'(xi_x) dx < ((b-a)^2)/2 M,
  $ 所以，有$
  m leq (integral_a^b f(x) dx - (b - a)f(a))/(1/2 (b-a)^2) leq M,
  $ 根据 $f in C^1$ 可知存在 $xi in (a, b)$，满足 $
  f'(xi) = (integral_a^b f(x) dx - (b - a)f(a))/(1/2 (b-a)^2),
  $ 所以 $integral_a^b f(x) dx = (b - a)f(a) + (b-a)^2 / 2 f'(xi)$。
  + $
  integral_a^b f(x) dx = - integral_b^a f(x) dx,
  $ 类似(1)的证明，存在 $eta in (a, b)$，$
  integral_b^a f(x) dx = (a - b) f(b) + (b-a)^2 / 2 f'(eta),
  $ 所以 $
  integral_a^b f(x) dx = (b - a) f(b) - (b-a)^2 / 2 f'(eta).
  $
  + $forall x in [a, b], f(x) = f((a+b)/2) + (x - (a+b)/2) f'((a+b)/2) + (x - (a+b)/2)/2 f''(xi_x), xi in [min(x, (a+b)/2), max(x, (a+b)/2)]$，
  $
  integral_a^b f(x) dx &= integral_a^b f((a+b)/2) + (x - (a+b)/2) f'((a+b)/2) + 
  (x - (a+b)/2)^2/2 f''(xi_x) dx \
  &= (b - a) f((a+b)/2) + integral_a^b (x - (a+b)/2)/2 f''(xi_x) dx.
  $ 根绝 $f'(x)$ 在 $[a, b]$ 有界可设 $m leq f'(x) leq M$，所以$
  integral_a^b m (x - (a+b)/2)^2 / 2 dx < integral_a^b (x - (a+b)/2)^2/2 f''(xi_x) dx < integral_a^b M (x - (a+b)/2)^2 / 2 dx \
  arrow.double (b-a)^3/24 m leq integral_a^b (x - (a+b)/2)^2/2 f''(xi_x) dx leq (b-a)^3/24 M.
  $ 所以，有 $
  m leq (integral_a^b f(x) dx - (b-a) f((a+b)/2))/(1/24 (b-a)^3) leq M,
  $ 根据 $f in C^1$ 可知存在 $zeta in (a, b)$，满足 $
  f'(zeta) = (integral_a^b f(x) dx - (b-a) f((a+b)/2))/(1/24 (b-a)^3),
  $ 所以 $integral_a^b f(x) dx = (b - a)f((a+b)/2) + (b-a)^3/24 f''(zeta)$。
]


#HWProb(name: "2(1)")[
  用梯型公式和抛物线公式计算积分，并比较其结果。
  $
  integral_0^1 x / (4 + x^2) dx quad quad text("(八等分)").
  $
]

#solution[
  #set enum(numbering: "(1)")
  + $1/8 (1/2 f(0) + f(1/8) + dots.c + f(7/8) + 1/2 f(1)) = 0.11140235$
  + $1/8 (1/6 f(0) + 2/3 f(1/16) + 1/3 f(1/8) + 2/3 f(3/16) + 1/3 f(2/8) + dots.c + 2/3 f(15/16) + 1/6 f(1)) = 0.11157181$
  + 真值 $integral_0^1 x / (4 + x^2) dx = 1/2 ln(5/4) = 0.11157177$，\
    使用梯型公式计算误差为：0.000169，\
    使用抛物线公式计算误差为：3.75e-8，\
    可以发现使用抛物线公式计算效果更好。
]

#HWProb(name: "5")[
  如果 $f''(x) > 0$, 证明用梯型公式计算积分 $integral_a^b f(x) dx$ 所得结果比准确值大，并说明其几何意义。
]

#Proof[
  因为 $f''(x) > 0$，所以 $f$ 是凸函数，所以有$
    f(t a + (1-t)b) < t f(a) + (1-t)f(b), forall 0 < t < 1,
  $
  所以$
  integral_a^b f(x) dx &= (b - a)integral_0^1 f(t a + (1- t)b) dt \
  &< (b - a) integral_0^1 (t f(a) + (1-t) f(b)) dt \
  &= (b-a)/2 (f(a) + f(b)).
  $
  对于凸函数，因为其任意两点间割线总是位于这两点间曲线的上方，所以使用割线以下梯形的面积作为积分的估计总是比真实值来的大。
]

#HWProb(name: "6")[
  验证当 $f(x) = x^5$ 时，$n = 4$ 的 Newton-Cotes 公式是准确的。
]

#Proof[
  对于 $n = 4$，Newton-Cotes 公式为
  $
  integral_a^b f(x) dx approx (b-a)/90  (7f(a) + 32 f((3a+b)/4) + 12 f((a+b)/4) 
  + 32 f((a+3b)/4) + 7 f(b)),
  $ 对于 $f(x) = x^5$， $
  (b-a)/90 (7a^5 + 30((3a+b)/4)^5 + 12((a+b)/2)^5 + 32((a+3b)/4)^5 + 7b^5 = (b-a)^6/6.
  $ 所以公式是准确的。
]