#import "../template.typ": *

#show: project.with(
	course: "Computing Method",
	title: "Computing Method - Chapter6-2",
	date: "2024.5.2",
	authors: "Zhixin Zhang, 3210106357",
	has_cover: false
)

*Problems：9, 10, 11, 13, 14*

#HWProb(name: "9")[
  画出 $bb("R")^2$ 中满足下列不等式的集合：
  #set enum(numbering: "(1)")
  + $norm(x)_1 leq 1$.
  + $norm(x)_2 leq 1$.
  + $norm(x)_(infty) leq 1$.
]

#solution[
#figure(
      image("1.png", width: 90%),
    )
]

#HWProb(name: "10")[
  求证：$norm(I) geq 1, norm(A^(-1)) geq 1/(norm(A)).$
]

#Proof[
  因为 $I = I^2$，所以有 $0 < norm(I) = norm(I^2) leq norm(I) dot.c norm(I)$，所以 $norm(I) geq 1$。

  因为 $I = A A^(-1)$，所以 $1 leq norm(I) = norm(A A^(-1)) leq norm(A) dot.c norm(A^(-1)) arrow.double norm(A^(-1)) geq 1/(norm(A))$。
]

#HWProb(name: "11")[
  试证明：$norm(A)_2^2 leq norm(A)_1 dot.c norm(A)_(infty)$。
]

#Proof[
  $
  norm(A)_2^2 &leq rho (A^T A) 
  leq norm(A^T A)_1 
  leq norm(A^T)_1 dot.c norm(A)_1 
  = norm(A)_(infty) dot.c norm(A)_1.
  $
]

#HWProb(name: "13")[
  设 $A$ 是 $n$ 阶实对称正定矩阵，试证：
  $
  norm(bold(x)) = (bold(x)^T A x)^(1 \/ 2), forall bold(x) in bb(R)^n.
  $
  是一种向量范数，且与该矩阵范数相容。
]

#Proof[
1. 正定性：对于 $x in bb(R)^n$，因为 $A$ 正定，所以 $exists$ 正交矩阵 $P$，满足 $A = P^T D P$，$D = diag(lambda_1, lambda_2, dots, lambda_n), lambda_i > 0$，所以 $norm(x) = (x^T P^T D P x)^(1 \/ 2) = ((P x)^T D (P x))^(1\/ 2)$，令 $y = P x$，则 $norm(x) = (y^T D y)^(1 \/ 2) = (sum_(i = 1)^n lambda_i y_i^2)^(1\/ 2)$，所以 $norm(x) geq 0$，且 $norm(x) = 0$ 当切仅当 $y = 0 = P x$，即 $x = 0$。
2. 奇次性：对于 $x in bb(R)^n, alpha in bb(R)$，$norm(alpha x) = (alpha x^T A alpha x)^(1 \/ 2) = alpha (x^T A x)^(1 \/ 2) = alpha norm(x)$。
3. 三角不等式：同 1，对于 $x_1, x_2 in bb(R)^n$，取 $y_1 = P x_1, y_2 = P x_2$，则有 $norm(x_1 + x_2) = ((y_1 + y_2)^T D (y_1 + y_2))^(1 \/ 2) = (sum_(i = 1)^n (y_(1 i)+  y_(2 i))^2)^(1\/ 2) = (sum_(i = 1)^n (sqrt(lambda_i) y_(1 i) + sqrt(lambda_i) y_(2 i))^2)^(1 \/ 2) leq (sum_(i = 1)^n (sqrt(lambda_i) y_(1 i))^2)^(1\/ 2) +  (sum_(i = 1)^n (sqrt(lambda_i) y_(2 i))^2)^(1\/ 2) = norm(x_1) + norm(x_2)$。
则 $norm(bold(x)) = (bold(x)^T A x)^(1 \/ 2), forall bold(x) in bb(R)^n$ 是一种向量范数。
对于 $B in bb(R)^(n times n)$，$norm(B) = max_(v^T A v = 1) (v^T B^T A B v)^(1\/ 2)$，所以 $norm(B x) = (x^T B^T A B x)^(1\/ 2) = norm(x) ((x/norm(x))^T B^T A B (x / norm(x)))^(1\/ 2) leq norm(x) dot.c norm(B)$（因为 $norm(x/norm(x)) = 1$）。
]

#HWProb(name: "14")[
  对矩阵$
  A = bmatrix(-2, 1, 0, 0; 1, -2, 1, 0; 0, 1, -2, 1; 0, 0, 1, -2)
  $求 $norm(A)_(infty)$, $norm(A)_2$, $norm(A)_1$, $norm(A)_(bb(F))$ 和 $text("Cond")(A)_2$。
]

#solution[
  $
  &norm(A)_(infty) = max_(i = 1)^4 sum_(j=1)^4 abs(a_(j i)) = 4. \
  &norm(A)_1 = max(i = 1)^4 sum_(j=1)^4 abs(a_(i j)) = 4. \
  &norm(A)_2 = lambda_(max)(A^T A) = lambda_(max)(bmatrix(4, 1, 0, 0; 1, 4, 1, 0; 0, 1, 4, 1; 0, 0, 1, 4)) = (5 + sqrt(5)) / 2. \
  &norm(A)_(bb(F)) = sqrt(sum_(i = 1)^4 sum_(j= 1)^4 a_(i j)^2) = sqrt(22). \
  &text("Cond")(A)_2 = (lambda_(max)(A^T A)) / (lambda_(min) (A^T A)) = 5 + 2sqrt(5)。
  $
]