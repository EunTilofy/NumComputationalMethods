#import "../template.typ": *

#show: project.with(
	course: "Computing Method",
	title: "Computing Method - Chapter3",
	date: "2024.4.1",
	authors: "Zhixin Zhang, 3210106357",
	has_cover: false
)

// #show: rest => columns(2, rest)

*Problems：2,7,9*

#HWProb(name: "2")[
  给出数据

  #tablex(
  columns: 10,
  // auto-hlines: false,
  // auto-vlines: false,
  [$x$], [-1.00], [-0.75], [-0.50], [-0.25], [0], [0.25], [0.50], [0.75], [1.00], 
  [$y$], -0.2209, 0.3295, 0.8826, 1.4392, 2.0003, 2.5645, 3.1334, 3.7061, 4.2836
)

用一次、二次、三次多项式及最小二乘原理拟合这些数据，并写出正规方程组。
]

#solution[
#set enum(numbering: "(1)")
令 $xm_1 = [x_1, dots.c, x_9]^T, xm_2 = [x_1^2, dots.c, x_9^2]^T, 
xm_3 = [x_1^3, dots.c, x_9^3]^T, vm = [1, dots.c, 1]^T,
ym = [y_1, dots.c, y_9]^T in bb(R)^9$。
+ $vb("一次拟合")$ \
  设拟合多项式为 $y = a x + b$，
  那么正规方程组为：
  $
  cases(
    xm_1^T (ym - a xm_1 - b vm) = vb("0"),
    vm^T (ym - a xm_1 - b vm) = vb("0").
  )
  arrow.double
  cases(
    xm_1^T xm_1a + xm_1^T vm b = xm_1^T ym,
    vm^T xm_1 a + vm^T vm b = vm^T ym
  )
  $
  解得：$[a, b] = [2.25164667, 2.01314444]$。
  所以 $y^\*_1 = 2.25165 x +  2.01314$。
+ $vb("二次拟合")$ \
  设拟合多项式为 $y = a x^2 + b x + c$，
  那么正规方程组为：
  $
  cases(
    xm_1^T (ym - a xm_2 - b xm_1 - c vm) = vb("0"),
    xm_2^T (ym - a xm_2 - b xm_1 - c vm) = vm("0"),
    vm^T (ym - a xm_2 - b xm_1 - c vm) = vb("0").
  )
  arrow.double
  cases(
    xm_1^T xm_2 a + xm_1^T xm_1 b + xm_1^T vm c = xm_1^T ym,
    xm_2^T xm_2 a + xm_2^T xm_1 b + xm_2^T vm c = xm_2^T ym,
    vm^T xm_2 a + vm^T xm_1 b + vm^T vm c = vm^T ym,
  )
  $
  解得：$[a, b, c] = [0.03130563, 2.25164667, 2.00010043]$，
  所以 $y_2^\* = 3.13056e-2 x^2 + 2.25165 x + 2.00010$。
+ $vb("三次拟合")$ \
  设拟合多项式为 $y = a x^3 + b x^2 + c x + d$，
  那么正规方程组为：
  $
  cases(
    xm_1^T (ym - a xm_3 - b xm_2 - c xm_1- d vm) = vb("0"),
    xm_2^T (ym - a xm_3 - b xm_2 - c xm_1 - d vm) = vm("0"),
    xm_3^T (ym - a xm_3 - b xm_2 - c xm_1 - d vm) = vm("0"),
    vm^T (ym - a xm_3 - b xm_2 - c xm_1 - d vm) = vb("0").
  )
  arrow.double
  cases(
    xm_1^T xm_3 a + xm_1^T xm_2 b + xm_1^T xm_1 c + xm_1^T vm d = xm_1^T ym,
    xm_2^T xm_3 a + xm_2^T xm_2 b + xm_2^T xm_1 c + xm_2^T vm d = xm_2^T ym,
    xm_3^T xm_3 a + xm_3^T xm_2 b + xm_3^T xm_1 c + xm_3^T vm d = xm_3^T ym,
    vm^T   xm_3 a + vm^T   xm_2 b + vm^T xm_1 c + vm^T   vm d = vm^T ym,
  )
  $
  解得：$[a, b, c,  d] = [2.08484848e-3, 3.13056277e-02, 2.25010909, 2.00010043]$，
  所以 $y^\*_3 = 2.08485e-3 x^3+ 3.13056e-2 x^2 + 2.25011 x + 2.00010$。
]


