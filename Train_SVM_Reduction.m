rng('shuffle');
%[Mdl,FitInfo] = fitclinear(gene_chip_reduction(1: 5000, :), disease_list_bool(1:5000, :))
%Mdl = fitcsvm(gene_chip_reduction(1: 5000, :), disease_list_bool(1:5000, :), 'OptimizeHyperparameters','auto',...
%    'HyperparameterOptimizationOptions',struct('AcquisitionFunctionName',...
%    'expected-improvement-plus'))

Mdl = fitcsvm(gene_chip_reduction(1: 5000, :), disease_list_bool(1:5000, :),  'OptimizeHyperparameters','auto',...
    'HyperparameterOptimizationOptions',struct('AcquisitionFunctionName',...
    'expected-improvement-plus'))

Mdl = fitcsvm(gene_chip_reduction(1:5000, :), disease_list_bool(1:5000, :))

%Mdl = fitcsvm(gene_chip_reduction_90(1:5000, :), disease_list_bool(1:5000, :), 'KernelFunction', 'polynomial', 'PolynomialOrder', 3)

correct_num = 0;
for i = 1:896
    label_tmp = predict(Mdl, gene_chip_reduction(5000 + i, :));
    if label_tmp == disease_list_bool(5000 + i)
        correct_num = correct_num + 1;
    end
end

disp([num2str(correct_num), ' from ', num2str(896), ' test samples are correct predicted.'])
disp(['Correct Rate is: ', num2str(correct_num/896*100), '%.']);

%ene_chip_3 = tsne(gene_chip_reduction_norm, 'Algorithm', 'barneshut', 'NumPCAComponents', 50, 'NumDimensions', 3);
figure
scatter3(gene_chip_reduction(:,1), gene_chip_reduction(:,2), gene_chip_reduction(:,3), 6, disease_list_bool, 'filled');
scatter(gene_chip_reduction(:,1), gene_chip_reduction(:,2), 6, disease_list_bool, 'filled');
scatter(gene_chip_reduction(:,1), gene_chip_reduction(:,3), 6, disease_list_bool, 'filled');
axis([-0.2 1.2, -0.2 1.2, -0.2 1.2]);
figure
scatter(gene_chip_reduction_norm(:,1), gene_chip_reduction_norm(:,2), 6, disease_list_bool, 'filled');
%scatter3(gene_chip_3(:,1), gene_chip_3(:,2), gene_chip_3(:,3), 15, disease_list_bool, 'filled');
