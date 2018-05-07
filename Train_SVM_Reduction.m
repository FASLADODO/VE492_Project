%--------------------------------------------------------------------------
% This script use the dimension-reduced data to train SVM models
% The model use first 5000 data to train and left 896 data to test
%--------------------------------------------------------------------------

rng('shuffle');
% Please uncomment the following functions to choose the training
% method you want to apply. For the meaning of each function,
% please refer to MATLAB handbook
%--------------------------------------------------------------------------
% [Mdl,FitInfo] = fitclinear(gene_chip_reduction(1: 5000, :), disease_list_bool(1:5000, :))
%--------------------------------------------------------------------------
% Mdl = fitcsvm(gene_chip_reduction(1: 5000, :), disease_list_bool(1:5000, :), 'OptimizeHyperparameters','auto',...
%     'HyperparameterOptimizationOptions',struct('AcquisitionFunctionName',...
%     'expected-improvement-plus'))
%--------------------------------------------------------------------------
Mdl = fitcsvm(gene_chip_reduction(1: 5000, :), disease_list_bool(1:5000, :),  'OptimizeHyperparameters','auto',...
    'HyperparameterOptimizationOptions',struct('AcquisitionFunctionName',...
    'expected-improvement-plus'))
%--------------------------------------------------------------------------
%Mdl = fitcsvm(gene_chip_reduction(1:5000, :), disease_list_bool(1:5000, :))
%--------------------------------------------------------------------------
%Mdl = fitcsvm(gene_chip_reduction_90(1:5000, :), disease_list_bool(1:5000, :),...
%      'KernelFunction', 'polynomial', 'PolynomialOrder', 3)
%--------------------------------------------------------------------------

% Calculate the test accuracy
correct_num = 0;
for i = 1:896
    label_tmp = predict(Mdl, gene_chip_reduction(5000 + i, :));
    if label_tmp == disease_list_bool(5000 + i)
        correct_num = correct_num + 1;
    end
end

% Display the training result
disp([num2str(correct_num), ' from ', num2str(896), ' test samples are correct predicted.'])
disp(['Correct Rate is: ', num2str(correct_num/896*100), '%.']);

% Display the 3-dimension abstract figure of dataset
% gene_chip_3 = tsne(gene_chip_reduction_norm, 'Algorithm', 'barneshut', 'NumPCAComponents', 50, 'NumDimensions', 3);
% figure, scatter3(gene_chip_3(:,1), gene_chip_3(:,2), gene_chip_3(:,3), 15, disease_list_bool, 'filled');

% Plot the scatter figure the first three columns of the dimesnion-reduced data
figure, scatter3(gene_chip_reduction(:,1), gene_chip_reduction(:,2), gene_chip_reduction(:,3), 6, disease_list_bool, 'filled');
figure, scatter(gene_chip_reduction(:,1), gene_chip_reduction(:,2), 6, disease_list_bool, 'filled');
figure, scatter(gene_chip_reduction(:,1), gene_chip_reduction(:,3), 6, disease_list_bool, 'filled');
axis([-0.2 1.2, -0.2 1.2, -0.2 1.2]);
