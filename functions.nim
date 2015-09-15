import math

proc f1*(x: float): float {.procvar.} = 
    result = (x + 3) * cos(x)

proc f2*(x: float): float {.procvar.} = 
    result = abs(x) * (x + 3) * cos(x)
