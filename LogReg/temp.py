# mapper for SGD
import sys
import numpy as np

data = np.array([np.array([i for i in line.strip().split(',')], dtype=np.float64) for line in sys.stdin])
X_train = np.pad(data[:, :-1], [(0,0), (1,0)], mode='constant', constant_values=1)
y_train = data[:, -1:]

epochs = int(sys.argv[1])
alpha = float(sys.argv[2])
w = np.zeros((X_train.shape[1], 1))

for epoch in range(epochs):
    for i in range(X_train.shape[0]):
        x = X_train[i].reshape(-1,1)
        y = y_train[i]
        
        yhat = (1/(1+np.exp(-(w.T @ x)))).squeeze()
        grad = (yhat - y) * x
        w = w - alpha * grad

for i in range(w.shape[0]):
    print(f'{i}\t{w[i][0]}')