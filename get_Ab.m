function A_b = get_Ab(r,t) 
  global A_t; global N; global Kn;
  global D0; global d0; global L0;
  load_param;
  x = r*t;
  d = d0 + 2*x;
  L = L0 - 2*x;
  A_b = N*(1/2*pi*(D0^2-d^2)+pi*L*d);
end