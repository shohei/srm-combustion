function Kn = get_Kn(r,t) 
  load_param;
  Ab = 2*pi*(d/2+r*t)*L;
  Kn = Ab / A_t;
end
