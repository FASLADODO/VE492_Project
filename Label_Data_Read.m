% Read and parse label data
sample_num = size(ETABM185, 1) - 1;
disease_list_num = zeros(sample_num,1);
disease_list_string = table2array(ETABM185(2:sample_num+1, 8));
disease_name_list = ['normal'];

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

disease_list_bool = zeros(sample_num, 1);
for i = 1:sample_num
    if disease_list_num(i) ~= 0 && disease_list_num(i) ~= 1
        disease_list_bool(i) = 1;
    end
end

disease_name_list = disease_name_list';