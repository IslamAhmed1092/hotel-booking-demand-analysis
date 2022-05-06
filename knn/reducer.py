#!/home/islamahmed1092/anaconda3/bin/python

import sys
import numpy as np
from sortedcontainers import SortedList

k = int(sys.argv[1])

topK = {}
for line in sys.stdin:
    idx, dist, label = line.strip().split(' ', 2)
    
    idx = int(float(idx))
    dist = float(dist)
    label = int(float(label))

    try:
        if len(topK[idx]) == k:
            if topK[idx][-1][0] > dist:
                topK[idx].add((dist, label))
                topK[idx].pop()
        else:
            topK[idx].add((dist, label))
    except:
         topK[idx] = SortedList([(dist, label)])


for key, val in  topK.items():
    
    classes = np.array([0, 0])
    for it in val:
        classes[it[1]] += 1
    print(f'{key},{classes.argmax()}')
