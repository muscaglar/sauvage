function[c0]=charge_inversion_crossover(Z,cond)

%cond = cond * 0.16;
T = 290.5;
e = 1.6021766e-19;
K = 1.38064852e-23;
eps_0 = 8.8541878176e-12;
eps_DI = 80;

%Interaction Paramter: IP
IP1 = sqrt(abs(cond*(Z^3)*(e^3))/pi);
IP2 = 4*K*T*eps_0*eps_DI;
IP = IP1/IP2;

uc = -K*T*(1.65*IP-2.61*(IP^0.25)+0.26*log(IP)+1.95);

r_ion = 0.075;

c0 = abs(cond/(2*r_ion*Z*e)) * exp(uc/(K*T));

end