def compute_max_flow(capacity, s, t):

    def find_path():
    #BFS path finder
        length = len(C)
        prev = [-1 for i in range(length)] #-1: not visited
        prev[int(s)] = -2 #-2: source vertex
        M = [0 for i in range(length)]
        M[int(s)] = float("inf")

        queue = [int(s)]
        f = 0
        while queue:
            u = queue.pop(0)
            for v in edge[u]:
                if (C[u][v] - F[u][v]) > 0 and prev[v] == -1:
                    prev[v] = u
                    M[v] = min(M[u], C[u][v] - F[u][v]) # min(flow from prev, available capacity)
                    if v != int(t):
                        queue.append(v)
                    else:
                        return M[int(t)], prev
        return 0, prev

    #init
    total = 0
    for (u, v) in capacity: # Find the number of notes
        total = max(max(int(u), int(v)), total)

    F = [[0 for col in range(total+1)] for row in range(total+1)]
    C = [[0 for col in range(total+1)] for row in range(total+1)]
    edge = [[] for row in range(total+1)]
    for (u, v) in capacity:
        '''
        NOTICE: There might be input which contains both (u,v) and (v, u)
            We should not combine together and set their absolute di-
            fference as the capacity for (u, v) or (v, u) even though
            the result we get for maxflow is correct because it will
            lead to mistake in the minimum cut. 
            (See: flownetwork_03.csv)
        '''
        edge[int(u)].append(int(v))
        edge[int(v)].append(int(u))
        C[int(u)][int(v)] = capacity[(u, v)]

    #Edmonds-Karp
    totalflow = 0
    while True:
        pathflow, prev = find_path()
        if 0 == pathflow:
            break
        totalflow += pathflow
        v = int(t)
        while v!= int(s):
            u = prev[v]
            F[u][v] += pathflow
            F[v][u] -= pathflow
            v = u
    flow = {}
    for (u, v) in capacity:
        if (F[int(u)][int(v)]<0):
            F[int(u)][int(v)] = 0
        flow[(u,v)] = F[int(u)][int(v)]

    #mincut
    cutset = [str(i) for i,e in enumerate(prev) if e >= 0]
    cutset.append(s)

    return totalflow, flow, cutset

'''
if __name__ == '__main__':
    import csv
    with open('flownetwork_03.csv') as f:
        rows = [row for row in csv.reader(f)][1:]
        capacity = {(u, v): int(c) for u,v,c in rows}
        Totalflow, Flow, Cutset = compute_max_flow(capacity, '0', '4')
        print(Totalflow, Flow, Cutset)
'''
