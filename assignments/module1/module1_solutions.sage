'''
Group Members
=============
'''

userids = ['karin17'] # fill in this array with strings of usernames
def m1p1(n):
    '''Project Euler Problem 1
Given a positive integer n calculate the sum of all multiples of 3 and 5 less than n.

    '''
    return sum(Set(srange(3, n, 3)).union(Set(srange(5, n, 5))))

def m1p2(n):
    '''Project Euler Problem 2.
Given a positive integer n find the sum of the even valued Fibonacci numbers less than n.

    '''
    # 1 1 -2- 3 5 -8- 13 21 -34- -> only each third number is even
    '''sum = 0
    a = 1
    b = 2
    while b < n:
        sum += b
        t1 = a + b
        t2 = b + t1
        b = t2 + t1
        a = t2
    return sum'''
    return sum([num for num in fibonacci_xrange(n) if num & 1 == 0])

def m1p3(n):
    '''Project Euler Problem 3.
Given an positive integer n find the largest prime factor of n
    '''
    return max([x for (x, _) in list(factor(n))]) # could use max(n.prime_factors())

def m1p4(n):
    '''Project Euler Problem 4.
Given a positive integer n. Find the largest palindrome made from the product of two n digit numbers
    '''
    maxim = int(10 ** n - 1)
    minim = int(10 ** (n - 1))
    a = maxim
    current_max = 0
    while a > minim:
        for b in range(a, minim - 1, -1):
            product = a * b
            str_product = str(product)
            if (product > current_max and str_product[:floor(len(str_product) / 2)] == str_product[ceil(len(str_product) / 2):][::-1]):
                current_max = product
                break
        a -= 1
    return current_max

def m1p5(n):
    '''Project Euler Problem 5.
Given a positive integer n. Find the smallest positive number evenly divisible by all numbers from 1 to n
    '''
    '''product = 1
    for num in range(2, n + 1):
        product *= num / gcd(product, num)
    return product'''
    return reduce(lambda product, num: product * num / gcd(product, num), range(1, n + 1)) # shorter: lcm(range(n + 1))

def m1p6(n):
    '''Project Euler Problem 6.
Given a positive integer n. Find the difference between the square of the sum and the sum of the squares of the
first n natural numbers
    '''
    return sum(range(1, n + 1))**2 - sum([x**2 for x in range(1, n + 1)])

def m1p7(n):
    '''Project Euler Problem 7.
Given a positive integer n. Find the nth Prime.
    '''
    return(Primes().unrank(n - 1)) # could be Primes()[n-1]

def m1p8(n,k):
    '''Project Euler Problem 9.
Given positive integers n and k. Find the greatest product of k adjacent digits in n.
    '''
    # Should return 1 if k < len(n)! The product of an empty set is 1
    n_str = str(n)
    maxim = 0
    i = 0
    while i < len(n_str):
        if len(n_str) - i < k:
            # Not enough digits left
            break
        product = 1
        zero_detected = False

        # Get the first non-zero product
        #print("First for loop")
        for j in range(i, min(i + k, len(n_str))):
            #print(i, j, int(n_str[j]))
            if (int(n_str[j]) == 0):
                zero_detected = True
                break
            product *= int(n_str[j])
        i = j + 1
        if zero_detected:
            continue
        #print("Have product of", n_str[i-k:i], "--->", product)
        maxim = product if product > maxim else maxim

        # Continue by multiplying with the next digit and dividing with k-last digit
        #print("Second for loop")
        for j in range(i, len(n_str)):
            if int(n_str[j]) == 0:
                break
            product = product * int(n_str[j]) / int(n_str[j - k])
            #print("Have product of", n_str[j-k+1:j+1], "--->", product)
            maxim = product if product > maxim else maxim
        i = j + 1
    return maxim

