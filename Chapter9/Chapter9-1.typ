#import "../template.typ": *

#show: project.with(
	course: "Computing Method",
	title: "Computing Method - Chapter9-1",
	date: "2024.5.14",
	authors: "Zhixin Zhang, 3210106357",
	has_cover: false
)

*Problems：Chapter9-1,2,Chapter8-10*

#HWProb(name: "1")[
  用幂法计算矩阵$
  A = bmatrix(4,2,2;2,5,1;2,1,6)
  $
  的最大特征值和相应的特征向量。
]

#solution[
```python 
import numpy as np
def solve(A, x, eps, N):
    k = 1
    mu = 0
    y = np.zeros(np.shape(x))
    while (1):
        l = x[0]
        for y in x:
            if abs(y) > abs(l):
                l = y
        y = x / l
        x = A @ y
        print("k =", k, "y_k =", y, "x_(k+1) =", x)
        if abs(l - mu) < eps:
            break
        else :
            k = k + 1
            mu = l
        if k == N:
            print ("Time Limit Exceeded!")
            break
    return [l, y]

A = np.array([[4,2,2],[2,5,1],[2,1,6]])
x = np.array([1,1,1])

print(solve(A, x, 5e-5, 100))
```
求解过程如下：
```
k = 1 y_k = [1. 1. 1.] x_(k+1) = [8. 8. 9.]
k = 2 y_k = [0.88888889 0.88888889 1.        ] x_(k+1) = [7.33333333 7.22222222 8.66666667]
k = 3 y_k = [0.84615385 0.83333333 1.        ] x_(k+1) = [7.05128205 6.85897436 8.52564103]
k = 4 y_k = [0.82706767 0.80451128 1.        ] x_(k+1) = [6.91729323 6.67669173 8.45864662]
k = 5 y_k = [0.81777778 0.78933333 1.        ] x_(k+1) = [6.84977778 6.58222222 8.42488889]
k = 6 y_k = [0.81304073 0.78128297 1.        ] x_(k+1) = [6.81472885 6.53249631 8.40736442]
k = 7 y_k = [0.81056661 0.77699693 1.        ] x_(k+1) = [6.79626027 6.50611784 8.39813014]
k = 8 y_k = [0.80925875 0.77471029 1.        ] x_(k+1) = [6.78645557 6.49206895 8.39322779]
k = 9 y_k = [0.80856325 0.77348895 1.        ] x_(k+1) = [6.78123092 6.48457126 8.39061546]
k = 10 y_k = [0.80819231 0.77283619 1.        ] x_(k+1) = [6.77844163 6.48056556 8.38922081]
k = 11 y_k = [0.80799418 0.77248718 1.        ] x_(k+1) = [6.7769511  6.47842429 8.38847555]
k = 12 y_k = [0.80788828 0.77230055 1.        ] x_(k+1) = [6.77615423 6.47727932 8.38807712]
k = 13 y_k = [0.80783166 0.77220074 1.        ] x_(k+1) = [6.7757281  6.47666699 8.38786405]
k = 14 y_k = [0.80780137 0.77214735 1.        ] x_(k+1) = [6.77550019 6.47633949 8.3877501 ]
k = 15 y_k = [0.80778518 0.77211879 1.        ] x_(k+1) = [6.77537829 6.47616433 8.38768915]
k = 16 y_k = [0.80777651 0.77210352 1.        ] x_(k+1) = [6.7753131  6.47607063 8.38765655]
k = 17 y_k = [0.80777188 0.77209535 1.        ] x_(k+1) = [6.77527822 6.47602052 8.38763911]
[8.38765654798032, array([0.80777188, 0.77209535, 1.        ])]
```
所以 $lambda = 8.3876565, vm = [0.80777188, 0.77209535, 1.        ]^T$。
]

#HWProb(name: "2")[
  求下面三对角矩阵$
  A = bmatrix(0,5,0,0,0,0;1,0,4,0,0,0;0,1,0,3,0,0;0,0,1,0,2,0;0,0,0,1,0,1;0,0,0,0,1,0)
  $
  的特征值。
]

#solution[
```python
A = np.array([[1,5,0,0,0,0],[1,1,4,0,0,0],[0,1,1,3,0,0],[0,0,1,1,2,0],[0,0,0,1,1,1],[0,0,0,0,1,1]])

def QR(A):
    for i in range(1000):
        Q, R = np.linalg.qr(A)
        A = R @ Q
    eigenvalues = np.diag(A)
    return eigenvalues

print(QR(A) - np.array([1,1,1,1,1,1]))
```
使用 QR 法计算 $A + I$ 的特征值，然后分别减去 1.
最后计算结果为： [3.32425743  1.88917588 -3.32425743  0.61670659 -1.88917588 -0.61670659]
]


#HWProb(name: "10")[
 设 $lambda$ 是 $n$ 阶矩阵 $A$ 的一个特征值，试证存在 $k$，$
 abs(lambda - a_(k k)) leq sum_(j eq.not k) abs(a_(k j)) equiv R_k
 $
 从而所有特征值在下面 Gerschgoring 圆盘的并集中$
 G_k = {lambda: abs(lambda - a_(k k)) leq R_k quad k = 1, 2, dots.c, n} quad k = 1, 2, dots.c, n
 $
]

#Proof[
  对于 $A$ 的任意特征值 $lambda$，设 $xm$ 为其对应的特征向量。那么 $A xm = lambda xm arrow.double sum_(j=1)^n a_(i j) x_j = lambda x_i(forall i = 1,2,dots,n)$。
  令 $k = arg max_k abs(x_k)$，那么有
  $
  sum_(j=1)^k a_(k j) x_j = lambda x_k
  arrow.double x_k (lambda - a_(k k)) = sum_(j eq.not k) a_(k j) x_j \
  arrow.double abs(x_k)abs(lambda-a_(k k)) = abs(sum_(j eq.not k) a_(k j)x_j) leq sum_(j eq.not k) abs(a_(k j)) abs(x_j) leq abs(x_k) sum_(j eq.not k) abs(a_(k j)) \
  arrow.double abs(lambda - a_(k k)) leq sum_(j eq.not k) abs(a_(k j)) = R_k
  $
]