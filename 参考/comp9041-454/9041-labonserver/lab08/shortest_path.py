#!/usr/bin/python3

from collections import defaultdict
import heapq
import sys

srv = sys.argv[1]
dst = sys.argv[2]

strs = []
while True:
    try:
        aa = input()
    except EOFError:
        break
    strs.append(aa)


edges = defaultdict(list)
towns = set()
weights = {}
for s in strs:
    if s!='':
        from_p, to_p, dis = s.split()
        towns.add(from_p)
        towns.add(to_p)
        edges[from_p].append(to_p)
        edges[to_p].append(from_p)
        weights[(from_p, to_p)] = int(dis)
        weights[(to_p, from_p)] = int(dis)

MinDistance = {x:float('Inf') for x in towns}
marked = {x:False for x in towns}

minHeap = [[float('Inf'), "XXX"] for _ in range(len(towns))]
From = {x:None for x in towns}
MinDistance[srv] = 0
marked[srv] = True
num_elems = 1
heapq.heappush(minHeap, [MinDistance[srv], srv])
while(num_elems != 0):
    dis, town = heapq.heappop(minHeap)
    num_elems -= 1
    marked[town] = True
    for adj_town in edges[town]:
        if not marked[adj_town]:
            if From[adj_town] is None or MinDistance[town] + weights[(town, adj_town)] < MinDistance[adj_town]:
                MinDistance[adj_town] = MinDistance[town] + weights[(town, adj_town)]
                From[adj_town] = town
                for i in range(len(minHeap)):
                    if minHeap[i][1] == adj_town:
                        minHeap[i][0] = MinDistance[adj_town]
                        break
                    else:
                        heapq.heappush(minHeap, [MinDistance[adj_town], adj_town])
                        num_elems += 1

min_dis = MinDistance[dst]

if min_dis == float('Inf'):
    print("No path from {} to {}".format(srv, dst))
else:
    path = [dst]
    while(From[dst] != srv):
        path.append(From[dst])
        dst = From[dst]
    path.append(srv)
    print('Shortest route is length = {}: '.format(min_dis), end='');
    for i in path[::-1]:
        print(i, end=' ')
    print('.')
