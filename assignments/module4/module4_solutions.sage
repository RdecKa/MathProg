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
    t1, t2 = 1, 1
    for i in range (n - 1):
        t1, t2 = t2, t1 + t2
    return t2

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

def m4p7(p):
    '''Return the standardization of p
    '''
    return []

def m4p8(L):
    '''Return the classical patterns the permutaions in L avoid, if possible. Otherwise False
    '''
    return []

