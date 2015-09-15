import strutils
import sdl, graphics, colors
import functions
import interpolation

const 
    a = -1.0
    b = 1.0
    n1 = 5
    n2 = 15
    randomPoints1 = @[-1.0, -0.5, 0.0, 0.5, 1.0]
    randomPoints2 = @[-1.0, -0.86, -0.71, -0.57, -0.43, -0.28, -0.14, 0.0, 0.14, 0.28, 0.43, 0.57, 0.71, 0.86, 1.0]

proc values(f: proc(x: float): float, 
            x: varargs[float]): seq[float] = 
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
stdout.write("\n\n")

let res1 = interpolate(randomPoints1, rp1Values)

var checkPoints: seq[float]
checkPoints = @[]
const cpCount = 100
var tp = a
for i in 0..cpCount:
    checkPoints.add(tp)
    tp = tp + (b - a) / cpCount.toFloat
let f1Vals = f1.values(checkPoints)
let res1Vals = res1.values(checkPoints)

# Graphics

const
    width = 600
    height = 800
var surf = newScreenSurface(width, height)
surf.fillSurface(colWhite)

const
    xoffset = 1.0
    yoffset = 1.0
let
    scale = width / (checkPoints[checkPoints.high] - checkPoints[checkPoints.low])

# Axis
surf.drawLine(((xoffset * scale).int, 0), ((xoffset * scale).int, height), colDarkGray)
surf.drawLine((0, (yoffset * scale + height).int), (width, (yoffset * scale + height).int), colDarkGray)

for i in 1..cpCount:
    surf.drawLine((((checkPoints[i-1] + xoffset) * scale).int, ((yoffset - f1Vals[i-1]) * scale + height).int), (((checkPoints[i] + xoffset) * scale).int, ((yoffset - f1Vals[i]) * scale + height).int), colBlue)
    surf.drawLine((((checkPoints[i-1] + xoffset) * scale).int, ((yoffset - res1Vals[i-1]) * scale + height).int), (((checkPoints[i] + xoffset) * scale).int, ((yoffset - res1Vals[i]) * scale + height).int), colRed)

withEvents(surf, event):
    var eventp = addr(event)
    if event.kind == sdl.QUITEV:
        break
    sdl.updateRect(surf.s, 0, 0, width, height)
    
