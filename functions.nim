import math

proc f1*(x: float64): float64 {.procvar.} = 
    result = (x + 3) * cos(x)

proc f2*(x: float64): float64 {.procvar.} = 
    result = abs(x) * (x + 3) * cos(x)
