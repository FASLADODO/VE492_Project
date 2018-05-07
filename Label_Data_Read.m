%--------------------------
% Read and parse label data
%--------------------------

% Read the sample numbers and initialize the variables
sample_num = size(ETABM185, 1) - 1;
disease_list_num = zeros(sample_num,1);
disease_list_string = table2array(ETABM185(2:sample_num+1, 8));
disease_name_list = ['normal'];

% Read the disease states, number each of them
% disease_list_num: number label of each disease state
% disease_list_string: name of each disease state
for i = 1:sample_num
    if isundefined(disease_list_string(i))
        disease_list_num(i) = 0;
    elseif disease_list_string(i) == "normal" || disease_list_string(i) == "healthy"
            disease_list_num(i) = 1;
    else
        if isempty(find(disease_name_list == disease_list_string(i), 1))
            disease_name_list = [disease_name_list, disease_list_string(i)];
            disease_list_num(i) = find(disease_name_list == disease_list_string(i));
        else
            disease_list_num(i) = find(disease_name_list == disease_list_string(i));  
        end
    end
end

% Separate disease states into 0(normal and healthy)
% and 1(other disease states)
% disease_list_bool: normal-abnormal state for each sample
disease_list_bool = zeros(sample_num, 1);
for i = 1:sample_num
    if disease_list_num(i) ~= 0 && disease_list_num(i) ~= 1
        disease_list_bool(i) = 1;
    end
end

disease_name_list = disease_name_list';