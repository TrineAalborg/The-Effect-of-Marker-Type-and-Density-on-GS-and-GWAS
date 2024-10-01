#!/usr/bin/env Rscript
###### Script: combine ssnp level 9  data ######
# TRAA September 2023

# Subjects: MASPOT
# variants: ssnp level 9

###### Set working directory ######

setwd("/MASPOT/GS")
rm(list = ls())


###### Load data elements ######

# yHat
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1.8_1.9/yHat_ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1.8_1.9.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1.8_1.9/yHat_ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1.8_1.9.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1.8_1.9/yHat_ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1.8_1.9.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1.8_1.9/yHat_ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1.8_1.9.RData")

# stats
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1.8_1.9/stats_ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1.8_1.9.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1.8_1.9/stats_ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1.8_1.9.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1.8_1.9/stats_ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1.8_1.9.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1.8_1.9/stats_ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1.8_1.9.RData")

###### Combine ######

# stats
stats_9 <- rbind(stats_ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1.8_1.9,
                 stats_ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1.8_1.9,
                 stats_ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1.8_1.9,
                 stats_ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1.8_1.9)
stats_9["Markers"] = 13 # change to the actual number of SNPs in that level, for that SNP category
save(stats_9, file = "Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/stats_9.RData")

# yHat
###
yHat_ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1.8_1.9 = yHat_ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1.8_1.9[ ,!colnames(yHat_ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1.8_1.9) %in% c("Mean", "SD")]

yHat_ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1.8_1.9$Trait <- as.factor(yHat_ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1.8_1.9$Trait)
yHat_ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1.8_1.9$SOR <- as.factor(yHat_ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1.8_1.9$SOR)
yHat_ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1.8_1.9 = yHat_ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1.8_1.9[order(yHat_ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1.8_1.9$Trait, yHat_ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1.8_1.9$SOR), ]
###
yHat_ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1.8_1.9 = yHat_ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1.8_1.9[ ,!colnames(yHat_ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1.8_1.9) %in% c("Mean", "SD")]

yHat_ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1.8_1.9$Trait <- as.factor(yHat_ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1.8_1.9$Trait)
yHat_ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1.8_1.9$SOR <- as.factor(yHat_ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1.8_1.9$SOR)
yHat_ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1.8_1.9 = yHat_ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1.8_1.9[order(yHat_ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1.8_1.9$Trait, yHat_ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1.8_1.9$SOR), ]
###
yHat_ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1.8_1.9 = yHat_ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1.8_1.9[ ,!colnames(yHat_ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1.8_1.9) %in% c("Mean", "SD")]

yHat_ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1.8_1.9$Trait <- as.factor(yHat_ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1.8_1.9$Trait)
yHat_ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1.8_1.9$SOR <- as.factor(yHat_ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1.8_1.9$SOR)
yHat_ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1.8_1.9 = yHat_ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1.8_1.9[order(yHat_ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1.8_1.9$Trait, yHat_ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1.8_1.9$SOR), ]
###
yHat_ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1.8_1.9 = yHat_ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1.8_1.9[ ,!colnames(yHat_ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1.8_1.9) %in% c("Mean", "SD")]

yHat_ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1.8_1.9$Trait <- as.factor(yHat_ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1.8_1.9$Trait)
yHat_ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1.8_1.9$SOR <- as.factor(yHat_ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1.8_1.9$SOR)
yHat_ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1.8_1.9 = yHat_ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1.8_1.9[order(yHat_ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1.8_1.9$Trait, yHat_ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1.8_1.9$SOR), ]
###

yHat_9 <- cbind(yHat_ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1.8_1.9[ ,1:10],
                yHat_ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1.8_1.9[ ,1:10],
                yHat_ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1.8_1.9[ ,1:10],
                yHat_ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1.8_1.9[ ,1:10],
                yHat_ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1.8_1.9[ ,c(11:14,17)])
yHat_9["Markers"] = 13 # change to the actual number of SNPs in that level, for that SNP category
save(yHat_9, file = "Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/yHat_9.RData")
