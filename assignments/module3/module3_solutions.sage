'''
Group Members
=============
'''

userids = ['karin17'] # fill in this array with strings of usernames
def m3p1(L):
    '''Output the center of gravity for the List of tuples L
    '''
    x_sum = y_sum = 0
    for (x, y) in L:
        x_sum += x
        y_sum += y
    x = float(round(x_sum / len(L), 2))
    y = float(round(y_sum / len(L), 2))
    return (x, y)

def m3p2(p,q):
    '''Calculate the Euclidean distance between p and q. As a float rounded to 2 decimal places
    '''
    return float(round(sqrt((p[0] - q[0])**2 + (p[1] - q[1])**2), 2))

def m3p3(p,q):
    '''Calculate the Manhattan distance between p and q. As a float rounded to 2 decimal places
    '''
    return float(round(abs(p[0] - q[0]) + abs(p[1] - q[1]), 2))

def m3p4(sites, gridsize, B, f = 1/2, g = 1, d = m3p3):
    '''Write a function that implements Rossmo's equation. Note that we
give default values for the inputs f, g and d. The input sites should be a list
of sites of interest, gridsize is a tuple giving the size of the grid and B is an
integer giving the size of the buffer zone.
    '''
    #gridsize = (gridsize[1], gridsize[0])
    grid = [[0 for x in range(gridsize[0])] for y in range(gridsize[1])]
    for y in range(gridsize[1]):
        for x in range(gridsize[0]):
            for site in sites:
                dist = d((y, x), site)
                if dist > B:
                    grid[y][x] += 1.0 / float(dist**f)
                else:
                    grid[y][x] += float(B**(g - f)) / float((2 * B - dist)**g)

    return [[float(round(el, 2)) for el in row] for row in grid]

def m3p5(sites, gridsize, B):
    '''Write a function m3p5(sites, gridsize, B) that finds a cell
(or cells) in the matrix m3p4(sites, gridsize, B) with the highest Rossmo value.
    '''
    ross_values = m3p4(sites, gridsize, B)
    max_value = max(max(i for i in rows) for rows in ross_values)
    lst = [[(y, x) for x in range(len(ross_values[y])) if ross_values[y][x] == max_value] for y in range(len(ross_values))]
    lst = reduce(lambda x, y : x + y, lst)
    return set(lst)

def m3p6(n=7):
    '''Write a function m3p6() that outputs the optimal stackings for player one of Kuhn poker.
Note that for testing purposes we need to be able to pass something as input. We use n=7.
    '''
    order = ['J', 'Q', 'K']

    list_of_permutations = []
    def perm(seq, cards, used):
        if all(used):
            list_of_permutations.append("J" + "".join(seq))
            return
        for i in range(len(cards)):
            if not used[i]:
                seq.append(cards[i])
                used[i] = True
                perm(seq, cards, used)
                used[i] = False
                del seq[-1]

    def isOptimal(deck):
        for cut in range(len(deck)):
            deck = deck[1:] + deck[0]
            for i in range(0, len(deck) - 1, 2):
                if order.index(deck[i]) < order.index(deck[i + 1]):
                    return False
        return True

    perm([], order, [True, False, False])

    optimal = []
    for deck in list_of_permutations:
        if isOptimal(deck):
            optimal.append(deck)

    return optimal

def m3p7(n=7):
    '''Write a function m3p7() that outputs the optimal stackings for player one
of K poker. Again, to avoid redundancy only list the cut of an optimal deck that starts with 2.
Note that for testing purposes we need to be able to pass something as input. We use n=7.
    '''
    cards = [2, 3, 4, 5, 6, 7, 8, 9, 10]

    def has_straight(hand):
        # hand has 6 cards
        return hand[:-1] == range(hand[0], hand[-2] + 1) or hand[1:] == range(hand[1], hand[-1] + 1)

    def isOptimal(deck):
        for _ in range(len(cards)):
            deck = deck[1:] + deck[0:1]
            player1 = sorted(deck[0:1] + deck[2:3] + deck[4:8])
            player2 = sorted(deck[1:2] + deck[3:8])

            player1_straight = has_straight(player1)
            player2_straight = has_straight(player2)

            # if player2 has a straight but player1 doesn't we lose
            if (player2_straight and not player1_straight):
                return False

            # if player1 has a straight but player2 doesn't, we don't necessarily lose
            if player1_straight and not player2_straight:
                continue

            # if noone (or both) has a straight, check highest card
            i = len(player1) - 1
            while player2[i] == player1[i]:
                i -= 1
            if player2[i] > player1[i]:
                return False
        return True

    L = []
    perms = CyclicPermutations(cards)

    for perm in perms:
        if isOptimal(perm):
            L.append(perm)
    return L
