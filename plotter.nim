import sdl, graphics, colors

const
    # Window size
    width = 600
    height = 800
    
    lineColors = [ colRed, colGreen, colBlue ]
var 
    # Plotting parameters
    a = -1.0
    b = 1.0
    xoffset = -a
    yoffset = -1.0
    pointsForPlotting = 600
    scale = (width / (b - a)).float

proc convertCoords(x, y: float): graphics.TPoint = 
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
    
    var surf = newScreenSurface(width, height)
    surf.fillSurface(colWhite)

    # Axis
    surf.drawLine(((xoffset * scale).int, 0), ((xoffset * scale).int, height), colDarkGray)
    surf.drawLine((0, (-yoffset * scale + height).int), (width, (-yoffset * scale + height).int), colDarkGray)
    
    for i in low(F)..high(F):
        for j in 1..pointsForPlotting-1:
            surf.drawLine(convertCoords(points[j-1], fvalues[i][j-1]), convertCoords(points[j], fvalues[i][j]), lineColors[i %% lineColors.len])
    
    sdl.updateRect(surf.s, 0, 0, width, height)
    
    withEvents(surf, event):
        var eventp = addr(event)
        if event.kind == sdl.QUITEV:
            break
        sdl.updateRect(surf.s, 0, 0, width, height)
