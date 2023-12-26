import numpy as np

data = np.array([1, 3, 5, 7, 9])

sd = np.std(data)

var = np.var(data)

print(f"Standard deviation: {sd:.2f}")

print(f"Variance: {var:.2f}")