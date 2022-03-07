clear; close all; clc;
syms pe;
k = 1.164; %Propep 3での計算値(KNSB) ストイキ
% k = 1.4; 
% Pc = 6.89476; %[MPa] Propep 3での計算値(KNSB) ストイキ
Pc = 1.31; %[MPa] Nakkaのグラフの値。OpenMotorでも同様の値(KNSB)。
num = ((k-1)/2)*(2/(k+1))^((k+1)/(k-1));
den = (pe/Pc)^(2/k)-(pe/Pc)^((k+1)/k);
rstar = 12; %mm
re = 50; %mm
Astar = pi*rstar^2;
Ae = pi*re^2;

fprintf('***前提条件***\n');
fprintf('燃焼室圧力 Pc: %.2f[MPa]\n',Pc);
fprintf('ノズル開口比 Ae/A*: %.2f\n',Ae/Astar);
fprintf('比熱比 k: %.2f\n',k);
fprintf('背圧=大気圧 pa: %.3f[MPa]\n',0.1013);

f(pe) = sqrt(num/den)-Ae/Astar;
pd = vpasolve(f,pe);
pj = vpasolve(f,pe,[0,pd-0.1]);
fprintf('***計算結果***\n');
fprintf('最初にチョークするときの背圧 Pd: %.3f[MPa]\n',pd)
fprintf('適正膨張するときの背圧 Pj: %.3f[MPa]\n',pj)

syms M2;
M1 = 1; %M1はチョークしている
f(M2) = M1/M2*((((k-1)*M2^2+2))/((k-1)*M1^2+2))^((k+1)/(2*(k-1)))-Ae/Astar; %(4.37)式
Me = vpasolve(f,M2); 
fprintf('ちょうど出口に衝撃波が発生する場合の、出口でのマッハ数 Me: %.2f\n',Me);

ph = Pc*((2*(k-1)*Me^2-(k-1))/(k+1))*(1+(k-1)/2*Me^2)^(-k/(k-1));
fprintf('出口で衝撃波が発生する場合の、出口の圧力 ph: %.3f[MPa]\n',ph);




