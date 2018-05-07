# VE492_Project

## Introduction

This is my machine learning project on database of gene chips.

You can find database here https://www.ebi.ac.uk/arrayexpress/experiments/E-TABM-185/

Both classical machine learning methods and deep learning methods are applied to this dataset.

Classical methods: SVM, logistic regression, KNN, LDA

Deep learning: fully-connected NN

Classical methods can reach the highest performance on binary classification task(normal-abnomral) of 93.7%  and deep learning methods can reach 95.8% for that number.



## How to use the codes

To apply the MATLAB codes, you need MathWorks Statistics and Machine Learning Toolbox for classical methods and MathWorks Neural Network Toolbox for deep learning methods on MATLAB.

Please first drag label data file directly into the workspace and import that data, hopefully its name should be ETABM185 automatically, then run the scripts in the following sequence.

Data preparation:

1. Chip_Data_Read.m
2. Label_Data_Read.m
3. Mat_Convert.m
4. Data_random.m
5. Train_PCA.m

Model training and evaluation

6. Train_SVM_Reduction.m
7. Train_SVM_Cubic_200.m
8. Train_NN_four_layers.m
9. Train_NN_200.m
10. PCA_plot.m