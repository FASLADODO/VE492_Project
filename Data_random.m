% These are data parsed for tensorflow
% Randomize data with 95% accuracy
num = 1271;
random_data = [gene_chip_reduction_norm, disease_list_bool_mat];
tmp = randperm(size(disease_list_bool_mat, 1));
random_data = random_data(tmp, :);

disease_list_bool_mat_random = random_data(:, num+1:num+2);
gene_chip_reduction_norm_random = random_data(:, 1:num);

% Randomize data with 200 coloum
num = 200;
random_data_200 = [gene_chip_reduction_200_norm, disease_list_bool_mat];
tmp = randperm(size(disease_list_bool_mat, 1));
random_data = random_data_200(tmp, :);

disease_list_bool_mat_random_200 = random_data(:, num+1:num+2);
gene_chip_reduction_norm_random_200 = random_data(:, 1:num);


% These are data parsed for matlab classification learner
random_data_200_app = [gene_chip_reduction_200_norm, disease_list_bool];

gene_chip_app = [gene_chip, disease_list_bool];     

% Randomize data with 100% accuracy
num = 22283;
random_data_all = [gene_chip_reduction_norm, disease_list_bool];
tmp = randperm(size(disease_list_bool_mat, 1));
random_data_all = random_data(tmp, :);