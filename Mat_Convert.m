disease_list_bool_mat = zeros(size(disease_list_bool, 1), 2);
for i = 1:size(disease_list_bool, 1)
    if disease_list_bool(i) == 0
        disease_list_bool_mat(i, 1) = 1;
    else
        disease_list_bool_mat(i, 2) = 1;
    end
end

% [m, n] = size(gene_chip_reduction);
% for i = 1:n
%     A(1, i) = norm(gene_chip_reduction(:, i));
% end
% A = repmat(A, m, 1);
% gene_chip_reduction_norm = gene_chip_reduction./A;

gene_chip_reduction_norm = zscore(gene_chip_reduction);
        