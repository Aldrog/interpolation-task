proc lm(i: int, xk: seq[float64], x: float64): float64 = 
    result = 1
    for j in low(xk)..high(xk):
        if(i != j):
            result = result * (x - xk[j]) / (xk[i] - xk[j])

proc interpolate*(px, py: seq[float64]): (proc(x: float64): float64) = 
    proc res(x: float64): float64 = 
        for i in low(px)..high(px):
            result = result + py[i] * lm(i, px, x)
    return res
