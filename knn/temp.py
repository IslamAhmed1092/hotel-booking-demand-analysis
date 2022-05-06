#!/home/islamahmed1092/anaconda3/bin/python

# mapper for 1 example
import sys
import numpy as np

k = int(sys.argv[1])
x = [xi for xi in sys.argv[2:]]

distances = []
for line in sys.stdin:
    y = [yi for yi in line.strip().split(',', len(x))]
    distance = np.linalg.norm(np.array(x, dtype=np.float64) - np.array(y[:-1], dtype=np.float64))
    y.insert(0, str(distance))
    distances.append(y)

distances.sort(key=lambda x: x[0])
k = min(k,len(distances))

for i in range(k):
    print(' '.join(distances[i]))

# reducer for 1 example
import sys
import numpy as np

k = int(sys.argv[1])

distances = []
for line in sys.stdin:
    y = line.strip().split(' ')
    distances.append(y)

k = min(k,len(distances))
classes = np.array([0, 0])
for i in range(k):
    classes[int(distances[i][-1])] += 1

print(classes.argmax())


####

import sys
import numpy as np
import pandas as pd

X = pd.read_csv(sys.argv[1], header=None).to_numpy()

indices = np.arange(0, X.shape[0]).reshape(-1,1)
labels = np.ones((X.shape[0],1))

for line in sys.stdin:
    y = np.array([yi for yi in line.strip().split(',')], dtype=np.float64)
    distances = np.linalg.norm(X - y[:-1], axis=1).reshape(-1,1)
    labs = labels * y[-1]
    a = np.concatenate((indices, distances, labs), axis=1)
    np.savetxt(sys.stdout, a, fmt="%0.2f")    