import numpy as np

class Graph:

    def __init__(self, V, E, w):
        self.V = V
        self.E = E
        self.w = w
        self.n = len(V)
        self.m = len(E)
        self.inz_mat = np.zeros(self.n * self.n, dtype=bool)
        self.inz_mat[[e[0]*self.n + e[1] for e in self.E]] = True
