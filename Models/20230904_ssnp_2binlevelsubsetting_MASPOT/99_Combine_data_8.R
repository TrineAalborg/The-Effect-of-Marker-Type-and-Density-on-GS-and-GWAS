#!/usr/bin/env Rscript
###### Script: combine ssnp level 7  data ######
# TRAA September 2023

# Subjects: MASPOT 
# variants: ssnp level 7

###### Set working directory ######

setwd("/home/bio.aau.dk/vm82rp/MASPOT/GS")
rm(list = ls())


###### Load data elements ######

# yHat
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1.8_1/yHat_ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1.8_1.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1.8_1/yHat_ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1.8_1.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1.8_1/yHat_ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1.8_1.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1.8_1/yHat_ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1.8_1.RData")

# stats
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1.8_1/stats_ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1.8_1.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1.8_1/stats_ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1.8_1.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1.8_1/stats_ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1.8_1.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1.8_1/stats_ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1.8_1.RData")

###### Combine ######

# stats
stats_8 <- rbind(stats_ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1.8_1,
                 stats_ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1.8_1,
                 stats_ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1.8_1,
                 stats_ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1.8_1)
stats_8["Markers"] = 122 # change to the actual number of SNPs in that level, for that SNP category
save(stats_8, file = "Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/stats_8.RData")

# yHat
###
yHat_ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1.8_1 = yHat_ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1.8_1[ ,!colnames(yHat_ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1.8_1) %in% c("Mean", "SD")]

yHat_ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1.8_1$Trait <- as.factor(yHat_ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1.8_1$Trait)
yHat_ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1.8_1$SOR <- as.factor(yHat_ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1.8_1$SOR)
yHat_ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1.8_1 = yHat_ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1.8_1[order(yHat_ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1.8_1$Trait, yHat_ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1.8_1$SOR), ]
###
yHat_ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1.8_1 = yHat_ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1.8_1[ ,!colnames(yHat_ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1.8_1) %in% c("Mean", "SD")]

yHat_ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1.8_1$Trait <- as.factor(yHat_ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1.8_1$Trait)
yHat_ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1.8_1$SOR <- as.factor(yHat_ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1.8_1$SOR)
yHat_ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1.8_1 = yHat_ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1.8_1[order(yHat_ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1.8_1$Trait, yHat_ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1.8_1$SOR), ]
###
yHat_ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1.8_1 = yHat_ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1.8_1[ ,!colnames(yHat_ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1.8_1) %in% c("Mean", "SD")]

yHat_ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1.8_1$Trait <- as.factor(yHat_ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1.8_1$Trait)
yHat_ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1.8_1$SOR <- as.factor(yHat_ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1.8_1$SOR)
yHat_ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1.8_1 = yHat_ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1.8_1[order(yHat_ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1.8_1$Trait, yHat_ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1.8_1$SOR), ]
###
yHat_ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1.8_1 = yHat_ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1.8_1[ ,!colnames(yHat_ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1.8_1) %in% c("Mean", "SD")]

yHat_ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1.8_1$Trait <- as.factor(yHat_ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1.8_1$Trait)
yHat_ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1.8_1$SOR <- as.factor(yHat_ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1.8_1$SOR)
yHat_ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1.8_1 = yHat_ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1.8_1[order(yHat_ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1.8_1$Trait, yHat_ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1.8_1$SOR), ]
###

yHat_8 <- cbind(yHat_ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1.8_1[ ,1:10],
                yHat_ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1.8_1[ ,1:10],
                yHat_ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1.8_1[ ,1:10],
                yHat_ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1.8_1[ ,1:10],
                yHat_ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1.8_1[ ,c(11:14,17)])
yHat_8["Markers"] = 122 # change to the actual number of SNPs in that level, for that SNP category
save(yHat_8, file = "Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/yHat_8.RData")
