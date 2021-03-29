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

ts=0.1:0.1:2;

for t = ts
% t = 0.1; %[s] :決め打ち
%f(p)=0となるpを2分法で求める

lower_limit = 0.2; %Mpa -> 1気圧より高い値
upper_limit = 2; %MPa -> 燃焼圧は20気圧におさまるはず
division = 100;

% すべてMKS単位系に直して計算する
f = @(p) p*1e6 - get_Kn(get_r(p),t) * (rho_p*1e3) * (get_r(p)*1e-3) * c_star;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% デバッグ用 識別関数fのプロット
% fs=[];
% xs=linspace(lower_limit,upper_limit,division);
% for idx=1:length(xs)
%    x=xs(idx);
%    fs(end+1)=f(x);
% end
% plot(xs,fs);
% hold on;
% plot(xs,zeros(size(xs)));
% title('識別関数 f(x)=0');
% big;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a(1)=lower_limit;
b(1)=upper_limit;
c=zeros(1,division);

k=2;
delta=1e-10;
epsilon=0.5e-5;
res1=1e4;
res2=1e4;
while res1>delta && res2>epsilon
  c(k)=1/2*(a(k-1)+b(k-1));
  check = f(a(k-1))*f(c(k));
  if check<0
    a(k) = a(k-1);
    b(k) = c(k);
  else 
    a(k) = c(k);
    b(k) = b(k-1);  
  end
  res1=abs(f(c(k)));
  res2=abs(a(k-1)-b(k-1));
  k = k+1;
  %disp(res2);
end

Ps(end+1)=c(k-1);
Kns(end+1)=Kn;

end

plot(ts,Ps);
hold on;
title('Pressure over time');
xlabel('Time [sec]');
ylabel('Pressure [MPa]');
big;

%end

legend(grain_names);

% plot(ts,Kns);
% fprintf('Pressure = %f[MPa]\n',c(k-1));
% fprintf('Kn = %f\n',Kn);
