#import "../template.typ": *

#show: project.with(
	course: "Computing Method",
	title: "Computing Method - Chapter2",
	date: "2024.3.22",
	authors: "Zhixin Zhang, 3210106357",
	has_cover: false
)

// #show: rest => columns(2, rest)

*Problems：Exercise-2,9,10,14*

#HWProb(name: "Exercise-2")[
	导出三弯矩方程组，并对 $s'(x_0), s'(x_n)$ 给定进行讨论。
]

#solution[
记 $M_i = s''(x_i),i = 0, dots, n$，
将 $s(x)$ 在 $x_i$ 处展开得
$
s(x) = y_i + s'(x_i) (x - x_i) + (M_i) / 2 (x  - x_i)^2 + (s'''(x_i))/6 (x - x_i)^3, x in [x_i, x_(i+1)]
$
对其求二阶导，得 $s''(x) = M_i + s'''(x_i) (x - x_i)$，取 $x = x_(i+1)$ 得 $s'''(x_i) = (M_(i+1) - M_i)/(x_(i+1) - x_i)$，
代回上式得
$
y_(i+1) - y_i = s'(x_i) (x_(i+1)-x_i) + ((M_i)/2 + (M_(i+1)-M_i)/6)(x_(i+1)-x_i)^2 \
arrow.double s'(x_i) = (y_(i+1)-y_i)/(x_(i+1)-x_i) - 1/6 (M_(i+1)+2M_i)(x_(i+1)-x_i)
$
同理可得
$
s'(x_i) = (y_(i-1)-y_i)/(x_(i-1)-x_i) - 1/6 (M_(i-1)+2M_i)(x_(i-1)-x_i)
$
设 $f[x_(i-1), x_i, x_(i+1)] = ((y_(i-1)-y_i)/(x_(i-1)-x_i) - (y_(i+1)-y_i)/(x_(i+1)-x_i))/(x_(i+1) - x_(i-1)), mu_i = (x_i-x_(i-1))/(x_(i+1)-x_(i-1)), lambda_i = (x_(i+1)-x_(i))/(x_(i+1)-x_(i-1)), i = 1, dots, n-1$。
所以有
$
mu_i M_(i-1) + 2M_i + lambda_i M_(i+1) = 6f[x_(i-1), x_i, x_(i+1)],
$
若给定条件，$s'(x_0) = beta_1, s'(x_n) = beta_2$，那么有
$
beta_1 = (y_1 - y_0)/(x_1 - x_0) - 1/6 (M_1 + 2M_0)(x_1 - x_0),
\
beta_2 = (y_(n-1)-y_n)/(x_(n-1)-x_n)-1/6(M_(n-1)+2M_n)(x_(n-1)-x_n)
$
最后得到方程组
$
bmatrix(
	1, 2, kk, kk, kk, kk, kk, kk;
	kk , 1,2,1, kk, kk, kk, kk;
	kk, kk, 1, 2, 1, kk, kk, kk;
	kk, kk, kk, dots.down, dots.down, dots.down, kk, kk;
	kk, kk, kk, kk, 1, 2, 1, kk;
	kk, kk, kk, kk, kk, 1, 2, 1; 
	kk, kk, kk, kk, kk, kk, 1, 2
)
bmatrix(
	M_0;M_1;M_2;dots.v;M_(n-2);M_(n-1);M_n
)=
bmatrix(
	6 (y_1 - y_0)/(x_1 - x_0)^2 - 6beta_1/(x_1 - x_0);
	6 f[x_0, x_1, x_2];
	6 f[x_1, x_2, x_3];
	dots.v;
	6 f[x_(n-3), x_(n-2), x_(n-1)];
	6 f[x_(n-2), x_(n-1), x_n];
	6 (y_(n-1)-y_n)/(x_(n-1)-x_n)^2 - 6beta_2/(x_(n-1)-x_n)
)
$
]

#HWProb(name: 9)[
	利用(2.37)式和 Newton 插值公式作两点三次 Hermite 插值多项式，
	并求前一题的解。
]

#solution[

#tablex(
  columns: 5,
  auto-hlines: false,
  auto-vlines: false,
  (), vlinex(), (), (), (),
  $x_0$, $y_0$, [], [], [], 
  $x_0$, $y_0$, $y'_0$, [], [],
  $x_1$, $y_1$, $f[x_0, x_1]$, $(y'_0-f[x_0, x_1])/(x_0 - x_1)$, [],
  $x_1$, $y_1$, $y'_1$, $(y'_1 - f[x_0, x_1])/(x_1 - x_0)$, $(y'_1+y'_0-2f[x_0, x_1])/(x_1 - x_0)^2$,
)

所以，
$
f(x) = (y'_1+y'_0-2f[x_0, x_1])/(x_1 - x_0)^2 (x - x_0)^2(x-x_1) + (y'_0-f[x_0, x_1])/(x_0 - x_1) (x - x_0)^2 + y'_0 (x - x_0) + y_0
$

代入 $y_0 = 1, y'_0 = 1/2, y_1 = 2, y'_1 = 1/2, x_0 = 0, x_1 = 1$，得
$
f(x) = -x^3 + 3/2 x^2 + 1/2 x + 1
$
]

