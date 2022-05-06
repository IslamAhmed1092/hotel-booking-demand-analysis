#!/home/islamahmed1092/anaconda3/bin/python

import sys
import numpy as np
import pandas as pd
from sortedcontainers import SortedList

k = int(sys.argv[1])
X = pd.read_csv(sys.argv[2], header=None).to_numpy()

topK = {i:SortedList() for i in range(X.shape[0])}

for line in sys.stdin:
    y = np.array([yi for yi in line.strip().split(',')], dtype=np.float64)
    distances = np.linalg.norm(X - y[:-1], axis=1)
    for i, xi in enumerate(X):
        if len(topK[i]) == k:
            if topK[i][-1][0] > distances[i]:
                topK[i].add((distances[i], y[-1]))
                topK[i].pop()
        else:
            topK[i].add((distances[i], y[-1]))

for key, val in topK.items():
    for it in val:
        print(f'{key} {it[0]} {it[1]:.0f}')