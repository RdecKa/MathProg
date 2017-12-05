'''
Group Members
=============
'''

userids = ['karin17', 'andreas17'] # fill in this array with strings of usernames
def m4p1(p):
    '''Output the number of inversions
    '''
    n = len(p)
    inv = 0
    for i in xrange(n):
        for j in xrange(i + 1, n):
            if p[i] > p[j]:
                inv += 1
    return inv

def m4p2(p):
    '''Return the number of descents
    '''
    des = 0
    for i in range(len(p) - 1):
        if p[i] > p[i + 1]:
            des += 1
    return des

def m4p3(n):
    '''Return the number of permutations that have the same amount of inversions and descents
    '''
    '''
    n_i+1 = n_i + 1 or
    n_i+1 = n_i + 2 -> n_i+2 = n_i + 1
    has to be true for all 0 <= i < n for a permutation to have as many inversions as descents
    so m4p3(n) = m4p3(n - 1) + m4p3(n - 2)
    with m4p3(0) = 1 and m4p3(1) = 1 this corespons to the fibonacci numbers
    '''
    t1, t2 = 1, 1
    for i in range (n - 1):
        t1, t2 = t2, t1 + t2
    return t2

def m4p7(p):
    '''Return the standardization of p
    '''
    n = len(p)
    l = [0] * n

    for i, (index, _) in enumerate(sorted(enumerate(p), key=lambda x:x[1]), start=1):
        l[index] = i
    return l

def m4p4(p, cl):
    '''Input True if the permutation p contains the classical pattern cl
    '''
    return None

def m4p5(p):
    '''Return the permutation after one pass with bubble-sort
    '''
    return []

def m4p6(n=7):
    '''Return the correct classical patterns
    '''
    return []



def m4p8(L):
    '''Return the classical patterns the permutaions in L avoid, if possible. Otherwise False
    '''
    return []

