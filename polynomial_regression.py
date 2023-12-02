import numpy as np

def poly_reg(X, Y, deg):
    # if (x_i,y_i) are n+1 observed data points, then X = (x_0, ... , x_n) 
        # and Y = (y_0, ... , y_n). deg is degree of polynomial desired
    if not (len(X) == len(Y)):
        raise Exception("X and Y must be of the same legnth")
    if len(X) <= deg:
        raise Exception("System must be overdetermined")
    Z = np.zeros((len(X), deg+1))
    for i in range(deg+1):
        Z[:,i] = np.power(X,deg-i)     
    Zstar = np.conj(np.transpose(Z))
    A = np.matmul(Zstar, Z)
    b = np.matmul(Zstar, Y)
    
    v = np.linalg.solve(A,b)
    
    return v
    
