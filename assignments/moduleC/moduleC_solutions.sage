'''
Group Members
=============
'''

userids = ['karin17', 'andreas17'] # fill in this array with strings of usernames


def mCp1(x,y):
    '''Return the Euclidean distance between x and y
    '''
    a = vector(y) - vector(x)

    return float(round(a.norm(), 2))

def mCp2(x, y):
    '''Return the Manhattan distance between x and y
    '''
    a = vector(y) - vector(x)

    dist = sum(map(lambda u: abs(u), a))

    return float(round(dist, 2))

def mCp3(x, y):
    '''Retun the Hamming distance between x and y
    '''
    return sum([a != b for (a, b) in zip(x, y)])

def mCp4(x, y):
    '''Return the Levenshtein distance between x and y
    '''

    m, n = len(x), len(y)

    D = [[-1 for _ in xrange(n + 1)] for _ in xrange(m + 1)]

    D[0][0] = 0
    for i in xrange(1, m + 1):
        D[i][0] = i
    for j in xrange(1, n + 1):
        D[0][j] = j


    for i in xrange(1, m + 1):
        for j in xrange(1, n + 1):
            if x[i - 1] == y[j - 1]:
                D[i][j] = min(D[i-1][j-1] + 0, D[i][j-1] + 1, D[i - 1][j] + 1)
            else:
                D[i][j] = min(D[i-1][j-1] + 1, D[i][j-1] + 1, D[i - 1][j] + 1)

    return D[m][n]

def mCp5(x, y):
    '''Return the rank distance of the matrices constructed from x and y
    '''
    A = matrix(QQ, Integer(sqrt(len(x))), x)
    B = matrix(QQ, Integer(sqrt(len(y))), y)
    return (A - B).rank()


def nn(p, N):
    min_dst = infinity
    min_l = infinity
    index = 0
    for (i, (n, l)) in enumerate(N):
        dst = mCp3(p, n)
        if dst < min_dst:
            min_dst = dst
            min_l = l
            index = i
        elif dst == min_dst and l < min_l:
            min_l = l
            index = i

    return N[index]

def mCp6(L):
    '''Check whether L satisfies the axiom of neighborliness w.r.t the Hamming distance
    '''

    for p, l in L:
        N = list(L)
        N.remove((p, l))
        if l != nn(p, N)[1]:
            return False

    return True

def mCp7(L, J):
    '''Use the labeled points in L to label the points in J using the nearest neighbor in the Hamming distance
    '''
    labled = []

    for j in J:
        labled.append((j, nn(j, L)[1]))

    return labled

def mCp8(L, J, k):
    '''Use the labeled points in L to label the points in J using the k nearest neighbors in the Hamming distance
    '''

    k = min(k, len(L))
    labled = []
    for j in J:
        knn = []
        n_list = list(L)
        for _ in xrange(k):
            n = nn(j, n_list)
            knn.append(n[1])
            n_list.remove(n)

        labled.append((j, max(set(knn), key=knn.count)))

    return labled

