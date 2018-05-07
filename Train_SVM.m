%--------------------------------------------------------------------------
% This script will give the wrong result due to the high dimension
% of dataset, please don't apply the result by this script
%--------------------------------------------------------------------------

% Use the origin dataset without dimension-reduction to train SVM
rng('shuffle');
%[Mdl,FitInfo] = fitclinear(gene_chip(1: 5000, :), disease_list_bool(1:5000, :), 'Regularization','lasso')
Mdl = fitcsvm(gene_chip(1: 5000, :), disease_list_bool(1:5000, :))

% Calculate the test accuracy
correct_num = 0;
for i = 1:896
    label_tmp = predict(Mdl, gene_chip(5000 + i, :));
    if label_tmp == disease_list_bool(5000 + i)
        correct_num = correct_num + 1;
    end 
end

% Output the result
disp([num2str(correct_num), ' from ', num2str(896), ' test samples are correct predicted.'])
disp(['Correct Rate is: ', num2str(correct_num/896*100), '%.']);