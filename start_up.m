clear; close all;

global grain; global burndata; global rho_p; 
global c_star; global Kn; 


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
ys=zeros(1,N);
ys(1)=0;
f = @(x,y) a*y;

for t = ts

end


%end

% plot(ts,Kns);
% fprintf('Pressure = %f[MPa]\n',c(k-1));
% fprintf('Kn = %f\n',Kn);
