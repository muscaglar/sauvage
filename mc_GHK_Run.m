x = [-500:10:500];
x=x*1e-3;
j=1;
y=[];
for i = x
    y(j) = mc_GHK_Generate_I(i);
    j=j+1;
end

plot(x,y)