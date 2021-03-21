clear; close all;

%SRM関連定数
% definition of SRM
% BATES
D = 30; %mm
d = 10; %mm
L = 50; %mm
m_grain = 50e-3; % 50g
v_grain = pi/4*(D^2-d^2)*L; %mm3
rho_p = m_grain / v_grain; %kg/mm3

%気体関連定数
% http://www.nakka-rocketry.net/techs.html
%k = 1.4;% 2原子理想気体
k = 1.133; 
R0 = 8314; %J/kmol-K
M = 41.98; %kg/mol
h = 1;
o = 16;
c = 12;
n = 14;
K = 39;
co2 = c+o*2;
co = c+o;
h2o = h*2+o;
h2 = h*2;
n2  = n*2;
k2co3 = K*2+c+o*3;
koh = K+o+h;
c12h22o11 = c*12+h*22+o*11;
kno3 = K+n+o*3;
denominator = 3.8+5.21+7.79+3.07+3.14+3+0.27;
% M = 1/denominator*(3.8*co2+5.21*co+7.79*h2o+3.07*h2+3.14*n2+3*k2co3+0.27*koh);
% この場合のM=37.1568 実際はもう少し大きい値（~42）になる
R = R0/M;
% T_0: combustion temperature;
% received from following article.
% https://dare.tudelft.nl/2019/03/msc-thesis-on-kno3-sugar-propellants/
%T_0 = 1600; % [K]
T_0 = 1720 ; %[K] Nakkaの値

%ノズル関連定数
D_t = 11.14; %nozzle throat diameter [mm]
A_t = pi*D_t^2/4;
D_e = 31.51; %nozzle exit diameter [mm] 
A_e = pi*D_e^2/4;

% transient start-up
a = @(t) r*t;
Ab = 2*pi*a*L;
v0 = 2*pi*L*(d+a);%instantaneous gas volume [mm3]; チャンバー内に存在する空隙→増える
V_reacted = 2*pi*L*(r*t-d);%反応した固体燃料の体積
M_reactant = 1/7.29*(c12h22o11+6.29*kno3); %kg/mol
m_reacted = V_reacted * rho_p; %kg
N_reacted = m_reacted/M_reactant; %反応モル数→反応体積からグルコース+KNO3のモル数を割り出す
rho_0 = M*N_reacted/v0;% instantaneous gas density [kg/mm3]; M(平均分子量)*モル数/v0
C1 = Ab*a*(rho_p-rho_0); %tの関数
C2 = A_t*sqrt(k/(R*T0))*(2/(k+1))^((k+1)/(2*(k-1))); %定数
%圧力指数 (pressure exponent): 
n = ; %定数：de Saint-Robert則 (KNSU??)
n = ; %MESA: KNSB
n = ; %PLATEAU: KNDX
[t,p]=ode45(@(t,p) R*T0/v0*(C1(t)*p^n-p*C2), [0 3], 0);

% steady_state 
c_star = sqrt(R*T_0/(k*(2/(k+1))^((k+1)/(k-1))));
r = 3.6; %[mm/s] burn rate. Obtained: https://www.nakka-rocketry.net/burnrate.html 
Ab = 2*pi*r*t*L;
Kn = Ab / A_t;
p = Kn * rho_p * c_star;




tail_off = Pb0 * exp(R*T0*A_star/(v0*c_star)*t);




