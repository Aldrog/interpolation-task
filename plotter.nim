import sdl, graphics, colors

const
    # Window size
    width = 600
    height = 800
var 
    # Plotting parameters
    a = -1.0
    b = 1.0
    xoffset = -a
    yoffset = -1.0
    pointsForPlotting = 600
    scale = (width / (b - a)).float

proc convertCoords(x, y: float): TPoint = 
    result.x = ((x + xoffset) * scale).int
    result.y = (height - (y + yoffset) * scale).int

proc plot*(F: varargs[proc(x: float): float]) = 
    var points: seq[float]
    points.newSeq(pointsForPlotting)
    for i in 0..pointsForPlotting-1:
        points[i] = a + i.float * (b - a) / (pointsForPlotting.float - 1)
    var fvalues: seq[seq[float]]
    fvalues.newSeq(F.len)
    for i in low(F)..high(F):
        fvalues[i].newSeq(pointsForPlotting)
        for j in 0..pointsForPlotting-1:
            fvalues[i][j] = F[i](points[j])
            
    yoffset = -min(fvalues[0]) + 0.5
    echo yoffset
    
    var surf = newScreenSurface(width, height)
    surf.fillSurface(colWhite)

    # Axis
    surf.drawLine(((xoffset * scale).int, 0), ((xoffset * scale).int, height), colDarkGray)
    surf.drawLine((0, (-yoffset * scale + height).int), (width, (-yoffset * scale + height).int), colDarkGray)
    
    for i in 1..pointsForPlotting-1:
        surf.drawLine(convertCoords(points[i-1], fvalues[0][i-1]), convertCoords(points[i], fvalues[0][i]), colRed)
        surf.drawLine(convertCoords(points[i-1], fvalues[1][i-1]), convertCoords(points[i], fvalues[1][i]), colGreen)
        surf.drawLine(convertCoords(points[i-1], fvalues[2][i-1]), convertCoords(points[i], fvalues[2][i]), colBlue)
    
    withEvents(surf, event):
        var eventp = addr(event)
        if event.kind == sdl.QUITEV:
            break
        sdl.updateRect(surf.s, 0, 0, width, height)
