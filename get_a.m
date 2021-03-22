function a = get_a(p)
a = 0;
global burndata;
for jdx=1:length(burndata.p_low)
    if p >= burndata.p_low(jdx) && p < burndata.p_high(jdx)
        a = burndata.a(jdx);
    end
end
end
