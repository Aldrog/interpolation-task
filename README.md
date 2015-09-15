# Task
Interpolate function:
```
f(x) = (x + 3) cos x
```
On [-1; +1] interval using Lagrange polynomials.

1. Build interpolation polynomial with uneven count of equidistant nodes, then do the same but with nodes chosen according to formula
`x_i = 1/2 ((b − a) cos (π(2i + 1)/2(n + 1)) + (b + a)), i = 0..n`.
2. Repeat the first task with number of nodes multiplied by 3.
3. Do the same work for function multiplied by |x| (`f(x) = |x| (x + 3) cos x`).

Result:

![alt tag](https://raw.githubusercontent.com/Aldrog/interpolation-task/master/screenshot.png)
