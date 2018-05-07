%--------------------------------------------------------------------------
% Apply PCA to the original microarray data, reduce dimension to
% variance of 95%, 90% and with dimension of 200
%--------------------------------------------------------------------------

% data normalization
% gene_chip_norm = mapminmax(gene_chip, -1, 1);
gene_chip_norm = zscore(gene_chip);

% PCA dimension reduction
[coeff, score, latent, tsquared, explained, mu] = pca(gene_chip);

% Get number of dimensions with different variance percentage
latent_rate = cumsum(latent)./sum(latent);

% variance = 95%
for reduction_count = 1 : size(latent_rate, 1)
    if latent_rate(reduction_count) > 0.95
        break;
    end
end

% variance = 90%
for reduction_count_90 = 1 : size(latent_rate, 1)
    if latent_rate(reduction_count_90) > 0.9
        break;
    end
end

%variance = 85%
for reduction_count_85 = 1 : size(latent_rate, 1)
    if latent_rate(reduction_count_85) > 0.85
        break;
    end
end

% get the training data with variance = 95%
gene_chip_reduction = score(:, 1: reduction_count);
gene_chip_reduction_200 = score(:, 1: 200);

% get the training data with variance = 90%
gene_chip_reduction_90 = score(:, 1: reduction_count_90);

% data normalization
gene_chip_reduction_norm = zscore(gene_chip_reduction);
gene_chip_reduction_200_norm = zscore(gene_chip_reduction_200);
