function wc=compress(w,r) 
if (r < 0) ||(r>1 )
    error('r should be between 0 and 1')
end
N=length(w); Nr=floor(N*r);
ww=sort(abs(w));
tol=abs(ww(Nr));
for j=1:N
    if (abs(w(j)) < tol)
        w(j)=0;
    end
end
wc=w;
