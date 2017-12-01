'''
Group Members
=============
'''

userids = ['karin17', 'andreas17'] # fill in this array with strings of usernames

def return_neighbours(A, c, shape='rectangle', debug=False):
    m = len(A)
    n = len(A[0])

    if c[0] >= m or c[1] >= n or c[0] < 0 or c[1] < 0:
        raise ValueError('Index out of bound! A is %d x %d, c is (%d, %d).' % (m, n, c[0], c[1]))

    l = []
    if shape == 'rectangle':

        for i in xrange(max(0, c[0] - 1), min(m, c[0] + 2)):
            for j in xrange(max(0, c[1] - 1), min (n, c[1] + 2)):
                if (i, j) == c:
                    continue
                else:
                    l.append((A[i][j], (i, j)))

    elif shape == 'torus':
        for i in xrange(c[0] - 1, c[0] + 2):
            for j in xrange(c[1] - 1, c[1] + 2):
                if (i, j) == c:
                    continue
                else:
                    l.append((A[i % m][j % n], (i % m, j % n)))

    elif shape == 'klein_bottle':
        for i in xrange(c[0] - 1, c[0] + 2):
            for j in xrange(c[1] - 1, c[1] + 2):
                if (i, j) == c:
                    continue
                else:
                    i1 = i % m
                    j1 = (n - 1- j) % n if i >= m or i == -1 else j % n
                    l.append((A[i1][j1], (i1, j1)))
    else:
        raise ValueError('%s is not a valid shape!' % shape)

    # remove duplicates from the list
    added = set()
    added_add = added.add
    if debug:
        return [x for x in l if not (x in added or added_add(x))]
    return [x[0] for x in l if not (x in added or added_add(x))]


def mAp1(A,c):
    '''Output the state of the cell after one iteration
    '''

    return -1

def mAp2(A):
    '''Output the state of the matrix after one iteration
    '''
    return [[-1]]

def mAp3(A,k):
    '''Output the state of the matrix after k iterations
    '''
    return [[-1]]

def mAp4(A,k):
    '''Output the state of the matrix after k iterations,
doing as little work as possible
    '''
    return [[-1]]

def mAp5(n=7):
    '''Output 10 different states which remain unchanged
    '''
    return []

def mAp6(n=7):
    '''Output 2 states which return to them selves after at most 5 iterations
    '''
    return []

def mAp7(A,k):
    '''Output the state of the matrix after k iterations if the
universe is a torus
    '''
    return [[-1]]

def mAp8(A,k):
    '''Output the state of the matrix after k iterations if the
universe is a Klein bottle
    '''
    return [[-1]]

