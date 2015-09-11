import math
import functions
import interpolation

const 
    a = -1.0
    b = 1.0
    randomPoints1 = [-1.0, -0.5, 0.0, 0.5, 1.0]
    randomPoints2 = [-1.0, -0.86, -0.71, -0.57, -0.43, -0.28, -0.14, 0.0, 0.14, 0.28, 0.43, 0.57, 0.71, 0.86, 1.0]

proc values(f: proc(x: float64): float64, 
                        x: varargs[float64]): seq[float64] = discard

discard interpolate(randomPoints1, f1.values(randomPoints1))
