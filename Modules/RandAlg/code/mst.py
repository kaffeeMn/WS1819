import numpy as np
from graph import Graph
import pickle

G_NUM = 20
# TODO: use graph contructor instead of tuples

def connected_copms(G):
    '''
    :param G: Graph to etablish connected components for
    :return: list with connected components of G
    '''
    V, E = G
    marked = {}
    for v in V:
        marked[v] = False
    # calculating connected components
    for v in V:
        if not marked[v]:
            # TODO

def bor_phases(G:Graph, n_phases):
    '''
    performs n_phases boruvka phases on the graph G
    :param G: Graph to be reduced
    :n_phases: number of phases
    :return: G_1, C, done
             the reduced graph, marked edges and a flag indicating whether the 
             algorithm has been terminated
    '''
    V, E = G.V, G.E
    # flag indicating completion
    done = False
    # G_1
    V_1 = set()
    E_1 = set()
    # C
    V_C = deepcopy(V)
    E_C = set()
    # marking minimal edges
    for i in range(n_phases):
        for v in V:
            adj = G.adj(v)
            e_min = adj[np.argmin([G.w(e) for e in adj])]
            E_C.add(e_min)
    # contraction
    v_max = np.amax(V)
    c_comps = connected_copms((V, E_C))
    # building the graphs
    C = (V_C, E_C)
    G_1 = (V_1, E_1)
    return G_1, C, done

def G_p05(G):
    '''
    :param G: graph to smaple for
    :return: G(0.5) with probability 0.5 for each edge to be included
    '''
    V,E = G.V, G.E
    E_2 = set()
    V_2 = V
    bools = [True, False]
    for e in E:
        if np.random.choice(bools):
            E_2.add(e)
    G_2 = (V_2, E_2)
    return G_2

def mst(G):
    '''
    :param G: G = (V,E), 
              with V, E as instances of set
    :return: approximation F of the MST/ MSF of G
    '''
    # 3 boruvka phases
    G_1, C, done = bor_phases(G, 3)
    # recursion hook
    if done:
        return C
    # randomized smapling
    G_2 = G_p05(G_1)
    # first recursion
    F_2 = mst(G_2)
    # elimination of F-heavy edges
    V_1, E_1 = G_1
    G_3 = (V_1, E_1.difference(f_heavy(G_1, F_2)))
    # rekusrion without f-heavy edges
    F_3 = mst(G_3)
    # union forrest
    F = Graph(F_3[0].union(C_[0]), F_3[1].union(C_[1]))
    return F

if __name__ == '__main__':
    G_list = []
    for g_num in range(G_NUM):
        V = np.arange(np.random.randint(low=2, high=10))
        E = []
        for v in V:
            for x in V:
                if np.random.random() >= 0.5:
                    E.append((v,x))
        E = np.array(E)
        w = {}
        for e in E:
            w[e] = np.random.randint(low=1, high=10)
        G_list.append(G(V, E, w))


    res_list = [boruvka_mst(g) for g in G_list]
    with open('results.pkl', 'wb') as f:
        pickle.dump(res_list, f)

