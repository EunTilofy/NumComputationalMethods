#import "../template.typ": *

#show: project.with(
	course: "Computing Method",
	title: "Computing Method - Chapter6",
	date: "2024.4.30",
	authors: "Zhixin Zhang, 3210106357",
	has_cover: false
)

*Problems：1，3，4，5*

#HWProb(name: "1")[
  用 Gauss 消去法解方程组：
  $
  bmatrix(2, 3, 4; 1, 1, 9; 1, 2, -6) bmatrix(x_1; x_2; x_3) = bmatrix(0; 2; 1)
  $
  并求系数矩阵的行列式和逆矩阵。
]

#solution[
$
bmatrix(2, 3, 4, 0; 1, 1, 9, 2; 1, 2, -6, 1) arrow
bmatrix(2, 3, 4, 0; 0, -1/2, 7, 2; 0, 1/2, -8, 1) arrow
bmatrix(2, 3, 4, 0; 0, -1/2, 7, 2; 0, 0, -1, 3) arrow
bmatrix(1, 0, 0, 75; 0, 1, 0, -46; 0, 0, 1, -3)
$
所以 $(x_1, x_2, x_3) = (75, -46, -3)$。$det(A) = 2 times (-1/2) times (-1) = -1$。
$
bmatrix(2, 3, 4, 1, 0, 0; 1, 1, 9, 0, 1, 0; 1, 2, -6, 0, 0, 1) arrow
bmatrix(2, 3, 4, 1, 0, 0; 0, -1/2, 7, -1/2, 1, 0; 0, 1/2, -8, -1/2, 0, 1) arrow
bmatrix(2, 3, 4, 1, 0, 0; 0, -1/2, 7, -1/2, 1, 0; 0, 0, -1, -1, 1, 1) arrow
bmatrix(1, 0, 0, -24, 26, 23; 0, 1, 0, 15, -16, -14; 0, 0, 1, 1, -1, -1)
$
所以，$A^(-1) = bmatrix(-24, 26, 23; 15, -16, -15; 1, -1, -1)$。
]

#HWProb(name: "3")[
  用平方根法和 $text("LDL")^T$ 分解求解方程组：
  $
  cases(
    3x_1 + 2x_2 + x_3 = 5 \
    2x_1 + 2x_2 + kk kk kk = 3 \
    x_1 + kk kk kk kk kk kk + 3x_3 = 4
  )
  $
]

#solution[
  $
  A = bmatrix(3, 2, 1; 2, 2, 0; 1, 0, 3)
  $
  求矩阵 $L$ 和 $D$ 的元素：
  $
  d_1 = a_(11) = 3\
  j = 2: t_1 = a_(21) = 2, l_(21) = t_1 / d_1 = 2/3 \
  d_2 = a_(22) - t_1 l_(21) = 2 - 2 times 2/3 = 2/3 \
  $
  $
  j = 3: t_1 = a_(31) = 1, l_(31) = t_1 / d_1 = 1/3 \
  t_2 = a_(32) - t_1 l_(21) = -2/3, l_(32) = t_2 / d_2 = -1 \
  d_3 = a_(33) - t_1 l_(31) - t_2 l_(32) = 2
  $
  得到
  $
  L = bmatrix(1, kk, kk; 2/3, 1, kk; 1/3, -1, 1), D = bmatrix(3,kk , kk; kk, 2/3, kk;kk,kk ,2 )
  $
  解 $L y = b$ 得 $y = [5, -1/3,2]^T$，
  计算 $z = [5/3, -1/2, 1]^T$
  解 $L^T x = z$ 得 $x = [1, 1/2, 1]^T$。\
  所以 $x_1 = 1, x_2 = 1/2, x_3 = 1$。
]


#HWProb(name: "4")[
证明：\
+ 两个下三角矩阵的乘积仍为下三角矩阵；
+ 下三角矩阵之逆仍为下三角矩阵。
]

#Proof[
+ 对于下三角矩阵 $A$ ，$a_(i j) = 0, forall i < j, i, j = 1, 2, dots, n$， 设 $A, B$ 都是下三角矩阵，$C = A B$，那么对于 $i < j, i, j = 1, 2, dots, n$，$c_(i j) = sum_(k = 1)^n a_(i k) b_(k j) = sum_(k = 1)^(i) a_(i k) b_(k j) + sum_(k = i+1)^n a_(i k) b_(k j) = sum_(k = 1)^(i) a_(i k) times 0+ sum_(k = i+1)^n 0 times b_(k j) = 0$，所以 $C$ 还是下三角矩阵。
+ 用数学归纳法证明，对于 $n = 1$，所有 $1 times 1$ 的矩阵都是下三角矩阵，结论显然成立。若对于任意 $n leq k, k > 0$ 的矩阵结论都成立，那么对于任意一个可逆下三角 $(k+1) times (k+1)$ 矩阵 $A$，可以将其写为 $
A = bmatrix(A'_(k times k), 0; b, a_(k+1, k+1)),
A^(-1) = bmatrix(B_(k times k), c; d, e),
$所以$
A A^(-1) = bmatrix(A'_(k times k) B_(k times k), A'_(k times k) c; b B_(k times k) + a_(k+1, k+1) e, b c + a_(k+1,k+1) e) = bmatrix(I_(k times k), 0; 0, 1),
$所以，$B_(k times k) = A'_(k times k)^(-1)$，根据归纳假设，$B_(k times k)$ 是下三角矩阵。又因为 $A'_(k times k)$ 满秩且 $A'_(k times k) c = 0$，所以 $c = 0$。由此得到 $A^(-1)$ 是下三角矩阵。\
 因此，任意可逆下三角矩阵的逆矩阵都是下三角矩阵。
]


#HWProb(name: "5")[
用主元素消去法解方程组
$
cases(
  3x_1 - x_2 + 4x_3 = 7 \
  -x_1 + 2x_2 - 2x_3 = -1 \
  2x_1 - 3x_2 - 2x_3 = 0
)
$
取 4 位数字计算。
]

#solution[
  $
cases(
  3x_1 - x_2 + 4x_3 = 7 \
  -x_1 + 2x_2 - 2x_3 = -1 \
  2x_1 - 3x_2 - 2x_3 = 0
)
$ 消除后两个方程的 $x_1$ 得到
$
cases(
  3x_1 - x_2 + 4x_3 = 7 \
  - 2.333 x_2 - 4.667 x_3 = -4.667 \
  1.667 x_2 - 0.6667 x_3 = 1.333 
)
$ 消除最后一个方程的 $x_2$ 得到
$
cases(
  3x_1 - x_2 + 4x_3 = 7 \
  - 2.333 x_2 - 4.667 x_3 = -4.667 \
  - 4.000 x_3 = -2.001
)
$，所以 $x_3 = 0.5003, x_2 = 0.9996, x_1 = 1.9995$。
]
