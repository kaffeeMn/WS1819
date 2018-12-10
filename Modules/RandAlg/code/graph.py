import numpy as np
from collections import defaultdict
from copy import deepcopy

class Graph:

    def __init__(self, V, E, w, directed=False):
        self.V = V
        self.E = E
        self.w = lambda e: w[e]
        self.__adj = defaultdict(set)
        self.__init_adj(E)
        self.__directed = directed

    @property
    def n():
        '''
        :return: number of vertices
        '''
        return len(self.V)

    @property
    def m():
        '''
        :return: number of edges
        '''
        return len(E)

    def adj(v):
        '''
        :return: adjacency for v
        '''
        return deepcopy(self.__adj[v])

    def __init_adj(E):
        '''
        initialization of the adjacencies
        '''
        for e in E:
            if not self.__dirrected:
                self.__adj[e[1]].add(e[0])
            self.__adj[e[0]].add(e[1])
