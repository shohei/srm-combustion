clear; close all; clc;
syms pe;
% k = 1.177; %Propep 3での計算値(KNSB) ストイキ
% Pc = 1.31; %[MPa] Nakkaのグラフの値。OpenMotorでも同様の値(KNSB)。
% rstar = 12; %mm
%re = 50; %mm
% re = 25; %mm
% e = 17
% Astar = pi*rstar^2;
% Ae = pi*re^2;
% pb = 0.1013; %[MPa] 背圧は大気圧

fprintf('***入力パラメータ***\n');
Pc = input('燃焼室圧力 Pc [Mpa]: ');
e = input('ノズル開口比 e=Ae/At: ');
k = input('比熱比 k: ');
pb = input('背圧 pb [MPa] (デフォルト=大気圧: 0.1013MPa): ');
if isempty(pb)
  pb = 0.1013;
end

epsilon = 1e-6;
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
pj = min(p1,p2);
fprintf('***計算結果***\n');
fprintf('最初にチョークするときの背圧 Pd: %.3f[MPa]\n',pd)
fprintf('適正膨張するときの背圧 Pj: %.3f[MPa]\n',pj)

syms M2;
M1 = 1; %M1はチョークしている
f2(M2) = M1/M2*((((k-1)*M2^2+2))/((k-1)*M1^2+2))^((k+1)/(2*(k-1)))-e; %(4.37)式
Me = vpasolve(f2,M2,[0 Inf]); 
Me = max(Me);
fprintf('ちょうど出口に衝撃波が発生する場合の、出口でのマッハ数 Me: %.2f\n',Me);

ph = Pc*((2*(k-1)*Me^2-(k-1))/(k+1))*(1+(k-1)/2*Me^2)^(-k/(k-1));
fprintf('出口で衝撃波が発生する場合の、出口の圧力 ph: %.3f[MPa]\n',ph);

disp('***ノズルの設計について***');
if pb<pj
    disp('不足膨張');
elseif pb<ph && pb>pj
    disp('過膨張');
elseif pb>ph &&  pb<pd
    disp('ラバルノズル内部に衝撃波が発生→ノズルとして機能せず');
elseif pb>pd
    disp('ベンチュリノズル→亜音速ノズル');
end

