clear; close all;

load_param;
global burndata;
burndata = readtable('./data/knsu.csv');

t = 1; %[s] :決め打ち
%f(p)=0となるpを2分法で求める
f = @(p) p - get_Kn(get_r(p),t) * rho_p * get_r(p) * c_star;
fs=[];
xs=1:0.1:10;
for idx=1:length(xs)
   x=xs(idx);
   fs(end+1)=f(x);
end
plot(xs,fs);

a(1)=1;
b(1)=9;
c=zeros(1,100);

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
fprintf('ans\n = %d\n',c(k-1));
