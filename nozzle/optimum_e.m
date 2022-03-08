clear; close all; clc;

k = 1.177; %Propep 3での計算値(KNSB) ストイキ
Pc = 1.31; %[MPa] Nakkaのグラフの値。OpenMotorでも同様の値(KNSB)。
pe = 0.1013; %[MPa] 背圧は大気圧

Astar_Ae = ((k+1)/2)^(1/(k-1))*(pe/Pc)^(1/k)*sqrt((k+1)/(k-1)*(1-(pe/Pc)^((k-1)/k)));
e = 1/Astar_Ae;
fprintf('海面上での最適膨張比 e: %.2f\n',e);



