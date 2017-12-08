'''
Group Members
=============
'''

userids = ['andreas17', 'karin17'] # fill in this array with strings of usernames


class Catalan(SageObject):
    """
    The base class for all Catalan structures
    """
    def __init__(self, obj=None):
        self.obj = self.neutral_element if obj is None else obj

    def _repr_(self):
        return "%s(%s)" % (self.__class__.__name__, repr(self.obj))

    def __eq__(self, other):
        return self.obj == other.obj

    def cons(self, other=None):
        raise NotImplementedError

    def decons(self):
        raise NotImplementedError

    def is_neutral(self):
        return self.obj == self.neutral_element

    def map_to(self, cls):
        """
        The image of self under the canonical bijection
        induced by the class of self and cls
        """
        pass

    @classmethod
    def structures(cls, n):
        """
        Generates all structures of size n
        """
        pass


class Av132(Catalan):
    """
    The class of 132-avoiding permutations
    """
    neutral_element = []

    def cons(self, other=None):
        """
        Constructs a 132-avoiding permutation from
        the 132-avoiding permutations self and other
        """
        pass

    def decons(self):
        """
        Deconstructs the 132-avoiding permutation self
        into two 132-avoiding permutations:
        ’decons’ is the inverse of ’cons’
        """
        l = self.obj
        m = max(l)
        mi = l.index(m)

        return (Av132([x - len(l[mi + 1:]) for x in l[:mi]]), Av132(l[mi + 1:]))


class Dyck(Catalan):
    """
    The class of Dyck paths
    """
    neutral_element = []
    def cons(self, other=None):
        """
        Constructs a Dyck path from
        the Dyck paths self and other
        """
        pass
    def decons(self):
        """
        Deconstructs the Dyck path self
        into two Dyck paths:
        ’decons’ is the inverse of ’cons’
        """
        pass


def to_standard(p):
    '''Return the standardization of p
    '''
    n = len(p)
    l = [0] * n

    for i, (index, _) in enumerate(sorted(enumerate(p), key=lambda x:x[1]), start=1):
        l[index] = i
    return l

def get_subsequences(p, cl):
    '''Outputs a set of sets of indices of subsequences of p that have a pattern cl
    '''
    if len(cl) > len(p):
        return []

    def check_pattern(a, b):
        return to_standard(a) == b

    cl_std = to_standard(cl)
    n, q = len(p), len(cl)

    L = set()

    for i in Subsets(xrange(n), q):
        if check_pattern([p[x] for x in i], cl_std):
            L.add(i)

    return L

def mBp1(perm, mp):
    '''Return True if the permutation perm contains the
    mesh pattern mp
    '''

    def get_coordinate((x, y), L):
        i = 0
        for (k, _) in L:
            if x < k:
                break
            else:
                i += 1
        j = 0
        for (_, k) in L:
            if y < k:
                break
            else:
                j += 1
        return (i, j)

    def is_valid(perm, subseq, tiles):
        for i in set(xrange(len(perm))) - set(subseq):
            if get_coordinate((i, perm[i]), [(j, perm[j]) for j in subseq]) in tiles:
                return False
        return True

    possible_subseq = get_subsequences(perm, mp[0])
    if len(possible_subseq) == 0:
        return False

    n, k = len(perm), len(mp[0]) # length of permutation, length of classical pattern

    for subseq in possible_subseq:
        if is_valid(perm, subseq, mp[1]):
            return True
    return False


def S(perm):
    if len(perm) <= 1:
        return perm

    m = max(perm)
    mi = perm.index(m)

    return S(perm[:mi])+S(perm[mi+1:])+[m]

def mBp1_list(p, M):
    return any(mBp1(p, cl) for cl in M)

def av(M, n):
    return [p for p in Permutations(n) if not mBp1_list(list(p),M)]

def west_2_stack_sortable(n):
    return [p for p in Permutations(n) if S(S(list(p))) == range(1,len(p)+1)]

