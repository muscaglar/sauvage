function [I,V] = cae_conductance_offsets(cIDs, p)

%This will correct the zero point (c), average expeirments (a), provide an
%error (e)

%Output will be cae conductance and voltage and current offsets


%This function will combine all given capillaries into a single data set.
[~, ~, ~, ~, rConcs,cConcs, vOffs, cOffs, ~, ~ ] = c_selectivity(cIDs,0);

%average and generate error from above
[a_vOffs,error_pos_a_vOffs,error_neg_a_vOffs, a_cOffs,error_pos_a_cOffs,error_neg_a_cOffs,a_cConcs,a_rConcs] = ae_part_selectivity(rConcs,cConcs, vOffs, cOffs);

%generate linear approx
g = [];
c = [];

lower_g_error = [];
upper_g_error = [];

V = -100:10:100;
I = {};

for i = 1:1:size(a_vOffs,2)
    c(i) = a_cOffs(i);
    g(i) = -(a_cOffs(i)/a_vOffs(i));
    
    g_neg(i) = -( (a_cOffs(i)- error_neg_a_cOffs(i))/(a_vOffs(i)));
    g_pos(i) = -( (a_cOffs(i)- error_pos_a_cOffs(i))/(a_vOffs(i)));
    g__pos(i) = -( (a_cOffs(i))/(a_vOffs(i)- error_pos_a_vOffs(i)));
    g__neg(i) = -( (a_cOffs(i))/(a_vOffs(i)- error_neg_a_vOffs(i)));
    
    upper_g_error(i) = ((g_pos(i)+g__pos(i))/2)-g(i);
    lower_g_error(i) = ((g_neg(i)+g__neg(i))/2)-g(i);
    
    I{i} = (V .* g(i)) + c(i);
    if(p)
        hold on;
        plot(V,I{i});
    end
end

r = 1 ./ g;

 scatter(log10(a_rConcs),g);
 hold on;
errorbar(log10(a_rConcs),g, lower_g_error,upper_g_error, 'LineStyle','none');

end