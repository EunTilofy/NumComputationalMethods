#import "../template.typ": *

#show: project.with(
	course: "Computing Method",
	title: "Computing Method - Chapter10-1",
	date: "2024.5.21",
	authors: "Zhixin Zhang, 3210106357",
	has_cover: false
)

*Problems：Chapter9-3,Chapter10-3*

#HWProb(name: "9-3")[
  试证明 Jacobi 方法计算公式 (9.33) 可写成，
  $
  &d = cot 2 phi, t = d + text("sign")(d) sqrt(1 + d^2) \
  &c = 1 \/ sqrt(1 + t^2), s = c t,\
  &a_(i i)^((1)) = a_(i i) + t a_(i j), a_(j j)^((1)) = a_(j j) - t a_(i j),\
  &a_(i j)^((1)) = a_(j i)^((1)) = 0, \
  &a_(i l)^((1)) = a_(l i)^((1)) = c a_(i l) + s a_(j l), \
  &a_(j l)^((1)) = a_(l j)^((1)) = -s a_(i l) + c a_(j l), l eq.not i, j\
  &a_(m l)^((1)) = a_(l m)^((1)) = a_(m l), m,l eq.not i, j
  $
]

#Proof[
    对于 (9.33)，若取 $
    cot 2 phi = (a_(i i) - a_(j j)) / (2a_(i j)), abs(phi) leq pi / 4,
    $
    则$a_(i j)^((1)) = a_(j i)^((1)) = 1/2 (a_(j j) - a_(i i)) sin phi + (a_(i i) - a_(j j)) / (2 cot 2 phi) (cos^2 phi - sin^2 phi) = 1/2 (a_(j j) - a_(i i)) sin phi + 1/2 (a_(i i) - a_(j j)) (cos 2 phi) / (cot 2 phi) = 0,
    $
    根据 $d = cot 2 phi$，则 $1/d = (2 tan phi) / (1 - tan^2 phi) arrow.double tan phi = d + text("sign")(d) sqrt(1 + d^2)$，所以 $t = tan phi$。
    $
    a_(i i)^((1)) &= a_(i i) cos^2 phi + a_(j j) sin^2 phi + 2 a_(i j) cos phi sin phi \
    &= a_(i i) - (a_(i i) - a_(j j)) sin^2 phi + a_(i j) sin 2 phi \
    &= a_(i i) - 2 cot 2 phi a_(i j) sin^2 phi + a_(i j) sin 2 phi \
    &= a_(i i) + a_(i j) (sin 2 phi - 2 cot 2 phi (1 - cos 2 phi)/2 ) \
    &= a_(i i) + a_(i j) (sin^2 2 phi - cos 2 phi + cos^2 2 phi ) / (sin 2 phi) \
    &= a_(i i) + a_(i j) (2sin^2 phi)/(2 sin phi cos phi) 
    = a_(i i) + t a_(i j)\
    a_(j j)^((1)) &= a_(i i) sin^2 phi + a_(j j) cos^2 phi - 2 a_(i j) cos phi sin phi \
    &= a_(j j) + (a_(i i) - a_(j j)) sin^2 phi + a_(i j) sin 2 phi 
    = a_(j j) - t a_(i j)
    $
    $c = 1\/ sqrt(1 + t^2) = cos phi, s = c t = sin phi$，所以，$
    &a_(i l)^((1)) = a_(l i)^((1)) = c a_(i l) + s a_(j l), \
   &a_(j l)^((1)) = a_(l j)^((1)) = -s a_(i l) + c a_(j l), l eq.not i, j\
    $
]

#HWProb(name: "10-3")[
    方程 $x^3 - x^2 - 1 = 0$ 在 $x_0 = 1.5$ 附近有根，把方程写成三种不同等价形式，
    #set enum(numbering : "(1)")
    + $x = 1 + 1/x^2$，对应迭代格式： $x_(n+1) = 1 + 1/x_n^2$；
    + $x^3 = 1 + x^2$，对应迭代格式： $x_(n+1) = (1 + x_n^2)^(1/3)$；
    + $x^2 = 1/(x - 1)$，对应迭代格式： $x_(n+1) = sqrt(1/(x_n - 1))$。
    判断迭代格式在 $x_0 = 1.5$ 的收敛性，并估计收敛速度，选一种收敛格式计算出 1.5 附近的根到 4 位有效数字，从 $x_0 = 1.5$ 出发，计算时保留 5 位有效数字。
]

#solution[
#set enum(numbering: "(1)")
+ 收敛，$phi_1(x) = 1 + 1/x^2, phi_1'(x) = - 2/x^3$，因为 $1.3^3 = 2.197 >2$，所以 $x in [1.3, 1.7]$ 上，$abs(phi_1'(x)) leq (2/1.3^3) < 1$，所以该区间上为收缩映射，因此迭代法收敛。
+ 收敛，$phi_2(x) = (1+x^2)^(1/3), phi_2'(x) = 2/3 x (1+x^2)^(-2/3)$，如下图所示，#figure(image("2.png", width: 50%))，因此在 $[1,2]$ 上 $abs(phi_2'(x)) < 0.46 < 1$，为压缩映射，因此迭代法收敛。
+ 不收敛，$phi_3(x) = sqrt(1 / (x - 1)),phi_3'(x) = -1/2 (x-1)^(-3/2)$，如下图所示，#figure(
      image("3.png", width: 50%),
    )在 $[1.4, 1.6]$ 区间上，$|phi(x)'| > 1$，因此不收敛。
因为 $abs(phi_2'(1.5)) = 0.46 < abs(phi_1'(1.5)) = 0.59$，所以迭代格式 (2) 的收敛速度更快。使用第二种迭代格式，计算结果如下：
$
x_0 = 1.5, x_1 = 1.4812, x_2 = 1.4727, x_3 = 1.4688, x_4 = 1.4670, x_5 = 1.4662\
x_6 = 1.4659, x_7 = 1.4657, x_8 = 1.4656, x_9 = 1.4656
$数值解为 $x^* = 1.466$（保留四位有效数字）。
]