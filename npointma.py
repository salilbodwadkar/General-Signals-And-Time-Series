import numpy as np
import scipy as sp
import matplotlib.pyplot as plt

def npointma(x,n):
    y = (1/n)*np.ones(n)
    xs = np.convolve(x,y, mode = 'valid')
    return xs

white_noise = np.random.normal(0,1,500)
time = np.linspace(0,500,500)
filtered_noise = npointma(white_noise, 5)
time2 = np.linspace(0,len(filtered_noise), len(filtered_noise))

plt.figure(figsize=(10, 4))  
plt.plot(time, white_noise, marker='o', linestyle='-', color='b')
plt.title('White Noise Series')
plt.xlabel('Time')
plt.ylabel('Value')
plt.grid(True)
plt.show()

plt.figure(figsize=(10, 4)) 
plt.plot(time2, filtered_noise, marker='o', linestyle='-', color='b')
plt.title('Filtered Noise Series')
plt.xlabel('Time')
plt.ylabel('Value')
plt.grid(True)
plt.show()

