gene_chip_norm = mapminmax(gene_chip, 0, 1);

[coeff, score, latent, tsquared, explained, mu] = pca(gene_chip);

latent_rate = cumsum(latent)./sum(latent);
for reduction_count = 1 : size(latent_rate, 1)
    if latent_rate(reduction_count) > 0.95
        break;
    end
end

gene_chip_reduction = score(:, 1: reduction_count);
gene_chip_reduction_200 = score(:, 1: 200);


gene_chip_reduction_norm = mapminmax(gene_chip_reduction, 0, 1);
gene_chip_reduction_200_norm = mapminmax(gene_chip_reduction_200, 0, 1);
