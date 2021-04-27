clear; close all;

global grain; global burndata; global rho_p; 
global c_star; global Kn; 
global R; % R depends on each gas
global T_0;

grain_names = ["knsu","kndx","knsb"];

%for grain_name = grain_names
grain_name = 'knsu';
% grain_name = 'kndx';
% grain_name = 'knsb';
grain = readtable(strcat('./parameter/',grain_name,'.csv'));
burndata = readtable(strcat('./data/',grain_name,'.csv'));

Ps=[];
Kns=[];

time_start=0;
time_end=1;
N=20;
h=(time_end-time_start)/N;
ts=linspace(time_start,time_end,N);
ps=zeros(1,N);
ps(1)=0;

% MKS単位系になおして計算する
x = @(p,t) get_r(p)*1e-3*t; %web regress
v_0 = @(p,t) 2*pi*D0^2*x(p,t)+pi*(d0+2*x(p,t))*(L0-2*x(p,t)); %gas volume
dpdt = @(p,t) R*T_0/v_0(p*1e6,t)*...
            ( get_Ab(r,t)*get_r(p*1e6)*(rho_p-p*1e6/(R*T_0)) - p*1e6*A_t/c_star );

f = @(p) p*1e6 - get_Kn(get_r(p),t) * (rho_p*1e3) * (get_r(p)*1e-3) * c_star;

        
for t = ts

end


%end

% plot(ts,Kns);
% fprintf('Pressure = %f[MPa]\n',c(k-1));
% fprintf('Kn = %f\n',Kn);
