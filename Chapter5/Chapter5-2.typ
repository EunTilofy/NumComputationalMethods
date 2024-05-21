#import "../template.typ": *

#show: project.with(
	course: "Computing Method",
	title: "Computing Method - Chapter5",
	date: "2024.4.14",
	authors: "Zhixin Zhang, 3210106357",
	has_cover: false
)

*Problems：8,10,15*

#HWProb(name: "8")[
 试用两点三次 Hermite 插值函数作(5.1)式的求积公式。
 $
 integral_a^b f(x) dx
 $
]

#solution[
  设 $f(a) = y_a, f(b) = y_b, f'(a) = y'_a, f'(b) = y'_b$。
  差商表如下：
  #tablex(
  columns: 5,
  auto-hlines: false,
  auto-vlines: false,
  (), vlinex(), (), (), (),
  $a$, $y_a$, [], [], [], 
  $a$, $y_a$, $y'_a$, [], [],
  $b$, $y_b$, $(y_b-y_a)/(b-a)$, $(y'_a-(y_b-y_a)/(b-a))/(a-b)$, [],
  $b$, $y_b$, $y'_b$, $(y'_b-(y_b-y_a)/(b-a))/(b-a)$, $(y'_b+y'_a-2(y_b-y_a)/(b-a))/(b-a)^2$,
)

所以插值函数为：
$
p(f;x)=(y'_b+y'_a-2(y_b-y_a)/(b-a))/(b-a)^2 (x-b)(x-a)^2 + (y'_a-(y_b-y_a)/(b-a))/(a-b) (x-a)^2 + y'_a (x-a) + y_a
$
$
integral_a^b p(f;x) dx &= y_a (b-a)+1/2 (b-a)^2 y'_a - 1/3 (y'_a-(y_b-y_a)/(b-a)) (b-a)^2 - 1/12 (y'_b+y'_a-2(y_b-y_a)/(b-a)) (b-a)^2\
&= (b-a)y_a + [(1/2 (y_b-y_a)/(b-a))-1/12 (y'_b - y'_a)](b-a)^2\
&=1/2(y_b+y_a) (b-a) - 1/12 (y'_b - y'_a) (b-a)^2
$
]


#HWProb(name: "10")[
  用 $n=2,4$ 的 Gauss 公式计算下列积分：
  #set enum(numbering: "(1)")
  + $integral_1^9 sqrt(x) dx$.
  + $2/sqrt(pi) integral_0^1 e^(-x^2) dx$.
  + $integral_0^1 arctan(x)/x^(3/2) dx$.
]

#solution[
  使用 Gauss-Legendre 求积公式：\
  #set enum(numbering: "(1)")
  $n=2$: $x_k = pm 0.5773503, A_k = 1, k = 1, 2$
  + $
  I = integral_(-1)^1 sqrt(4t+5) d(4t+5) = integral_(-1)^1 4sqrt(4t+5) dt = 
  4sqrt(4t+5)|_(x_1) + 4sqrt(4t+5)|_(x_2) = 17.375579645963338
  $
  + $
  I = 2 / sqrt(pi) integral_(-1)^1 1/2 e^(-1/4(t+1)^2) dt = 1 / sqrt(pi) sum_(i=1)^2 e^(-1/4 (x_i+1)^2) = 0.8424418886754169
  $
  + $
  I = integral_(-1)^1 1/2 arctan(1/2(t+1))/(1/2(t+1))^(3/2) dx = 1/2 sum_(i=1)^2 arctan(1/2(x_i+1))/(1/2(x_i+1))^(3/2) = 1.548617790677832
  $

  $n=4$: $x_(12) = pm 0.8611363, x_(34)=0.3399810, A_(12) = 0.3478548, A_(34)=0.6521452$
  + $
  I = integral_(-1)^1 4sqrt(4t+5) dt = sum_(i=1)^4 4sqrt(4 x_i + 5) dot.c A_i = 17.3342011001631
  $
  + $
    I = 2 / sqrt(pi) integral_(-1)^1 1/2 e^(-1/4(t+1)^2) dt = 1 / sqrt(pi) sum_(i=1)^4 A_i e^(-1/4 (x_i+1)^2) = 0.8427011772004525
  $
  + $
  I = integral_(-1)^1 1/2 arctan(1/2(t+1))/(1/2(t+1))^(3/2) dx = 1/2 sum_(i=1)^4 arctan(1/2(x_i+1))/(1/2(x_i+1))^(3/2) = 1.7034547032433185
  $
]

#HWProb(name: "15")[
  令 $x_i = x_0 + i h, y_j = y_0 + j k$($h$ 和 $k$ 分别表示 $x$ 方向与 $y$ 方向的步长)，又令 $f_(i j)$ 表示 $f(x, y)$ 在 $(x_i, y_j)$ 的值。应用抛物线公式推导关于在矩形 $x_0 leq x leq x_2, y_0 leq y leq y_2$ 上的二重积分
  $
  integral_(x_0)^(x_2) integral_(y_0)^(y_2) f(x, y) dx dy,
  $
  的求积公式
  $
  (h k)/9 (f_(0 0) + f_(0 2) + f_(2 0) + f_(2 2) + 4(f_(0 1) + f_(1 0) + f_(1 2) + f_(2 1)) + 16 f_(1 1))
  $
  且余项是
  $
  E = - (h k)/45 (h^4 (partial^4 f)/(partial x^4)(xi_1, eta_1) + k^4 (partial^4 f)/(partial y^4)(xi_2, eta_2))
  $
  其中，$xi_1,xi_2$ 是介于 $x_0,x_2$ 之间的值，$eta_1,eta_2$ 是介于 $y_0, y_2$ 之间的值。

  把结果推广，计算积分
  $
  integral_(x_0)^(x_m) integral_(y_0)^(y_n) f(x, y) dx dy
  $
  其中，$m,n$ 是偶数。
]

