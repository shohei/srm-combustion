clear; close all;

L0s=[20,40,60,80];
for L0=L0s
% for BATES (Ballistic Test and Evaluation System) grain
N=1; % number of grain
D = 24; % [mm] initial grain outer diameter
d0 = 7.2; % [mm] initial grain inner diameter
% L0 = 40; % [mm] initial grain length
d = @(x) d0 + 2*x;
L = @(x) L0 - 2*x;
Ab = @(x) N*(1/2*pi*(D^2-d(x)^2)+pi*L(x)*d(x));

At = 5; % [mm]

Kn =@(x) Ab(x)/At;

Kns=[];
xs=[];
xmax=1/2*(D-d0);
Ndiv=50;
for x=linspace(0,xmax,Ndiv)
    xs(end+1)=x;
    Kns(end+1)=Kn(x);
end

plot(xs,Kns);
hold on;
end

title('BATES Kn Profile (D=24mm,d=7.2mm)');
xlabel('Web regression x');
ylabel('Kn');
legend(arrayfun(@(x) 'L='+x+'[mm]', string(L0s)));
big;

Lopt = 1/2*(3*D+d0)


