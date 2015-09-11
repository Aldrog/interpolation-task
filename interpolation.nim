discard """
proc sum(F: varargs[proc(x: float64): float64]): proc(x: float64): float64 = 
    result = proc(x: float64): float64 = return 0
    for f in F:
        var tmp = result
        result = proc(x: float64): float64 = return tmp(x) + f(x)
"""

proc lm(i: int, xk: varargs[float64], x: float64): float64 = 
    result = 1
    for j in low(xk)..high(xk):
        result = result * (x - xk[j]) / (xk[i] - xk[j])

proc interpolate*(px, py: seq[float64]): proc(x: float64): float64 = 
    result = proc(px: float64): float64 = return 0
    for i in low(px)..high(px):
        var restmp = result
        result = proc(x: float64): float64 = return restmp(x) + py[i] * lm(i, px, x)
