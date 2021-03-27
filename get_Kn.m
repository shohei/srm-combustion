function Kn_ans = get_Kn(r,t) 
  global A_t; global N; global Kn;
  global D0; global d0; global L0;
  load_param;
  x = r*t;
  d = d0 + 2*x;
  L = L0 - 2*x;
  Ab = N*(1/2*pi*(D0^2-d^2)+pi*L*d);
  Kn_ans = Ab / A_t;
  Kn = Kn_ans;
end