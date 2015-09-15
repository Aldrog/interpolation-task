import strutils
import sdl, graphics, colors
import functions
import interpolation

const 
    a = -1.0
    b = 1.0
    n1 = 3
    n2 = n1 * 3

proc eqnodes(n: int): seq[float] = 
    result.newSeq(n)
    for i in 0..n-1:
        result[i] = a + i.float * (b - a) / (n.float - 1)

proc values(f: proc(x: float): float, 
            x: varargs[float]): seq[float] = 
    result.newSeq(x.len)
    for i in low(x)..high(x):
        result[i] = f(x[i])

# n1 equidistant nodes
let 
    inodes1x = eqnodes(n1)
    inodes1y = f1.values(inodes1x)

# Write table of nodes
stdout.write("|")
for p in inodes1x:
    stdout.write (p.formatFloat(precision = 2), "\t|")
stdout.write("\n|")
for p in inodes1y:
    stdout.write(p.formatFloat(precision = 4), "\t|")
stdout.write("\n\n")

let res1 = interpolate(inodes1x, inodes1y)

# n2 equidistant nodes
let 
    inodes2x = eqnodes(n2)
    inodes2y = f1.values(inodes2x)

# Write table of nodes
stdout.write("|")
for p in inodes2x:
    stdout.write (p.formatFloat(precision = 2), "\t|")
stdout.write("\n|")
for p in inodes2y:
    stdout.write(p.formatFloat(precision = 4), "\t|")
stdout.write("\n\n")

let res2 = interpolate(inodes2x, inodes2y)

#
# Graphics
#
const
    width = 600
    height = 800
var surf = newScreenSurface(width, height)
surf.fillSurface(colWhite)

const
    xoffset = 1.0
    yoffset = -1.0
    pointsForPlotting = 600

let
    checkPoints = eqnodes(pointsForPlotting)
    scale = (width / (checkPoints[checkPoints.high] - checkPoints[checkPoints.low])).float
    f1Vals = f1.values(checkPoints)
    res1Vals = res1.values(checkPoints)
    res2Vals = res2.values(checkPoints)

proc convertCoords(x, y: float): TPoint = 
    result.x = ((x + xoffset) * scale).int
    result.y = (-(y + yoffset) * scale + height).int

# Axis
surf.drawLine(((xoffset * scale).int, 0), ((xoffset * scale).int, height), colDarkGray)
surf.drawLine((0, (-yoffset * scale + height).int), (width, (-yoffset * scale + height).int), colDarkGray)

for i in 1..pointsForPlotting-1:
    surf.drawLine(convertCoords(checkPoints[i-1], f1Vals[i-1]), convertCoords(checkPoints[i], f1Vals[i]), colBlue)
    surf.drawLine(convertCoords(checkPoints[i-1], res1Vals[i-1]), convertCoords(checkPoints[i], res1Vals[i]), colRed)
    surf.drawLine(convertCoords(checkPoints[i-1], res2Vals[i-1]), convertCoords(checkPoints[i], res2Vals[i]), colGreen)

withEvents(surf, event):
    var eventp = addr(event)
    if event.kind == sdl.QUITEV:
        break
    sdl.updateRect(surf.s, 0, 0, width, height)
    