#HWProb(name: "7")[
设 $f(x), phi_1 (x), phi_2(x), dots.c, phi_p (x) in C_([a, b])$，
且 (3.29) 式成立，试求 $phi(x) = alpha_1 phi_1(x) + dots.c alpha_p phi_p (x)$ 达到
$
min_(alpha_1, dots. alpha_p) (f-phi, f - phi)
$
之参数 $alpha_1, alpha_2, dots.c, alpha_p$。
]

#solution[
令 $g(a_1, dots.c a_p) = (f - phi, f - phi)=  integral_a^b [f(x) - sum_i^p a_i phi_i (x)]^2 dx$，对 $a_i (i = 1, dots.c p)$ 求偏导得到：
$
  (partial g) / (partial a_i) &= - 2 integral_a^b f(x) phi_i (x) dx + 2 sum_(j eq.not i, j= 1)^p a_j integral_a^b phi_i (x) phi_j (x) dx + 2 a_i integral_a^b phi_i^2 (x) dx \
  &= -2 integral_a^b f (x) phi_i (x) dx + 2 a_i sigma_i.
$ 
令 $(partial g) / (partial a_i) = 0, (i = 1, dots.c p)$ 得到，
$
a_i = (integral_a^b f(x) phi_i (x) dx)/(sigma_i), i = 1, dots.c p.
$
]

#HWProb(name: "9")[
  试证明如下给出的多项式是正交多项式系。
  $
  P_0(x) = 1, P_1(x) = x - alpha_0 \
  P_(k+1) (x) = (x - alpha_k) P_k (x) - beta_(k-1) P_(k-1) (x), \
  alpha_k = ((x P_k, P_k))/((P_k, P_k)), beta_k = ((x P_(k), P_(k+1)))/((P_k, P_k)) = ((P_(k+1), P_(k+1)))/((P_k, P_k)) ,  k = 0, 1, 2, dots.c
  $
]

#Proof[
设 $(f, p) = integral_a^b w(x) f(x) g(x) dx$，
$
((x - alpha_k) P_k, P_k) = (x P_k, P_k) - ((x P_k, P_k))/((P_k, P_k)) (P_k, P_k) = 0,
$
因为 $P_1 = (x - alpha_0) P_0$，所以 $(P_0, P_1) = 0$。
下用数学归纳法证明，设当 $n leq k(k geq 1)$ 时，满足 $P_0, P_1, dots, P_n$ 是正交多项式系，对于 $P_(k+1) (x) = (x - alpha_k) P_k (x) - beta_(k-1) P_(k-1) (x)$，
$
(P_(k+1), P_(k)) &= ((x - alpha_k) P_k, P_k) - beta_(k-1) (P_(k-1), P_k) = 0, \
(P_(k+1), P_(k-1)) &= ((x - alpha_k) P_k, P_(k-1)) - beta_(k-1) (P_(k-1), P_(k-1)) \
&= (x P_k, P_(k-1)) - alpha_k (P_k, P_(k-1)) - ((x P_(k-1), P_(k)))/((P_(k-1), P_(k-1)))(P_(k-1), P_(k-1)) \
&= (x P_k, P_(k-1)) - (P_(k-1), x P_k) \
&= integral_a^b w(x) x P_k P_(k-1) dx - integral_a^b w(x) P_(k-1) x P_(k) dx = 0, 
$
对于 $j = 0, dots.c , k-2$，
$
(P_(k+1), P_j) &= ((x - alpha_k) P_k, P_j) - beta_(k-1) (P_(k-1), P_j) \
&= (x P_k, P_j) - alpha_k (P_k, P_j) \
&= (x P_k, P_j) = (P_k, x P_j) \
&= (P_k, P_(j+1) + beta_(j-1) P_(j-1) + alpha_j P_j) \
&= (P_k, P_(j+1)) + beta_(j-1) (P_k, P_(j-1)) + alpha_j (P_k, P_j) \
&= 0
$
所以，$P_0, dots.c , P_(n+1) $ 也是正交多项式系。
因此题中给出的多项式是正交多项式系。
]