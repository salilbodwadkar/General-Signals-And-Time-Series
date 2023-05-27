function error=fftcomp(t,y,r)

% compression with FFT

if (r < 0) | (r >1)
    eroor ('r should be between 0 and 1')
end;
fy=fft(y);
fyc=compress(fy,r);
yc=ifft(fyc);
plot(t,y,t, yc)
error=norm(y-yc,2)/norm(y)
end