global grain;
global k; global c_star; global rho_p;
global L0; global d0; global A_t; global N; global D0; 
global R; global T_0;

% Load parameters (KNSU, KNDX, KNSB)
params=grain;

% number of grains
N=1;

% Characteristic velocity
k = params.k; 
R0 = params.Rbar; %J/kmol-K
M = params.M; %kg/mol
R = R0/M; % J/kmol-K
T_0 = params.To ; %[K] 
c_star = sqrt(R*T_0/(k*(2/(k+1))^((k+1)/(k-1))));

% Density
rho_o = params.rho_o; %KNO3
rho_f = params.rho_f;
f_o = 0.65; % 65% of oxidizer
f_f = 0.35; % 35% of fuel
rho_p = 1/(f_o/rho_o+f_f/rho_f); %Unit: g/cm3 or kg/mm3 (same value)

% Motor dimension (BATES)
D0 = 24; %mm
d0 = 7.2; %mm
L0 = 30; %mm

% Nozzle dimension
D_t = 5; %nozzle throat diameter [mm]
A_t = pi*D_t^2/4;
D_e = 5; %nozzle exit diameter [mm] 
A_e = pi*D_e^2/4;

