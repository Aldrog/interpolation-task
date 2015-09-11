import math
import strutils
import NimQml
import macros
import typeinfo
import functions
import interpolation

const 
    a = -1.0
    b = 1.0
    n1 = 5
    n2 = 15
    randomPoints1 = @[-1.0, -0.5, 0.0, 0.5, 1.0]
    randomPoints2 = @[-1.0, -0.86, -0.71, -0.57, -0.43, -0.28, -0.14, 0.0, 0.14, 0.28, 0.43, 0.57, 0.71, 0.86, 1.0]

type resultContainer = ref object of QObject
    

proc values(f: proc(x: float64): float64, 
            x: varargs[float64]): seq[float64] = 
    result.newSeq(x.len)
    for i in low(x)..high(x):
        result[i] = f(x[i])

let rp1Values = f1.values(randomPoints1)
stdout.write("|")
for p in randomPoints1:
    stdout.write (formatFloat(f = p, precision = 2), "\t|")
stdout.write("\n|")
for p in rp1Values:
    stdout.write(formatFloat(f = p, precision = 4), "\t|")
stdout.write("\n")

let interpolated1 = interpolate(randomPoints1, rp1Values)

proc openWindow() = 
    var app = newQApplication()
    defer: app.delete()
    
    var rc = resultContainer()
    defer: rc.delete()
    
    var engine = newQQmlApplicationEngine()
    defer: engine.delete()
    
    #var rootContext: QQmlContext = engine.rootContext()
    
    engine.load("mainWindow.qml")
    app.exec()

when isMainModule: openWindow()
