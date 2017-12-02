'''
Group Members
=============
'''

# fill in this array with strings of usernames
userids = ['karin17', 'andreas17']


def return_neighbours(A, c, shape='rectangle', coordinates=False):
    m = len(A)
    n = len(A[0])

    if c[0] >= m or c[1] >= n or c[0] < 0 or c[1] < 0:
        raise ValueError(
            'Index out of bound! A is %d x %d, c is (%d, %d).' % (m, n, c[0], c[1]))

    l = []
    if shape == 'rectangle':

        for i in xrange(max(0, c[0] - 1), min(m, c[0] + 2)):
            for j in xrange(max(0, c[1] - 1), min(n, c[1] + 2)):
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
                    j1 = (n - 1 - j) % n if i >= m or i == -1 else j % n
                    l.append((A[i1][j1], (i1, j1)))
    else:
        raise ValueError('%s is not a valid shape!' % shape)

    # remove duplicates from the list
    added = set()
    added_add = added.add
    if coordinates:
        return [x for x in l if not (x in added or added_add(x))]
    return [x[0] for x in l if not (x in added or added_add(x))]


def mAp1(A, c):
    '''Output the state of the cell after one iteration
    '''
    num_neighbours_alive = sum(return_neighbours(A, c))
    if (num_neighbours_alive <= 1 or num_neighbours_alive >= 4):
        return 0
    if (num_neighbours_alive == 2):
        return A[c[0]][c[1]]
    if (num_neighbours_alive == 3):
        return 1
    return -1


def mAp2(A):
    '''Output the state of the matrix after one iteration
    '''
    A_new = [[0 for i in xrange(len(A[0]))] for i in xrange(len(A))]
    for i in xrange(len(A_new)):
        for j in xrange(len(A_new[i])):
            A_new[i][j] = mAp1(A, (i, j))
    return A_new


def mAp3(A, k):
    '''Output the state of the matrix after k iterations
    '''
    for i in xrange(k):
        A = mAp2(A)
    return A


def better_iteration(A, k, shape='rectangle', debug=False):
    if k < 1:
        return A
    if k == 1:
        return mAp2(A)
    n = len(A)
    m = len(A[0])

    A_n = mAp2(A)

    # matrix that indicates changed cells
    A_c = [[[A[i][j] != A_n[i][j]
            for j in xrange(len(A[0]))] for i in xrange(len(A))], [[False for j in xrange(len(A[0]))] for i in xrange(len(A))]]

    if debug:
        print("Change Matrix:")
        pretty_print(matrix(A_c[0]))

        print("Iteration 1")
        pretty_print(matrix(A_n))

    for l in xrange(k - 1):
        updated = False
        #A_tmp = [[0 for i in xrange(len(A[0]))] for i in xrange(len(A))]
        A_tmp = copy(A_n)
        for i in xrange(len(A)):
            for j in xrange(len(A[0])):
                if A_c[0][i][j]: #if change at i, j
                    neighbours = return_neighbours(
                        A_n, (i, j), shape=shape, coordinates=True) #get neighbours
                    if debug:
                        print i, j, neighbours
                    for _, (x, y) in neighbours: #for every neighbour
                        if not A_c[1][x][y]: #that is not updated
                            A_tmp[x][y] = mAp1(A_n, (x, y)) #update
                            if debug:
                                print "update", x, y, A_tmp[x][y]
                            A_c[1][x][y] = True # set to updated
                    if not A_c[1][i][j]:
                        A_tmp[i][j] = mAp1(A_n, (i, j))
                        A_c[1][i][j] = True
                else:
                    #A_tmp[i][j] = A_n[i][j]
                    pass

        if debug:
            print("Update Matrix:")
            pretty_print(matrix(A_c[1]))

        A_c = [[[A_tmp[i][j] != A_n[i][j]
            for j in xrange(len(A[0]))] for i in xrange(len(A))], [[False for j in xrange(len(A[0]))] for i in xrange(len(A))]]
        #A_c[1] = [[False for j in xrange(len(A[0]))] for i in xrange(len(A))]

        if debug:
            print("Iteration: %d" % (l + 2))
            pretty_print(matrix(A_tmp))
            print("Should be:")
            pretty_print(matrix(mAp3(A, l + 2)))
            print("Change Matrix:")
            pretty_print(matrix(A_c[0]))

        A_n = A_tmp



    return A_n


def mAp4(A, k):
    '''Output the state of the matrix after k iterations,
doing as little work as possible
    '''
    return better_iteration(A, k, debug=True)


def mAp5(n=7):
    '''Output 10 different states which remain unchanged
    '''
    n = max(n, 5) # Index out of bounds for smaller matrices
    L = []
    for i in xrange(10):
        new_state = [[0 for j in xrange(n)] for k in xrange(n)]
        start_j = i % (n - 1)
        start_i = i // (n - 1)
        for y in xrange(start_j, start_j + 2):
            for x in xrange(start_i, start_i + 2):
                new_state[y][x] = 1
        #pretty_print(matrix(new_state))
        L.append(new_state)
    return L


def mAp6(n=7):
    '''Output 2 states which return to them selves after at most 5 iterations
    '''
    n = max(n, 3)

    new_state1 = [[0 for i in xrange(n)] for j in xrange(n)]
    center = n // 2
    for i in range(center - 1, center + 2):
        new_state1[center][i] = 1

    new_state2 = [[0 for i in xrange(17)] for j in xrange(17)]
    for i in [2, 7, 9, 14]:
        for j in [4, 5, 6, 10, 11, 12]:
            new_state2[i][j] = 1
            new_state2[j][i] = 1

    return [new_state1, new_state2]


def mAp7(A, k):
    '''Output the state of the matrix after k iterations if the
universe is a torus
    '''
    return better_iteration(A, k, shape='torus')


def mAp8(A, k):
    '''Output the state of the matrix after k iterations if the
universe is a Klein bottle
    '''
    return better_iteration(A, k, shape='klein_bottle')
