#!/usr/bin/env Rscript
###### Script: combine ssnp level 0  data ######
# TRAA September 2023

# Subjects: MASPOT
# variants: ssnp level 0

###### Set working directory ######

setwd("MASPOT/GS")
rm(list = ls())


###### Load data elements ######

# yHat

load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/yHat_ssnp_0.RData")

# stats

load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/stats_ssnp_0.RData")

###### Combine ######

stats_0 <- stats_ssnp_0
stats_0["Markers"] = 31229 # change to the actual number of SNPs in that level, for that SNP category
save(stats_0, file = "Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/stats_0.RData")


yHat_ssnp_0 = yHat_ssnp_0[ ,!colnames(yHat_ssnp_0) %in% c("Mean", "SD")]

yHat_ssnp_0$Trait <- as.factor(yHat_ssnp_0$Trait)
yHat_ssnp_0$SOR <- as.factor(yHat_ssnp_0$SOR)
yHat_ssnp_0 = yHat_ssnp_0[order(yHat_ssnp_0$Trait, yHat_ssnp_0$SOR), ]

yHat_0 <- cbind(yHat_ssnp_0[ ,1:10],
                yHat_ssnp_0[ ,c(11:14,17)])
yHat_0["Markers"] = 31229 # change to the actual number of SNPs in that level, for that SNP category
save(yHat_0, file = "Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/yHat_0.RData")
