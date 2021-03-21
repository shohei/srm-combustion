clear; close all;

knsu = readtable('knsu');
kndx = readtable('kndx');
knsb = readtable('knsb');

[p_knsu,r_knsu]=calc_burnrate(knsu);
[p_kndx,r_kndx]=calc_burnrate(kndx);
[p_knsb,r_knsb]=calc_burnrate(knsb);

plot(p_knsu,r_knsu);
hold on ;
plot(p_kndx,r_kndx);
plot(p_knsb,r_knsb);

legend('KNSU (de Saint Robert)','KNDX (Plateau)','KNSB (MESA)');
title('Burnrate - Pressure Curve');
xlabel('Pressure [MPa]');
ylabel('Burnrate [mm/sec]');

big;

function [ps,rs] = calc_burnrate(burndata)

lower_limit = burndata.p_low(1);
upper_limit = burndata.p_high(end);
p_division = 0.1; %MPa
ps = lower_limit:p_division:upper_limit;
rs = [];
for idx=1:length(ps)
    p = ps(idx);
    n = 0;
    a = 0;
    for jdx=1:length(burndata.p_low)
        if p > burndata.p_low(jdx) && p < burndata.p_high(jdx)
            n = burndata.n(jdx);
            a = burndata.a(jdx);
        end
    end
    r = a*p^n;
    rs(end+1) = r;
end
end
