#!/usr/bin/env Rscript
# Script: make GRM (from already prepared gt and pt Rdata files - the the 01_Make_GRM script in the GS main folder)
# TRAA September 2023

# subjects: MASPOT
# variants: ssnp_0

###### Set working directory ######
setwd("/home/bio.aau.dk/vm82rp/MASPOT/GS")
rm(list = ls())

###### Load data elemets ######

load("Data/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/gt0_ssnp_0.RData")
load("Data/ssnp/pt0_ssnp.RData")

gt <- gt0_ssnp_0
pt <- pt0_ssnp[pt0_ssnp$Panel == "MASPOT", ]

###### Make GRM from prepared gt ######

# SNP column means; this is also SNP frequency here (would correspond to the "ave" vector after filtering steps)
snpmean <- apply(gt,2,mean,na.rm=T) # 2 means columns. Rows is 1, columns and rows is c(1,2). na.rm=T removes all NA

# Determine corrections needed for missing rate
# This is based on computing the sum(pq) values for the non-missing SNP per sample
samplepq <- apply(gt,1,function(x){nm <- !is.na(x); return(sum(snpmean[nm]*(1-snpmean[nm])))})
misscorr <- sqrt(sum(snpmean*(1-snpmean))/samplepq) # wi

# Compute centered and missing-adjusted G
Nsel = ncol(gt)
for(i in 1:Nsel) { gt[,i] <- (gt[,i] - snpmean[i])*misscorr } # corresponding to a mean imputation for missing data cf. (Van Raden 2008, p. 4420)
gt[is.na(gt)] <- 0

G <- gt %*% t(gt) # t: transposed

# Scale G matrix using global scaling cf. (Van Raden 2008):
scaling <- 0.25*sum(snpmean*(1-snpmean))
G <- G/scaling


###### Save final data elements in data files ######

# Remove redundant trait and outdated CV columns in pt
pt_ssnp_0 = pt
pt_ssnp_0 = pt_ssnp_0[, !(colnames(pt_ssnp_0) %in% c("CV", "CV_famA", "CV_famB", "CV_random"))]

save(pt_ssnp_0, file = "Data/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/pt_ssnp_0.RData")

gt_ssnp_0 = gt
save(gt_ssnp_0, file = "Data/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/gt_ssnp_0.RData")

G_ssnp_0 = G
save(G_ssnp_0, file = "Data/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/G_ssnp_0.RData")

scaling_ssnp_0 = scaling
save(scaling_ssnp_0, file = "Data/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/scaling_ssnp_0.RData")
