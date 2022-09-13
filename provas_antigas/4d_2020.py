import numpy as np

def newton(f, g, x0, tol):
    # output is an estimation of the root of f 
    # using the Newton Raphson method
    # recursive implementation
    if abs(f(x0)) < tol:
        return x0
    else:
        return newton(f, g, x0 - f(x0)/g(x0), tol)

G = 6.67*10**-11
mt=5.98*10**24
ms= 1.98*10**30
R = 1.49 * 10**11
T = 3.15576 * 10**7
w = 2*np.pi/T

f = lambda x: G*mt/(R-x*10**11)**2 + x*10**11*w**2 - G*ms/(x*10**11)**2
f_prime = lambda x: (f(x+f(x)))/f(x) -1

estimate = newton(f, f_prime, 10**5, 1e-6)
print("estimate =", estimate)