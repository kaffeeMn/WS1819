import numpy as np
from graph import Graph as G
import pickle

G_NUM = 20

def boruvka_mst(G):
    # mark edges to be contracted
    # determine connected components
    # replace each component by a single vetex
    # eliminate self loops
    return G

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

