import math
import strutils
import functions, interpolation, plotter

const 
    a = -1.0
    b = 1.0
    n1 = 3
    n2 = n1 * 3

proc eqnodes(n: int): seq[float] = 
    result.newSeq(n)
    for i in 0..n-1:
        result[i] = a + i.float * (b - a) / (n.float - 1)

proc optimalnodes(n: int): seq[float] = 
    result.newSeq(n)
    for i in 0..n-1:
        result[i] = 0.5 * ((b - a) * cos(PI * (2 * i + 1).float/(2 * n).float) + (b + a))

proc values(f: proc(x: float): float, 
            x: varargs[float]): seq[float] = 
    result.newSeq(x.len)
    for i in low(x)..high(x):
        result[i] = f(x[i])

#
# f1
#

# n1 equidistant nodes
var 
    inodesx = eqnodes(n1)
    inodesy = f1.values(inodesx)

# Write table of nodes
stdout.write("|")
for p in inodesx:
    let tab = p.formatFloat(precision = 2).len < 7
    stdout.write (p.formatFloat(precision = 2), if tab: "\t" else: "", "|")
stdout.write("\n|")
for p in inodesy:
    let tab = p.formatFloat(precision = 4).len < 7
    stdout.write (p.formatFloat(precision = 4), if tab: "\t" else: "", "|")
stdout.write("\n\n")

let f1reseqn1 = interpolate(inodesx, inodesy)

# n1 optimal nodes
inodesx = optimalnodes(n1)
inodesy = f1.values(inodesx)

# Write table of nodes
stdout.write("|")
for p in inodesx:
    let tab = p.formatFloat(precision = 2).len < 7
    stdout.write (p.formatFloat(precision = 2), if tab: "\t" else: "", "|")
stdout.write("\n|")
for p in inodesy:
    let tab = p.formatFloat(precision = 4).len < 7
    stdout.write (p.formatFloat(precision = 4), if tab: "\t" else: "", "|")
stdout.write("\n\n")

let f1resoptn1 = interpolate(inodesx, inodesy)

# Plot a graph
var set1: seq[proc(x: float): float]
set1.newSeq(3)
set1[0] = f1
set1[1] = f1reseqn1
set1[2] = f1resoptn1
openPlot(set1)

# n2 equidistant nodes
inodesx = eqnodes(n2)
inodesy = f1.values(inodesx)

# Write table of nodes
stdout.write("|")
for p in inodesx:
    let tab = p.formatFloat(precision = 2).len < 7
    stdout.write (p.formatFloat(precision = 2), if tab: "\t" else: "", "|")
stdout.write("\n|")
for p in inodesy:
    let tab = p.formatFloat(precision = 4).len < 7
    stdout.write (p.formatFloat(precision = 4), if tab: "\t" else: "", "|")
stdout.write("\n\n")

let f1reseqn2 = interpolate(inodesx, inodesy)

# n2 optimal nodes
inodesx = optimalnodes(n2)
inodesy = f1.values(inodesx)

# Write table of nodes
stdout.write("|")
for p in inodesx:
    let tab = p.formatFloat(precision = 2).len < 7
    stdout.write (p.formatFloat(precision = 2), if tab: "\t" else: "", "|")
stdout.write("\n|")
for p in inodesy:
    let tab = p.formatFloat(precision = 4).len < 7
    stdout.write (p.formatFloat(precision = 4), if tab: "\t" else: "", "|")
stdout.write("\n\n")

let f1resoptn2 = interpolate(inodesx, inodesy)

# Plot a graph
var set2: seq[proc(x: float): float]
set2.newSeq(3)
set2[0] = f1
set2[1] = f1reseqn2
set2[2] = f1resoptn2
openPlot(set2)

#
# f2
#

# n1 equidistant nodes
inodesx = eqnodes(n1)
inodesy = f2.values(inodesx)

# Write table of nodes
stdout.write("|")
for p in inodesx:
    let tab = p.formatFloat(precision = 2).len < 7
    stdout.write (p.formatFloat(precision = 2), if tab: "\t" else: "", "|")
stdout.write("\n|")
for p in inodesy:
    let tab = p.formatFloat(precision = 4).len < 7
    stdout.write (p.formatFloat(precision = 4), if tab: "\t" else: "", "|")
stdout.write("\n\n")

let f2reseqn1 = interpolate(inodesx, inodesy)

# n1 optimal nodes
inodesx = optimalnodes(n1)
inodesy = f2.values(inodesx)

# Write table of nodes
stdout.write("|")
for p in inodesx:
    let tab = p.formatFloat(precision = 2).len < 7
    stdout.write (p.formatFloat(precision = 2), if tab: "\t" else: "", "|")
stdout.write("\n|")
for p in inodesy:
    let tab = p.formatFloat(precision = 3).len < 7
    stdout.write (p.formatFloat(precision = 3), if tab: "\t" else: "", "|")
stdout.write("\n\n")

let f2resoptn1 = interpolate(inodesx, inodesy)

# Plot a graph
var set3: seq[proc(x: float): float]
set3.newSeq(3)
set3[0] = f2
set3[1] = f2reseqn1
set3[2] = f2resoptn1
openPlot(set3)

# n2 equidistant nodes
inodesx = eqnodes(n2)
inodesy = f2.values(inodesx)

# Write table of nodes
stdout.write("|")
for p in inodesx:
    let tab = p.formatFloat(precision = 2).len < 7
    stdout.write (p.formatFloat(precision = 2), if tab: "\t" else: "", "|")
stdout.write("\n|")
for p in inodesy:
    let tab = p.formatFloat(precision = 3).len < 7
    stdout.write (p.formatFloat(precision = 3), if tab: "\t" else: "", "|")
stdout.write("\n\n")

let f2reseqn2 = interpolate(inodesx, inodesy)

# n2 optimal nodes
inodesx = optimalnodes(n2)
inodesy = f2.values(inodesx)

# Write table of nodes
stdout.write("|")
for p in inodesx:
    let tab = p.formatFloat(precision = 2).len < 7
    stdout.write (p.formatFloat(precision = 2), if tab: "\t" else: "", "|")
stdout.write("\n|")
for p in inodesy:
    let tab = p.formatFloat(precision = 3).len < 7
    stdout.write (p.formatFloat(precision = 3), if tab: "\t" else: "", "|")
stdout.write("\n\n")

let f2resoptn2 = interpolate(inodesx, inodesy)

# Plot a graph
var set4: seq[proc(x: float): float]
set4.newSeq(3)
set4[0] = f2
set4[1] = f2reseqn2
set4[2] = f2resoptn2
openPlot(set4)
