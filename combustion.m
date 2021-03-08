clear; close all;

%SRM関連定数
% definition of SRM
% BATES
D = 30;
d = 10;
L = 50;
m_grain = 50e-3; % 50g
v_grain = pi/4*(D^2-d^2)*L;
rho_p = m_grain / v_grain;

%気体関連定数
% http://www.nakka-rocketry.net/techs.html
%k = 1.4;% 2原子理想気体
k = 1.133; 
R0 = 8314; %J/kmol-K
M = 41.98; %kg/mol
% h = 1;
% o = 16;
% c = 12;
% n = 14;
% K = 39;
% co2 = c+o*2;
% co = c+o;
% h2o = h*2+o;
% h2 = h*2;
% n2  = n*2;
% k2co3 = K*2+c+o*3;
% koh = K+o+h;
% denominator = 3.8+5.21+7.79+3.07+3.14+3+0.27;
% M = 1/denominator*(3.8*co2+5.21*co+7.79*h2o+3.07*h2+3.14*n2+3*k2co3+0.27*koh);
% この場合のM=37.1568 実際はもう少し大きい値（~42）になる
R = R0/M;
% T_0: combustion temperature;
% received from following article.
% https://dare.tudelft.nl/2019/03/msc-thesis-on-kno3-sugar-propellants/
%T_0 = 1600; % [K]
T_0 = 1720 ; %[K] Nakkaの値

% transient start-up
D_t = ; %nozzle diameter
A_t = pi*D_t^2/4


% steady_state 
c_star = sqrt(R*T_0/(k*(2/(k+1))^((k+1)/(k-1))));
Kn = Ab / A_t;
p = Kn * rho_p * c_star;




tail_off = Pb0 * exp(R*T0*A_star/(v0*c_star)*t);




