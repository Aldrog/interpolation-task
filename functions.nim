import math

proc f1*(x: float): float {.procvar.} = (x + 3) * cos(x)

proc f2*(x: float): float {.procvar.} = abs(x) * (x + 3) * cos(x)
