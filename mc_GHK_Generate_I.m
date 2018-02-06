function [I ] = mc_GHK_Generate_I( v )

n=0.8034; %viscosity
a=280e-12; %radius of ion
f=6*pi*n*a;
kb=1.38064852e-23; %boltman
z=1; %valency
F=9.64853399e4; %Farday
R=8.3144621; %
D=kb/f;
ci=1;
ce=0.001;
%v=59e-3;
L=0.34e-9;
T=300;

I=(D*z*z*F*F*v*(ci-(ce*exp(-z*v*F/R*T))))/(L*R*(1-exp(-z*v*F/R*T)));

end