def m1p9(n):
    '''Project Euler Problem 9.
Given a positive integer n. Find a Pythagorean triple such that a+b+c=n
    '''
    a = 1
    while a < n: # UPDATE: The smallest number cannot be bigger than n/3!
        for b in range(1, a + 1): # UPDATE: The second number cannot be bigger than n/2
            c = n - a - b
            if a**2 + b**2 == c**2:
                return (a, b, c)
        a += 1

def m1p10(n):
    '''Project Euler Problem 10.
Given a positive integer n. Find the sum of all primes less than n.
    '''
    P = Primes()
    p = P.first()
    s = 0
    while p < n:
        s += p
        p = P.next(p)
    return s
# UPDATE: sum(primes(n))

def m1p11(M,k):
    '''Project Euler Problem 11.
Given a matrix m (as a list of lists) and integer k. Find the greatest product of k vertical, horizontal, or diagonal entries in m.
    '''
    maxim = 0
    # Horisontally
    for y in range(0, len(M)):
        for x in range(0, len(M[y]) - k + 1):
            maxim = max(reduce(lambda a, b: a * b, M[y][x:x + k]), maxim)
    # Vertically
    for x in range(0, len(M[0])):
        for y in range(0, len(M) - k + 1):
            maxim = max(reduce(lambda a, b: a * b, [M[y + i][x] for i in range(0, k)]), maxim)
    # Diagonally (top left - bottom right)
    for y in range(0, len(M) - k + 1):
        for x in range(0, len(M[y]) - k + 1):
            maxim = max(reduce(lambda a, b: a * b, [M[y + i][x + i] for i in range(0, k)]), maxim)
    # Diagonally (bottom left - top right)
    for y in range(k - 1, len(M)):
        for x in range(0, len(M[y]) - k + 1):
            maxim = max(reduce(lambda a, b: a * b, [M[y - i][x + i] for i in range(0, k)]), maxim)
    return maxim

def m1p12(n):
    '''Project Euler Problem 12.
Given an integer n. Find the smallest triangular number with more than n divisors.
    '''
    triangular = 1
    step = 2
    while len(divisors(triangular)) <= n:
        triangular += step
        step += 1
    return triangular

def m1p13(L,k):
    '''Project Euler Problem 13.
Given a list L of integers and an integer k. Find the first k digits of the sum of the elements of L.
    '''
    return int(str(reduce(lambda a, b: a + b, L))[:k]) # use sum() -.-

mem = {1:1}
def helper(n):
    if n in mem:
        return (n, mem[n])
    res = 1 + helper([n//2, 3*n+1][n%2])[1]
    mem[n] = res
    return (n, res)

def m1p14solution(n):
    return sorted(map(helper, range(1,n)), key = lambda x:x[1])[-1][0]

# Auxiliary function for m1p14
def add_to_dic(dic, k):
    #print('.', k)
    '''if k & 1 == 0:
        if k // 2 not in dic:
            add_to_dic(dic, k // 2)
        dic[k] = dic[k // 2] + 1
    else:
        if 3 * k + 1 not in dic:
            add_to_dic(dic, 3 * k + 1)
        dic[k] = dic[3 * k + 1] + 1
    return dic[k]'''

    num = k
    leng = 1
    while num != 1:
        if num in dic:
            leng += dic[num]
            break
        num = num >> 1 if num & 1 == 0 else 3 * num + 1
        leng += 1
    dic[k] = leng
    #dic[k << 1] = leng + 1
    #dic[k << 2] = leng + 2
    return dic[k]

def m1p14(n):
    '''Project Euler Problem 14.
Which starting number under n produces the longest Collatz chain.
    '''
    dic = {1:1}
    max_len = 0
    max_num = 0
    for num in range(1, n):
        t = add_to_dic(dic, num)
        #print(num, t)
        if t > max_len:
            max_len = t
            max_num = num
    return max_num

def m1p15(n,m):
    '''Project Euler Problem 14.
How many paths are there with Only steps right and down through an n*m grid
    '''
    return binomial(n + m, m)
