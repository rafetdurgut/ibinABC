function i=RouletteWheel(p)
    p = p/sum(p);
    r=rand;
    c=cumsum(p);
    i=find(r<=c,1,'first');
end