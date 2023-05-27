function s = cascade(n,p)
  s = p;
  x(1:2:length(s)*2) = s;
  x(2:2:end)=0;

  for i = 1:n

    s = conv(x,p);
    x(1:2:length(s)*2) = s;
    x(2:2:end)=0;
  end
plot(s)
end
