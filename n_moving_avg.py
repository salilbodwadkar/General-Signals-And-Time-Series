import numpy as np
def npointma(x,n):
    y = (1/n)*np.ones(n)
    xs = np.convolve(x,y, mode = 'valid')
    return xs
