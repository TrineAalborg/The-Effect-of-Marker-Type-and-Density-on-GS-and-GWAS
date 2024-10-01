#!/usr/bin/env Rscript
# Script: Run complete script path - 
# TRAA September 2023

# subjects (for training): MASPOT
# variants: ssnp_0
# Trait: CIC + SP2 + UU2 + TP2 + LW + NDV
# Model: GBLUP

###### Set working directory ######
setwd("/MASPOT/GS")
rm(list = ls())

# Dependency packages are loaded in their respective scripts

# Dependency: the CV lists prepared in 02_CV_8fold.R # the same CV lists are used for all ssnp predictions

###### Prep genotype and phenotype data and make GRM ######

source("Models/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/01_Make_GRM.R")

###### Train GBLUP models for each 10 repeat CV groups and save prediction data ######

source("Models/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/MASPOT_GBLUP_CV8fold_sixtrait_CV01.R")
source("Models/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/MASPOT_GBLUP_CV8fold_sixtrait_CV02.R")
source("Models/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/MASPOT_GBLUP_CV8fold_sixtrait_CV03.R")
source("Models/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/MASPOT_GBLUP_CV8fold_sixtrait_CV04.R")
source("Models/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/MASPOT_GBLUP_CV8fold_sixtrait_CV05.R")
source("Models/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/MASPOT_GBLUP_CV8fold_sixtrait_CV06.R")
source("Models/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/MASPOT_GBLUP_CV8fold_sixtrait_CV07.R")
source("Models/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/MASPOT_GBLUP_CV8fold_sixtrait_CV08.R")
source("Models/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/MASPOT_GBLUP_CV8fold_sixtrait_CV09.R")
source("Models/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/MASPOT_GBLUP_CV8fold_sixtrait_CV10.R")

###### Combine prediction data for all CV repeats and plot results ######

source("Models/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/MASPOT_GBLUP_CV8fold_GIC_Combinedata.R")
source("Models/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/MASPOT_GBLUP_CV8fold_SP2_Combinedata.R")
source("Models/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/MASPOT_GBLUP_CV8fold_TP2_Combinedata.R")
source("Models/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/MASPOT_GBLUP_CV8fold_UU2_Combinedata.R")
source("Models/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/MASPOT_GBLUP_CV8fold_LW_Combinedata.R")
source("Models/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/MASPOT_GBLUP_CV8fold_NDV_Combinedata.R")

source("Models/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/Combine_data_allphenotypes.R")

#
