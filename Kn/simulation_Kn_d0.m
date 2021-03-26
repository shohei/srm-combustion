clear; close all;

d0s=[5,7.2,10,15]
for d0=d0s

% for BATES (Ballistic Test and Evaluation System) grain
N=1; % number of grain
D = 24; % [mm] initial grain outer diameter
% d0 = 7.2; % [mm] initial grain inner diameter
L0 = 40; % [mm] initial grain length
d = @(x) d0 + 2*x;
L = @(x) L0 - 2*x;
Ab = @(x) N*(1/2*pi*(D^2-d(x)^2)+pi*L(x)*d(x));

At = 5; % [mm]

Kn =@(x) Ab(x)/At;

Kns=[];
xs=[];
xmax=1/2*(D-d0)
Ndiv=50;
for x=linspace(0,xmax,Ndiv)
    xs(end+1)=x;
    Kns(end+1)=Kn(x);
end

plot(xs,Kns);
hold on;
end

title('BATES Kn Profile (D=24mm,L=40mm)');
xlabel('Web regression x');
ylabel('Kn');
legend(arrayfun(@(x) 'd0='+x+'[mm]', string(d0s)));
big;

Lopt = 1/2*(3*D+d0)