#HWProb(name: 10)[
	给定数组

	#tablem[
	| $x$ | 75 | 76 | 77 | 78 | 79 | 80 | 
	| --- | -- | -- | -- | -- | -- | -- | 
	| $y$ | 2.768 | 2.833 | 2.903 | 2.979 | 3.062 | 3.153
	]

#block[
 #set enum(numbering: "(1)")
 + 作一分段线性插值函数；
 + 取第二类边界条件，作三次样条插值多项式；
 + 用两种插值函数分别计算 $x = 75.5$ 和 $x = 78.3$ 的函数值。 
 ]
]

#solution[
#block[
#set enum(numbering: "(1)")
(1)
$I_5(x) = sum_(i=1)^5 y_i l_i (x)$，其中，
$
l_0 (x) = cases(76 - x quad x in [75, 76], 0 quad  "otherwise"),
\
l_j (x) = cases(x - j - 74 quad x in [74 + j, 75 + j], 76 + j - x quad x in [75 + j, 76 + j], 0 quad "otherwise"), quad (j = 1, 2, 3, 4)
\
l_5 (x) = cases(80 - x quad x in [79, 80], 0 quad  "otherwise")
$
\
(2)
取两端点处一阶导值为0，根据(2.62)得到方程组
$
cases(
  m_0 = m_5 = 0,
  1/2 m_0 + 2m_1 + 1/2 m_2 = 0.015,
  1/2 m_1 + 2m_2 + 1/2 m_3 = 0.018,
  1/2 m_2 + 2m_3 + 1/2 m_4 = 0.014,
  1/2 m_3 + 2m_4 + 1/2 m_5 = 0.016
)
$
解得，$m_0 = 0, m_1 = 0.0058, m_2 = 0.0067, m_3 = 0.0036, m_4 = 0.0071, m_5 = 0$，
那么样条在区间 $[x_(i-1), x_i], i = 1, 2, 3, 4, 5$ 上的表达式为，
$
s(x) = (1 + 2x - 2x_(i-1))(x-x_i)^2y_(i-1) + (1 -2x + 2x_i)(x-x_(i-1))^2y_i+\
(x-x_(i-1))(x-x_i)^2 m_(i-1) + (x-x_i)(x-x_(i-1))^2 m_(i)
$
(3)
$
I_5 (75.5) = 2.768 l_0 (75.5) + 2.833 l_1 (75.5) = 2.8005
\
I_5 (78.3) = 2.979 l_3 (78.3) + 3.062 l_4 (78.3) = 3.0039
$
$
s(75.5) = (1 + 2x - 2 times 75)(x-76)^2 times 2.768 + (1 -2x + 2 times 76)(x-75)^2 times 2.833 + (x-76)(x-75)^2 times 0.0058 = 2.799
\
s(78.3) = (1 + 2x - 2 times 78)(x-79)^2 times 2.979 + (1 - 2x + 2 times 79)(x-78)^2 times 3.062+\
(x-78)(x-79)^2 times 0.0036 + (x-79)(x-78)^2 0.0071 = 3.0034
$
]
]

#HWProb(name : 14)[
	称 $n$ 阶方阵 $Am = (a_(i j))$ 具有严格对角优势，若
$
abs(a_(i i)) > sum_(j = 1, j eq.not i)^n abs(a_(i j)), i = 1, 2, dots.c, n
$

#block[
 #set enum(numbering: "(1)")
 + 证明：具有严格对角优势的方阵必可逆；
 + 证明：方程组 （2.62） 存在唯一解。
 ]

]

#Proof[
#block[
#set enum(numbering: "(1)")
(1) 设矩阵 $A$ 行严格对角占优，如果 $A$ 奇异，那么存在 $xm eq.not vb("0"), A xm = vb("0")$。所以，
$
  sum_(j=1)^n a_(i j) x_j = 0, i = 1, 2, dots, n
$
令 $i_0 = arg max_(1 leq i leq n) |x_i|$。则，
$
abs(a_(i_0 i_0) x_(i_0))
=
abs(-sum_(j=1,j eq.not i_0)^n a_(i_0, j)x_j)
leq sum_(j=1, j eq.not i_0)^n
abs(a_(i_0,j))abs(x_j) leq
abs(x_(i_0)) sum_(j=1, j eq.not i_0)^n abs(a_(i_0, j))
$
所以 $abs(x_(i_0)) ( abs(a_(i_0, i_0)) - sum_(j=1, j eq.not i_0)^n abs(a_(i_0, j))) leq 0 arrow.double abs(a_(i_0, i_0)) - sum_(j=1, j eq.not i_0)^n abs(a_(i_0, j)) leq 0$，
这与 $A$ 对角占优的假设相矛盾，因此 $A$ 必可逆。\
(2) 方程组(2.62)按行严格对角占优，根据(1)，其矩阵必然可逆，所以此方程组必然存在唯一解。
]
]

