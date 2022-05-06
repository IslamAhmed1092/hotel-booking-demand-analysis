# mapper for batch gradient descent
import sys
import numpy as np
import matplotlib.pyplot as plt

epochs = int(sys.argv[1])
alpha = float(sys.argv[2])

data = np.array([np.array([i for i in line.strip().split(',')], dtype=np.float64) for line in sys.stdin])
X = np.pad(data[:, :-1], [(0,0), (1,0)], mode='constant', constant_values=1)
y = data[:, -1:]

w = np.zeros((X.shape[1], 1))
m = X.shape[0]

def sigmoid(z):
    return 1/(1+np.exp(-z))

# def cost(y, yhat):
#     cost = -np.mean(y*np.log(yhat) + (1-y)*np.log(1-yhat))
#     return cost

# costs = []
for epoch in range(epochs):
    yhat = sigmoid(X @ w)
    # costs.append(cost(y, yhat))
    grad = 2/m * (X.T @ (yhat - y))
    w = w - alpha * grad


for i in range(w.shape[0]):
    print(f'{i}\t{w[i][0]}')