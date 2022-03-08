clear; close all; clc;

k = 1.177; %Propep 3での計算値(KNSB) ストイキ
Pc = 1.31; %[MPa] Nakkaのグラフの値。OpenMotorでも同様の値(KNSB)。
rstar = 12; %mm
%re = 50; %mm
re = 25; %mm
Astar = pi*rstar^2;
Ae = pi*re^2;
e = Ae/Astar;
pa = 0.1013; %[MPa] 背圧は大気圧

figure();
p0_pa = Pc/pa;
fprintf('p0_pa: %.2f\n',p0_pa);
sigma_star = sqrt(k*(2/(k+1))^((k+1)/(k-1)));

pa_pe = linspace(0,5,20);
pe = pa./pa_pe;
K = 2*k/(k-1);
a = sigma_star * sqrt(K*(1-(pe./Pc).^((k-1)/k)));
b1 = sqrt(K*(1-(pe./Pc).^((k-1)/k)));
b = sigma_star * (pe./Pc-pa/Pc)./((pe./Pc).^(1/k).*b1);
Cf = a + b;

plot(pa_pe,Cf);
title('ノズル出口圧力peと推力係数Cfの関係');
xlabel('圧力比 pa/pe');
ylabel('推力係数 Cf');
grid;


figure();
pc_pe = [10,20,50,100,200,500,1000,2000,5000,10000];
pe = Pc./pc_pe;
Cf = sqrt(2*k^2/(k-1)*(2/(k+1))^((k+1)/(k-1))*(1-(pe./Pc).^((k-1)/k)))+...
    (pe-pa)./Pc*e;
plot(pc_pe,Cf);
title('燃焼室圧pcと推力係数Cfの関係');
xlabel('圧力比 pc/pe');
ylabel('推力係数 Cf')
big;
grid;
