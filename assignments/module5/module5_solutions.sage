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
    for i, j in [(k, l) for k in xrange(n) for l in xrange(k + 1, n)]:
        if i in G[j]:
            continue
        p.add_constraint(v[i] + v[j] <= 1)

    p.solve()

    return Integer(sum([p.get_values(v[i]) for i in xrange(n)]))

def m5p2(G):
    '''Return the size of the largest independent set
    '''
    return -1

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
    return lambda px, py: True

def m5p5(x0, y0, r):
    '''Return a lambda function for the square with center (x0, y0) and side length 2r
    '''
    return lambda px, py: True

def m5p6(x0, y0, r):
    '''Return a lambda function for the disc with center (x0, y0) and radius r
    '''
    return lambda px, py: True

def m5p7((a0, b0, r), n=1000, xmin=-1, xmax=1, ymin=-1, ymax=1):
    '''Return an approximation of the area covered by P (a disc) inside the rectangle
    '''
    return -1

def m5p8(f, n=1000, xmin=-1, xmax=1, ymin=-1, ymax=1, zmax=1):
    '''Return an approximation of the volume between the function and the xy-plane
    '''
    return -1

