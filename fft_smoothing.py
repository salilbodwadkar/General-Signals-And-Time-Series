def fft_smoothing(x, r):
    xy = fft(x)
    if (r < 0) or (r > 1):
     raise Exception("R must be between zero and one")
    N = len(xy)
    Nr = int(N*r)
    xyy = np.sort(np.abs(xy))
    tol = np.abs(xyy[Nr])
     
    for i in range(N):
        if np.abs(xy[i]) < tol:
            xy[i] = 0  
    xyc = xy
    xc = ifft(xyc)
    error = np.linalg.norm(x-xc,2)/np.linalg.norm(x)
    return xc
