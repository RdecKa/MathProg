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

    #print G.keys()
    #print sum(v[i] for i in G.keys())

    p.set_objective(sum(v[i] for i in G.keys()))

    #for s in Subsets(range(len(G.keys()))):
        #print s
        #p.add_constraint(sum(1 if all(G[el].intersection(s - el) == (s - el) for el in s) else 0) == s.cardinality())
        #p.add_constraint(sum([1 if all(v[i] for el in s) else 0]) == s.cardinality())
        #p.add_constraint()

    p.solve()

    for el in G.keys():
        print p.get_values(v[el])

    return -1

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

