import logging

# This is fast, but is inaccessible from python. A bridging function is needed
# (I later realise that cpdef would do this for you, but I like having the 
# logging call on the python side).
cdef int _fib(int n):
    cdef int a = 0, b = 1
    cdef int i
    for i in range(n):
        a, b = b, a+b
    return a

# This is the bridging function -> Not sure if typing the output actually helps
def fib(int n) -> int:
    if n > 46:
        logging.warn("For an input this high, we will likely get int overflow "
                     "and garbage output. Python's int is better than C/C++'s "
                     "int.")
    return _fib(n)
