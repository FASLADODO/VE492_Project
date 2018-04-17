import scipy.io as sio
import numpy as np

data_disease_list_bool = sio.loadmat('disease_list_bool.mat')
data_gene_chip_reduction = sio.loadmat('gene_chip_reduction.mat')
disease_list_bool = data_disease_list_bool['disease_list_bool']
gene_chip_reduction = data_gene_chip_reduction['gene_chip_reduction']
print(disease_list_bool.dtype)
#print(gene_chip_reduction)
#print(disease_list_bool)