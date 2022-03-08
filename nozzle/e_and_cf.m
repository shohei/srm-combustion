clear; close all; clc;

% N-2ロケット 固体推進剤 KNSB
Pc = 1.31; %[MPa] Nakkaのグラフの値。OpenMotorでも同様の値(KNSB)。
k = 1.177;  %Propep3の計算値(KNSB), O:F=65:35
pb=0.1013; %MPa 大気圧

% e = 17.4;
es = [1.5 2 2.5 5 10 15 20 30 40];

pes = [];
for idx=1:length(es)
    e = es(idx);
    epsilon = 1e-6;
    syms pe;
    num = ((k-1)/2)*(2/(k+1))^((k+1)/(k-1));
    den = (pe/Pc)^(2/k)-(pe/Pc)^((k+1)/k);
    f1(pe) = sqrt(num/den)-e;
    p1 = vpasolve(f1,pe);
    try
        p2 = vpasolve(f1,pe,[0 p1-epsilon]);
        if isempty(p2)
            p2 = vpasolve(f1, pe, [p1+epsilon Inf]);
        end
    catch
        p2 = vpasolve(f1, pe, [p1+epsilon Inf]);
    end
    pd = max(p1,p2);
    pj = min(p1,p2)
    pes(end+1) = real(pj);
end

pa = 0.1013; %[MPa] 背圧は大気圧
sigma_star = sqrt(k*(2/(k+1))^((k+1)/(k-1)));
pe = pes;
K = 2*k/(k-1);
a = sigma_star * sqrt(K*(1-(pe./Pc).^((k-1)/k)));
b1 = sqrt(K*(1-(pe./Pc).^((k-1)/k)));
b = sigma_star * (pe./Pc-pa/Pc)./((pe./Pc).^(1/k).*b1);
Cf1 = a + b;

plot(es,Cf1);
title('ノズル膨張比eと推力係数の関係（海面上）');
xlabel('ノズル膨張比 e=Ae/At');
ylabel('推力係数 Cf');
big;
grid;

figure();
pa = 0.0285; %[MPa] 高度10kmのときの圧力
sigma_star = sqrt(k*(2/(k+1))^((k+1)/(k-1)));
pe = pes;
K = 2*k/(k-1);
a = sigma_star * sqrt(K*(1-(pe./Pc).^((k-1)/k)));
b1 = sqrt(K*(1-(pe./Pc).^((k-1)/k)));
b = sigma_star * (pe./Pc-pa/Pc)./((pe./Pc).^(1/k).*b1);
Cf2 = a + b;

plot(es,Cf2);
title('ノズル膨張比eと推力係数の関係（高度10km: 285hPa）');
xlabel('ノズル膨張比 e=Ae/At');
ylabel('推力係数 Cf');
big;
grid;


figure();
pa = 0; %[MPa] 真空中
sigma_star = sqrt(k*(2/(k+1))^((k+1)/(k-1)));
pe = pes;
K = 2*k/(k-1);
a = sigma_star * sqrt(K*(1-(pe./Pc).^((k-1)/k)));
b1 = sqrt(K*(1-(pe./Pc).^((k-1)/k)));
b = sigma_star * (pe./Pc-pa/Pc)./((pe./Pc).^(1/k).*b1);
Cf3 = a + b;

plot(es,Cf3);
title('ノズル膨張比eと推力係数の関係（真空中）');
xlabel('ノズル膨張比 e=Ae/At');
ylabel('推力係数 Cf');
big;
grid;


figure();
plot(es,Cf1);
hold on;
plot(es,Cf2);
plot(es,Cf3);
title('ノズル膨張比eと推力係数の関係');
xlabel('ノズル膨張比 e=Ae/At');
ylabel('推力係数 Cf');
legend('海面上','高度10km','宇宙空間');
big;
grid;

