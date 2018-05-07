%--------------------------------------------------------------------------
% This script convert the vector disease_list_bool of 5896*1 into
% disease_list_bool_mat with dimension of 5896*2. First column is 1 for
% normal and second column is 1 for abnormal, while other brackets are 0
% This operation is prepared for neural network output layer
%--------------------------------------------------------------------------

disease_list_bool_mat = zeros(size(disease_list_bool, 1), 2);
for i = 1:size(disease_list_bool, 1)
    if disease_list_bool(i) == 0
        disease_list_bool_mat(i, 1) = 1;
    else
        disease_list_bool_mat(i, 2) = 1;
    end
end
