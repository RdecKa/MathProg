'''
Group Members
=============
'''

userids = ['karin17', 'andreas17'] # fill in this array with strings of usernames
def m5p1(G):
    '''Return the size of the largest clique
    '''
    p = MixedIntegerLinearProgram()
    v = p.new_variable(binary = True)

    p.set_objective(sum(v[i] for i in G.keys()))

    n = len(G)
    for i, j in [(k, l) for k in xrange(n) for l in xrange(k + 1, n)]: # edge i <-> j
        if i in G[j]: # if edge exists
            continue
        # edge does not exists, at most one of vertices is in the clique
        p.add_constraint(v[i] + v[j] <= 1)

    p.solve()

    return Integer(sum([p.get_values(v[i]) for i in xrange(n)]))

def m5p2(G):
    '''Return the size of the largest independent set
    '''
    p = MixedIntegerLinearProgram()
    v = p.new_variable(binary = True)

    p.set_objective(sum(v[i] for i in G.keys()))

    n = len(G)
    for i, j in [(k, l) for k in xrange(n) for l in xrange(k + 1, n)]:
        if i in G[j]:
            # if two vertices are connected, at most one can be in the independent set
            p.add_constraint(v[i] + v[j] <= 1)

    p.solve()

    return Integer(sum([p.get_values(v[i]) for i in xrange(n)]))

def m5p3(U, S):
    '''Return the lowest number of subsets from S to cover U
    '''
    p = MixedIntegerLinearProgram()
    v = p.new_variable(binary = True)

    p.set_objective(-sum(v[s] for s in xrange(len(S))))

    lst = [[v[j] if U[i] in S[j] else 0 for i in xrange(len(U))] for j in xrange(len(S))]

    for i in xrange(len(U)):
        p.add_constraint(sum([lst[j][i] for j in xrange(len(S))]) >= 1)

    p.solve()
    return Integer(sum([p.get_values(v[i]) for i in xrange(len(S))]))

def m5p4(xmin, xmax, ymin, ymax):
    '''Return a lambda function for the square bounded by xmin-xmax and ymin-ymax
    '''
    return lambda px, py:  bool(xmin <= px <= xmax and ymin <= py <= ymax)

def m5p5(x0, y0, r):
    '''Return a lambda function for the square with center (x0, y0) and side length 2r
    '''
    return lambda px, py:  bool(x0 - r <= px <= x0 + r and y0 - r <= py <= y0 + r)

def m5p6(x0, y0, r):
    '''Return a lambda function for the disc with center (x0, y0) and radius r
    '''
    return lambda px, py: bool(((x0 - px)**2 + (y0 - py)**2) <= r**2)

# Functions for problem 7

def hits(P, n=10000, xmin=-1, xmax=1, ymin=-1, ymax=1):
    out = []
    for i in xrange(n):
        x = random() * (xmax - xmin) + xmin
        y = random() * (ymax - ymin) + ymin

        if P(x, y):
            out.append((x, y))

    return out

def draw(shape):
    D = shape
    R = points(hits(D))
    R.show()

def area_approx(P, n = 10000, xmin = -1, xmax = 1, ymin = -1, ymax = 1):
    square = (xmax - xmin) * (ymax - ymin)
    return len(hits(P, n, xmin, xmax, ymin, ymax)) / n * square

def m5p7((a0, b0, r), n=10000, xmin=-1, xmax=1, ymin=-1, ymax=1):
    '''Return an approximation of the area covered by P (a disc) inside the rectangle
    '''
    P = m5p6(a0, b0, r)
    area = area_approx(P, n, xmin, xmax, ymin, ymax)
    return float(round(area, 1))

# Functions for problem 8

def is_below(f, (x, y, z)):
    return z <= f(x, y)

def count3D(P, n=10000, xmin=-1, xmax=1, ymin=-1, ymax=1, zmax=1):
    count = 0
    for i in xrange(n):
        x = random() * (xmax - xmin) + xmin
        y = random() * (ymax - ymin) + ymin
        z = random() * zmax

        if is_below(P, (x, y, z)):
            count += 1

    #points(out).show()

    return count

def volume_approx(f, n=10000, xmin=-1, xmax=1, ymin=-1, ymax=1, zmax=1):
    vol = (xmax - xmin) * (ymax - ymin) * zmax
    return count3D(f, n, xmin, xmax, ymin, ymax, zmax) / n * vol

def m5p8(f, n=10000, xmin=-1, xmax=1, ymin=-1, ymax=1, zmax=1):
    '''Return an approximation of the volume between the function and the xy-plane
    '''
    v = volume_approx(f, n, xmin, xmax, ymin, ymax, zmax)
    return float(round(v, 0))

