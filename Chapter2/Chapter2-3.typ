#import "../template.typ": *

#show: project.with(
	course: "Computing Method",
	title: "Computing Method - Chapter2&5",
	date: "2024.4.23",
	authors: "Zhixin Zhang, 3210106357",
	has_cover: false
)

#HWProb(name: "16")[
  在(2.33)式中，令 $n=2$，求 $f'(x_0), f'(x_1), f'(x_2)$。
]

#solution[
令 $x = x_0 + t h, x_k = x_0 + k h (k = 0, 1, 2)$，
$
phi_2(x) = f_0 + t Delta f_0 + t(t-1)/2 Delta^2 f_0 = f_0 + (x-x_0)/h (f_1 - f_0)  + ((x-x_0)(x-x_0-h))/(2h^2) (f_2 - 2 f_1 + f_0)
$
所以
$
phi_2'(x) = (f_1 - f_0)/h  + (f_2 - 2f_1 + f_0)/(2 h^2) (2x - 2x_0 - h)
$

代入 $x_0, x_1, x_2$ 得
$
cases(
  f'(x_0) =  (f_1 - f_0)/h - (f_2 - 2 f_1 + f_0)/(2h) = (4f_1 -  f_2 -3f_0)/(2h)\
  f'(x_1) = (f_1 - f_0)/h  +  (f_2 - 2 f_1 + f_0)/(2h) = (f_2 - f_0) / (2h) \
  f'(x_2) = (f_1 - f_0)/h  + (3(f_2 - 2 f_1 + f_0))/(2h) = (-4f_1 + f_0 + 3f_2)/(2h)
)
$

]

#HWProb(name: "补充题")[
  求 $x_1,x_2,A_1,A_2$，满足
  $
  integral_0^1 e^x f(x) dx = A_1 f(x) + A_2 f(x_2)
  $
  具有最高代数精度（精确到 0.0001）
]

#solution[
$
cases(
  integral_0^1 e^x dx = e - 1 = A_1 + A_2 \
  integral_0^1 x e^x dx = 1 = A_1 x_1 + A_2 x_2 \
  integral_0^1 x^2 e^x dx = e- 2 = A_1 x_1^2 + A_2 x_2^2 \
  integral_0^1 x^3 e^x dx = 6 - 2e = A_1 x_1^3 + A_2 x_2^3
)
$

求解的python代码如下：
```python 
from scipy.optimize import fsolve
import numpy as np

def equations(vars):
    A1, A2, x1, x2 = vars
    
    e_minus_1 = np.exp(1) - 1
    integral_x_ex = 1
    integral_x2_ex = np.exp(1) - 2
    integral_x3_ex = 6 - 2 * np.exp(1)
    
    eq1 = A1 + A2 - e_minus_1
    eq2 = A1 * x1 + A2 * x2 - integral_x_ex
    eq3 = A1 * x1**2 + A2 * x2**2 - integral_x2_ex
    eq4 = A1 * x1**3 + A2 * x2**3 - integral_x3_ex
    
    return np.array([eq1, eq2, eq3, eq4])

initial_guesses = [0.5, 0.5, 0.25, 0.75]

result = fsolve(equations, initial_guesses)
print(f"Results: A1 = {result[0]}, A2 = {result[1]}, x1 = {result[2]}, x2 = {result[3]}")

# Results: A1 = 0.7131482910221459, A2 = 1.005133537436899, x1 = 0.24760397941963827, x2 = 0.8192161683583419
```

所以，
$
cases(
A_1 = 0.7131 \
A_2 = 1.0051 \
x_1 = 0.2476 \
x_2 = 0.8192
)
$

]