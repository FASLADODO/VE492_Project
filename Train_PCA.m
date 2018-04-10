[coeff, score, latent, tsquared, explained, mu] = pca(gene_chip);

latent_rate = cumsum(latent)./sum(latent);
for reduction_count = 1 : size(latent_rate, 1)
    if latent_rate(reduction_count) > 0.95
        break;
    end
end

gene_chip_reduction = score(:, 1: reduction_count);


