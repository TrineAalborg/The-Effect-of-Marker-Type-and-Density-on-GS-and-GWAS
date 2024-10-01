#!/usr/bin/env Rscript
###### Script: combine ssnp_0  data ######
# TRAA September 2023

# Subjects: MASPOT 
# variants: ssnp_0

###### Set working directory ######

setwd("/home/bio.aau.dk/vm82rp/MASPOT/GS")
rm(list = ls())


###### Load data elements ######

# yHat
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/ssnp_0_yHat_GIC_All_comb.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/ssnp_0_yHat_SP2_All_comb.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/ssnp_0_yHat_TP2_All_comb.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/ssnp_0_yHat_UU2_All_comb.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/ssnp_0_yHat_NDV_All_comb.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/ssnp_0_yHat_LW_All_comb.RData")

# stats
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/ssnp_0_stats_GIC_All_comb.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/ssnp_0_stats_SP2_All_comb.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/ssnp_0_stats_TP2_All_comb.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/ssnp_0_stats_UU2_All_comb.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/ssnp_0_stats_NDV_All_comb.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/ssnp_0_stats_LW_All_comb.RData")

# stats mean
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/ssnp_0_stats_GIC_mean_All_comb.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/ssnp_0_stats_SP2_mean_All_comb.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/ssnp_0_stats_TP2_mean_All_comb.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/ssnp_0_stats_UU2_mean_All_comb.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/ssnp_0_stats_NDV_mean_All_comb.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/ssnp_0_stats_LW_mean_All_comb.RData")


# Combine
yHat_ssnp_0 <- rbind(ssnp_0_yHat_GIC_All_comb,
                        ssnp_0_yHat_SP2_All_comb,
                        ssnp_0_yHat_UU2_All_comb,
                        ssnp_0_yHat_TP2_All_comb,
                        ssnp_0_yHat_NDV_All_comb,
                        ssnp_0_yHat_LW_All_comb)

stats_ssnp_0 <- rbind(ssnp_0_stats_GIC_All_comb,
                         ssnp_0_stats_SP2_All_comb,
                         ssnp_0_stats_UU2_All_comb,
                         ssnp_0_stats_TP2_All_comb,
                         ssnp_0_stats_NDV_All_comb,
                         ssnp_0_stats_LW_All_comb)

stats_mean_ssnp_0 <- rbind(ssnp_0_stats_GIC_mean_All_comb,
                              ssnp_0_stats_SP2_mean_All_comb,
                              ssnp_0_stats_UU2_mean_All_comb,
                              ssnp_0_stats_TP2_mean_All_comb,
                              ssnp_0_stats_NDV_mean_All_comb,
                              ssnp_0_stats_LW_mean_All_comb)

save(yHat_ssnp_0, file = "Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/yHat_ssnp_0.RData")
save(stats_ssnp_0, file = "Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/stats_ssnp_0.RData")
save(stats_mean_ssnp_0, file = "Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/stats_mean_ssnp_0.RData")