#Proof[
  令 $g(x) = integral_(y_0)^(y_2) f(x, y) dy$，应用抛物线公式得
  $
    g(x) approx k/3 (f(x, y_0) + 4 f(x, y_1) + f(x, y_2)),
  $
  所以
  $
  I &= integral_(x_0)^(x_2) g(x) dx approx h/3 (g(x_0) + 4 g(x_1) + g(x_2)) \ &approx h/3 [k/3(f_(00) + 4f_(01) + f_(02)) + 4k/3(f_(10) + 4f_(11) + f_(12)) + k/3(f_(20) + 4f_(21) + f_(22))] \
  &=   (h k)/9 (f_(0 0) + f_(0 2) + f_(2 0) + f_(2 2) + 4(f_(0 1) + f_(1 0) + f_(1 2) + f_(2 1)) + 16 f_(1 1))
  $
  计算二重积分的余项，
  设 $m,M$ 是 $(partial^4 f)/(partial y^4)$ 在 $[x_0, x_2] times [y_0, y_2]$ 中的最小值和最大值，
  所以有：
  $
  - k^5/90 M leq k/3 (f_(00) + 4 f_(01) + f_(02)) - g(x_0) leq - k^5/90 m\
  - k^5/90 M leq k/3 (f_(10) + 4 f_(11) + f_(12)) - g(x_1) leq - k^5/90 m \
  - k^5/90 M leq k/3 (f_(20) + 4 f_(21) + f_(22)) - g(x_2) leq - k^5/90 m 
  $
  所以，
  $
  - (h k^5)/45 M leq (h k)/9 (f_(0 0) + f_(0 2) + f_(2 0) + f_(2 2) + 4(f_(0 1) + f_(1 0) + f_(1 2) + f_(2 1)) + 16 f_(1 1)) - h/3 (g(x_0) + 4 g(x_1) + g(x_2)) leq - (h k^5)/45 m
  $
  由介值定理得，存在 $x_0 leq xi_2 leq x_1, y_0 leq eta_2 leq y_2$，
  $
  (h k)/9 (f_(0 0) + f_(0 2) + f_(2 0) + f_(2 2) + 4(f_(0 1) + f_(1 0) + f_(1 2) + f_(2 1)) + 16 f_(1 1)) - h/3 (g(x_0) + 4 g(x_1) + g(x_2))
  = - (h k^5)/45 (partial^4 f)/(partial y^4) (xi_2, eta_2)
  $
  根据一元抛物线公式的余项公式可以得到：
  $
  h/3 (g(x_0) + 4 g(x_1) + g(x_2)) - I = - h^5/90 g^((4)) (xi_1), quad (x_0 leq xi_1 leq x_1)
  $
  其中，$g^((4)) (xi_1) = integral_(y_0)^(y_2) (partial^4 f)/(partial y^4) (xi_1, y) dy$，根据积分中值定理，$g^((4)) (xi_1) = 2k  (partial^4 f)/(partial y^4) (xi_1, eta_1), quad (y_0 leq eta_1 leq y_1)$。
  所以 
  $
  h/3 (g(x_0) + 4 g(x_1) + g(x_2)) - I = - (h^5 k)/45 (partial^4 f)/(partial x^4) (xi_1, eta_1)
  $
  相加得，
  $
  E &= (h k)/9 (f_(0 0) + f_(0 2) + f_(2 0) + f_(2 2) + 4(f_(0 1) + f_(1 0) + f_(1 2) + f_(2 1)) + 16 f_(1 1)) - I \
  &= - (h k^5)/45 (partial^4 f)/(partial y^4) (xi_2, eta_2) - (h^5 k)/45 (partial^4 f)/(partial x^4) (xi_1, eta_1) =  (h k)/45 (h^4 (partial^4 f)/(partial x^4)(xi_1, eta_1) + k^4 (partial^4 f)/(partial y^4)(xi_2, eta_2))
  $
    其中，$xi_1,xi_2$ 是介于 $x_0,x_2$ 之间的值，$eta_1,eta_2$ 是介于 $y_0, y_2$ 之间的值。

  根据复化梯形公式，
  $
  & integral_(x_0)^(x_m) integral_(y_0)^(y_n) f(x, y) dx dy 
  approx h/3 (g(x_0) + g(x_m) + 4 sum_(k=1)^(m/2) g(x_(2k-1)) + 2 sum_(k=1)^(m/2 -1) g(x_(2k))) \
  approx & (h k)/9 (f_(00) + f_(0 n) + f_(m 0) + f_(m n) + 
    4 (sum_(k=1)^(n/2) (f_(0,2k-1) + f_(m,2k-1)) + sum_(k=1)^(m/2) (f_(2k-1,0) + f_(2k-1,n)))\
    & 2 (sum_(k=1)^(n/2 - 1) (f_(0,2k) + f_(m,2k)) + sum_(k=1)^(m/2 - 1) (f_(2k,0) + f_(2k,n))) + 16 sum_(k=1)^(m/2) sum_(j=1)^(n/2) f_(2k-1,2j-1) + 4 sum_(k=1)^(m/2-1) sum_(j=1)^(n/2-1) f_(2k,2j) \
  & 8 (sum_(k=1)^(m/2) sum_(j=1)^(n/2 -1) f_(2k-1, 2j) + sum_(k=1)^(m/2-1) sum_(j=1)^(n/2) f_(2k, 2j-1))
  )
  $
]