function Kn = get_Kn(r,t) 
  global L; global d; global A_t; global Kn;
  load_param;
  Ab = 2*pi*(d/2+r*t)*L;
  Kn = Ab / A_t;
end
