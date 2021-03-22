function n = get_n(p)
n = 0;
global burndata;
for jdx=1:length(burndata.p_low)
    if p >= burndata.p_low(jdx) && p < burndata.p_high(jdx)
        n = burndata.n(jdx);
    end
end
end