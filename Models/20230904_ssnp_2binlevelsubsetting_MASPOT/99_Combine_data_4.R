#!/usr/bin/env Rscript
###### Script: combine ssnp level 4  data ######
# TRAA September 2023

# Subjects: MASPOT
# variants: ssnp level 4

###### Set working directory ######

setwd("MASPOT/GS")
rm(list = ls())


###### Load data elements ######

# yHat
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_1.2_1.3_1.4_1/yHat_ssnp_1_1.2_1.3_1.4_1.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_1.2_2.3_1.4_1/yHat_ssnp_1_1.2_2.3_1.4_1.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_2.2_1.3_1.4_1/yHat_ssnp_1_2.2_1.3_1.4_1.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_2.2_2.3_1.4_1/yHat_ssnp_1_2.2_2.3_1.4_1.RData")

# stats
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_1.2_1.3_1.4_1/stats_ssnp_1_1.2_1.3_1.4_1.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_1.2_2.3_1.4_1/stats_ssnp_1_1.2_2.3_1.4_1.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_2.2_1.3_1.4_1/stats_ssnp_1_2.2_1.3_1.4_1.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_2.2_2.3_1.4_1/stats_ssnp_1_2.2_2.3_1.4_1.RData")

###### Combine ######

# stats
stats_4 <- rbind(stats_ssnp_1_1.2_1.3_1.4_1,
                 stats_ssnp_1_1.2_2.3_1.4_1,
                 stats_ssnp_1_2.2_1.3_1.4_1,
                 stats_ssnp_1_2.2_2.3_1.4_1)
stats_4["Markers"] = 1952 # change to the actual number of SNPs in that level, for that SNP category
save(stats_4, file = "Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/stats_4.RData")

# yHat
###
yHat_ssnp_1_1.2_1.3_1.4_1 = yHat_ssnp_1_1.2_1.3_1.4_1[ ,!colnames(yHat_ssnp_1_1.2_1.3_1.4_1) %in% c("Mean", "SD")]

yHat_ssnp_1_1.2_1.3_1.4_1$Trait <- as.factor(yHat_ssnp_1_1.2_1.3_1.4_1$Trait)
yHat_ssnp_1_1.2_1.3_1.4_1$SOR <- as.factor(yHat_ssnp_1_1.2_1.3_1.4_1$SOR)
yHat_ssnp_1_1.2_1.3_1.4_1 = yHat_ssnp_1_1.2_1.3_1.4_1[order(yHat_ssnp_1_1.2_1.3_1.4_1$Trait, yHat_ssnp_1_1.2_1.3_1.4_1$SOR), ]
###
yHat_ssnp_1_1.2_2.3_1.4_1 = yHat_ssnp_1_1.2_2.3_1.4_1[ ,!colnames(yHat_ssnp_1_1.2_2.3_1.4_1) %in% c("Mean", "SD")]

yHat_ssnp_1_1.2_2.3_1.4_1$Trait <- as.factor(yHat_ssnp_1_1.2_2.3_1.4_1$Trait)
yHat_ssnp_1_1.2_2.3_1.4_1$SOR <- as.factor(yHat_ssnp_1_1.2_2.3_1.4_1$SOR)
yHat_ssnp_1_1.2_2.3_1.4_1 = yHat_ssnp_1_1.2_2.3_1.4_1[order(yHat_ssnp_1_1.2_2.3_1.4_1$Trait, yHat_ssnp_1_1.2_2.3_1.4_1$SOR), ]
###
yHat_ssnp_1_2.2_1.3_1.4_1 = yHat_ssnp_1_2.2_1.3_1.4_1[ ,!colnames(yHat_ssnp_1_2.2_1.3_1.4_1) %in% c("Mean", "SD")]

yHat_ssnp_1_2.2_1.3_1.4_1$Trait <- as.factor(yHat_ssnp_1_2.2_1.3_1.4_1$Trait)
yHat_ssnp_1_2.2_1.3_1.4_1$SOR <- as.factor(yHat_ssnp_1_2.2_1.3_1.4_1$SOR)
yHat_ssnp_1_2.2_1.3_1.4_1 = yHat_ssnp_1_2.2_1.3_1.4_1[order(yHat_ssnp_1_2.2_1.3_1.4_1$Trait, yHat_ssnp_1_2.2_1.3_1.4_1$SOR), ]
###
yHat_ssnp_1_2.2_2.3_1.4_1 = yHat_ssnp_1_2.2_2.3_1.4_1[ ,!colnames(yHat_ssnp_1_2.2_2.3_1.4_1) %in% c("Mean", "SD")]

yHat_ssnp_1_2.2_2.3_1.4_1$Trait <- as.factor(yHat_ssnp_1_2.2_2.3_1.4_1$Trait)
yHat_ssnp_1_2.2_2.3_1.4_1$SOR <- as.factor(yHat_ssnp_1_2.2_2.3_1.4_1$SOR)
yHat_ssnp_1_2.2_2.3_1.4_1 = yHat_ssnp_1_2.2_2.3_1.4_1[order(yHat_ssnp_1_2.2_2.3_1.4_1$Trait, yHat_ssnp_1_2.2_2.3_1.4_1$SOR), ]
###

yHat_4 <- cbind(yHat_ssnp_1_1.2_1.3_1.4_1[ ,1:10],
                yHat_ssnp_1_1.2_2.3_1.4_1[ ,1:10],
                yHat_ssnp_1_2.2_1.3_1.4_1[ ,1:10],
                yHat_ssnp_1_2.2_2.3_1.4_1[ ,1:10],
                yHat_ssnp_1_1.2_1.3_1.4_1[ ,c(11:14,17)])
yHat_4["Markers"] = 1952 # change to the actual number of SNPs in that level, for that SNP category
save(yHat_4, file = "Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/yHat_4.RData")
