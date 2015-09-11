import math

proc f1*(x: float64): float64 = 
    result = (x + 3) * cos(x)

proc f2*(x: float64): float64 = 
    result = abs(x) * (x + 3) * cos(x)
