gene_num = 22283;
sample_num = 5896;

gene_chip = zeros(gene_num, sample_num);

fid = fopen('microarray.original.txt');

tmp = fgetl(fid);

for i = 1:gene_num
    tmp = fgetl(fid);
    tmp = str2num(tmp);
    gene_chip(i,:) = tmp(1, 2:sample_num+1);
    if mod(i, 100) == 0
        disp([num2str(i/22283 * 100), '%']);
    end
end

fclose(fid);