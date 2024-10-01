This repository contains the R code required to conduct GBLUP analysis of biallelic SNP marker data in tetraploid potato. The results are published in:

Aalborg, T., Sverrisdóttir, E., Kristensen, H. T., & Nielsen, K. L. (2024). The Effect of Marker Types and Density on Genomic Prediction and GWAS of Key Performance Traits in Tetraploid Potato. Frontiers in Plant Science, 15(1340189). https://doi.org/10.3389/fpls.2024.1340189

Currently uploaded is the scripts required to construct the iterative marker reduction for the marker density analysis (the script in the Data/ folder) and conduct the GBLUP analysis using the BGLR package. One folder is required for each subset of the markers both for storing the data files and for conducting the analysis of each subset. For each subset a new GRM is calculate and 8-fold CV GBLUP is performed in 10 repeats for each analyzed trait. The traits include chipping quality (GIC), dry matter content (TP2), starch content (SP2), senescence (NDV), yield (UU2), and length/wdith ratio (LW).

The files also include scripts for combining data in preparation for plotting and post-hoc analyses as well as a master script for running all GS models for each marker subset. 

The marker and phenotype data the analysis is based on is publicly available in the Zenodo repository: 10.5281/zenodo.10143576.