def mBp2():
    '''Output a list of patterns [p,q] such that Av(p,q) = permutations perm such that S(S(perm)) is fully sorted
    '''

    def check_S_4(p, q):
        if west_2_stack_sortable(4) == av([[p, []], [q, []]], 4):
            return True
        return False

    def check_S_5(p, q):
        if west_2_stack_sortable(5) == av([p, q], 5):
            return True
        return False

    # permutations with length 3 are always stack sortable, pattern has to be of length 4
    # mesh pattern has to be testet on permutations of length 5

    # p is a classical pattern, q is a mesh pattern
    for p in Permutations(xrange(1, 5)):
        for q in Permutations(xrange(1, 5)):
            if check_S_4(p, q):
                for a in xrange(5):
                    for b in xrange(5):
                        if check_S_5([p, []], [q, [(a, b)]]):
                            return [p, [q, [(a, b)]]]


def mBp3(perm):
    '''Return the pair of Young tableaux that correspond to perm
    '''
    t1 = [[]]
    t2 = [[]]
    c = 1
    for num in perm:
        i = 0
        while i < len(t1):
            for j in range(len(t1[i])):
                if num < t1[i][j]:
                    num, t1[i][j] = t1[i][j], num
                    i += 1
                    break
            else:
                t1[i].append(num)
                t2[i].append(c)
                c += 1
                break
        else:
            t1.append([num])
            t2.append([c])
            c += 1
    return (t1, t2)

def check_cl(p, cl):
    '''Outputs True if the permutation p contains the classical pattern cl
    '''
    if len(cl) > len(p):
        return False

    def check_pattern(a, b):
        return to_standard(a) == b

    cl_std = to_standard(cl)
    n, q = len(p), len(cl)

    for i in Subsets(xrange(n), q):
        if check_pattern([p[x] for x in i], cl_std):
            return True

    return False

def check_cl_list(p, M):
    return any(check_cl(p, cl) for cl in M)

def av_cl(M, n):
    return [p for p in Permutations(n) if not check_cl_list(list(p),M)]

def mBp4():
    '''Output a pattern p such that Av(p) = permutations whose Young tableaux have at most three cells in the first row
    '''

    def check_tableau(t):
        '''Check if the first row of the given young tableau has 3 cells at a maximum
        '''
        return len(t[0]) <= 3

    n = 4
    while True:
        for clp in Permutations(xrange(1, n + 1)): # for all classical patterns of length n
            av_set = av([[clp, []]], n + 2) # magic number n + 2, does this work?
            if all(check_tableau(mBp3(t)[0]) for t in av_set):
                return clp
        n += 1
    return False

def mBp5():
    '''Output a pattern p such that Av(p) = permutations whose Young tableaux have at most three cells in the first column
    '''
    def check_tableau(t):
        '''Check if the first column of the given young tableau has 3 cells at a maximum
        '''
        return len(t) <= 3

    n = 4
    while True:
        for clp in Permutations(xrange(1, n + 1)): # for all classical patterns of length n
            av_set = av_cl([clp], n + 1) # magic number n + 1, does this work?
            if all(check_tableau(mBp3(t)[0]) for t in av_set):
                return clp
        n += 1
    return False

def mBp6():
    '''Output a pattern p such that Av(p) = permutations whose Young tableaux is hook-shaped
    '''
    return []

def mBp7(avperm):
    '''Return the decomposition of avperm
    '''
    return avperm.decons()

def mBp8(avperm1, avperm2):
    '''Return the gluing of avperm1 and avperm2
    '''
    return Av132([])

def mBp9(dyck1, dyck2):
    '''Return the gluing of dyck1 and dyck2
    '''
    return Dyck([])

def mBp10(dyck):
    '''Return the decomposition of dyck
    '''
    return (Dyck([]), Dyck([]))

def mBp11(n):
    '''Return the 132-avoiding permutations of length n
    '''
    return []

def mBp12(avperm):
    '''Return the Dyck-path that corresponds to avperm
    '''
    return Dyck([])

