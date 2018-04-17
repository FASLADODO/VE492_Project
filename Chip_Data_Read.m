% Reading microarray.origin.txt
gene_num = 22283;
sample_num = 5896;

% Initialize the matrix
gene_chip = zeros(gene_num, sample_num);

fid = fopen('Gene_Chip_Data/microarray.original.txt');

% The first line contains gene labels
tmp = fgetl(fid);

% From the second line, each line represents a sample
disp("Start loading data");
for i = 1:gene_num
    tmp = fgetl(fid);
    tmp = str2num(tmp);
    gene_chip(i,:) = tmp(1, 2:sample_num+1);
    if mod(i, 100) == 0
        disp([num2str(i/22283 * 100), '%']);
    end
end

gene_chip = gene_chip';
disp("Loading finished");

fclose(fid);