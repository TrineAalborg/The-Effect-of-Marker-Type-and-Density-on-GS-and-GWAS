#!/usr/bin/env Rscript
###### script: run all ssnp_2binlevelsubsetting ######
# TRAA September 2023

# Subjects: MASPOT
# Variants: ssnps

###### Set working directory ######

setwd("/home/bio.aau.dk/vm82rp/MASPOT/GS")
rm(list = ls())

###### Run scripts and save errors in log and closing open connections to save memory ######
script_files <- c("Models/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/MASPOT_GBLUP_CV8fold_sixtrait_RunCompleteModel.R",
                  "Models/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_1/MASPOT_GBLUP_CV8fold_sixtrait_RunCompleteModel.R",
                  "Models/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_1.2_1/MASPOT_GBLUP_CV8fold_sixtrait_RunCompleteModel.R",
                  "Models/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_1.2_1.3_1/MASPOT_GBLUP_CV8fold_sixtrait_RunCompleteModel.R",
                  "Models/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_1.2_1.3_1.4_1/MASPOT_GBLUP_CV8fold_sixtrait_RunCompleteModel.R",
                  "Models/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_1.2_1.3_1.4_1.5_1/MASPOT_GBLUP_CV8fold_sixtrait_RunCompleteModel.R",
                  "Models/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_1.2_1.3_1.4_1.5_1.6_1/MASPOT_GBLUP_CV8fold_sixtrait_RunCompleteModel.R",
                  "Models/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1/MASPOT_GBLUP_CV8fold_sixtrait_RunCompleteModel.R",
                  "Models/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1.8_1/MASPOT_GBLUP_CV8fold_sixtrait_RunCompleteModel.R",
                  "Models/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1.8_1.9/MASPOT_GBLUP_CV8fold_sixtrait_RunCompleteModel.R",
                  "Models/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_1.2_2/MASPOT_GBLUP_CV8fold_sixtrait_RunCompleteModel.R",
                  "Models/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_1.2_2.3_1/MASPOT_GBLUP_CV8fold_sixtrait_RunCompleteModel.R",
                  "Models/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_1.2_2.3_1.4_1/MASPOT_GBLUP_CV8fold_sixtrait_RunCompleteModel.R",
                  "Models/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_1.2_2.3_1.4_1.5_1/MASPOT_GBLUP_CV8fold_sixtrait_RunCompleteModel.R",
                  "Models/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_1.2_2.3_1.4_1.5_1.6_1/MASPOT_GBLUP_CV8fold_sixtrait_RunCompleteModel.R",
                  "Models/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1/MASPOT_GBLUP_CV8fold_sixtrait_RunCompleteModel.R",
                  "Models/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1.8_1/MASPOT_GBLUP_CV8fold_sixtrait_RunCompleteModel.R",
                  "Models/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1.8_1.9/MASPOT_GBLUP_CV8fold_sixtrait_RunCompleteModel.R",
                  "Models/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_2/MASPOT_GBLUP_CV8fold_sixtrait_RunCompleteModel.R",
                  "Models/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_2.2_1/MASPOT_GBLUP_CV8fold_sixtrait_RunCompleteModel.R",
                  "Models/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_2.2_1.3_1/MASPOT_GBLUP_CV8fold_sixtrait_RunCompleteModel.R",
                  "Models/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_2.2_1.3_1.4_1/MASPOT_GBLUP_CV8fold_sixtrait_RunCompleteModel.R",
                  "Models/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_2.2_1.3_1.4_1.5_1/MASPOT_GBLUP_CV8fold_sixtrait_RunCompleteModel.R",
                  "Models/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_2.2_1.3_1.4_1.5_1.6_1/MASPOT_GBLUP_CV8fold_sixtrait_RunCompleteModel.R",
                  "Models/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1/MASPOT_GBLUP_CV8fold_sixtrait_RunCompleteModel.R",
                  "Models/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1.8_1/MASPOT_GBLUP_CV8fold_sixtrait_RunCompleteModel.R",
                  "Models/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1.8_1.9/MASPOT_GBLUP_CV8fold_sixtrait_RunCompleteModel.R",
                  "Models/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_2.2_2/MASPOT_GBLUP_CV8fold_sixtrait_RunCompleteModel.R",
                  "Models/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_2.2_2.3_1/MASPOT_GBLUP_CV8fold_sixtrait_RunCompleteModel.R",
                  "Models/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_2.2_2.3_1.4_1/MASPOT_GBLUP_CV8fold_sixtrait_RunCompleteModel.R",
                  "Models/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_2.2_2.3_1.4_1.5_1/MASPOT_GBLUP_CV8fold_sixtrait_RunCompleteModel.R",
                  "Models/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_2.2_2.3_1.4_1.5_1.6_1/MASPOT_GBLUP_CV8fold_sixtrait_RunCompleteModel.R",
                  "Models/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1/MASPOT_GBLUP_CV8fold_sixtrait_RunCompleteModel.R",
                  "Models/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1.8_1/MASPOT_GBLUP_CV8fold_sixtrait_RunCompleteModel.R",
                  "Models/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1.8_1.9/MASPOT_GBLUP_CV8fold_sixtrait_RunCompleteModel.R"
  ) # List of scripts to run

for (script_file in script_files) {
  source(script_file)
}

# Close all open connections
closeAllConnections()


