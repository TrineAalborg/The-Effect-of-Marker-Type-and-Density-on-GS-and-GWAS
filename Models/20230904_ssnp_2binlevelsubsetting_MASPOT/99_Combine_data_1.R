#!/usr/bin/env Rscript
###### Script: combine ssnp level 1  data ######
# TRAA September 2023

# Subjects: MASPOT 
# variants: ssnp level 1

###### Set working directory ######

setwd("MASPOT/GS")
rm(list = ls())


###### Load data elements ######

# yHat
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_1/yHat_ssnp_1_1.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_2/yHat_ssnp_1_2.RData")

# stats
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_1/stats_ssnp_1_1.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_2/stats_ssnp_1_2.RData")

###### Combine ######

# stats
stats_1 <- rbind(stats_ssnp_1_1,
                 stats_ssnp_1_2)
stats_1["Markers"] = 15614 # change to the actual number of SNPs in that level, for that SNP category
save(stats_1, file = "Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/stats_1.RData")

# yHat
yHat_ssnp_1_1 = yHat_ssnp_1_1[ ,!colnames(yHat_ssnp_1_1) %in% c("Mean", "SD")]

yHat_ssnp_1_1$Trait <- as.factor(yHat_ssnp_1_1$Trait)
yHat_ssnp_1_1$SOR <- as.factor(yHat_ssnp_1_1$SOR)
yHat_ssnp_1_1 = yHat_ssnp_1_1[order(yHat_ssnp_1_1$Trait, yHat_ssnp_1_1$SOR), ]

yHat_ssnp_1_2 = yHat_ssnp_1_2[ ,!colnames(yHat_ssnp_1_2) %in% c("Mean", "SD")]

yHat_ssnp_1_2$Trait <- as.factor(yHat_ssnp_1_2$Trait)
yHat_ssnp_1_2$SOR <- as.factor(yHat_ssnp_1_2$SOR)
yHat_ssnp_1_2 = yHat_ssnp_1_2[order(yHat_ssnp_1_2$Trait, yHat_ssnp_1_2$SOR), ]

yHat_1 <- cbind(yHat_ssnp_1_1[ ,1:10],
                yHat_ssnp_1_2[ ,1:10],
                yHat_ssnp_1_1[ ,c(11:14,17)])
yHat_1["Markers"] = 15614 # change to the actual number of SNPs in that level, for that SNP category
save(yHat_1, file = "Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/yHat_1.RData")
