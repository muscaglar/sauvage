function [a_vOffs,error_pos_a_vOffs,error_neg_a_vOffs, a_cOffs,error_pos_a_cOffs,error_neg_a_cOffs,a_cConcs,a_rConcs] = ae_part_selectivity(rConcs,cConcs, vOffs, cOffs)

unique_rConc = unique(rConcs);

for i = 1:size(unique_rConc,2)
    index_rConc = rConcs == unique_rConc(i);
    a_vOffs(i) = mean(vOffs(index_rConc),2);
    error_pos_a_vOffs(i) = a_vOffs(i) - max(vOffs(index_rConc));
    error_neg_a_vOffs(i) = a_vOffs(i) - min(vOffs(index_rConc));
    a_cOffs(i) = mean(cOffs(index_rConc),2);
    error_pos_a_cOffs(i) = a_cOffs(i) - max(cOffs(index_rConc));
    error_neg_a_cOffs(i) = a_cOffs(i) - min(cOffs(index_rConc));
    a_cConcs(i) = mean(cConcs(index_rConc),2);
    a_rConcs(i) = unique_rConc(i);
end

end