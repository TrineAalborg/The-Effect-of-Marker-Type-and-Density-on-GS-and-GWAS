###### Script: subsample gt matrix in multiple size 2 bin levels ######
# TRAA September 2023

# Subjects: MASPOT 
# Variants: ssnps

###### Set working directory ######

setwd("/home/bio.aau.dk/vm82rp/MASPOT/GS")
rm(list = ls())

###### Load data elements ######

load("Data/ssnp/gt0_ssnp.Rdata") 
load("Data/ssnp/pt0_ssnp.RData")

# 30 000 markers

gt <- gt0_ssnp[pt0_ssnp$Panel == "MASPOT", ]


###### Prepare filtering files needed in subsetting position file ######

load("Data/ssnp/snppos_ssnp.RData") 



###### First level subset ######
# 15 000 markers

# SNPs are grouped into 2 bins - sorting by every other SNP to ensure equal chromosomal coverage in each bin (random subsetting could not ensure this in subsequent subset levels)

# index naming will be: firstsubsetlevel_beginningrow
# 1 is the part taking every other column beginning with the 1st column
# 2 is the part taking every other column beggining with the 2nd column

# subset 0

gt0_ssnp_0 <- gt
save(gt0_ssnp_0, file = "Data/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/gt0_ssnp_0.RData")

snppos_ssnp_0 <- snppos_ssnp
save(snppos_ssnp_0, file = "Data/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/snppos_ssnp_0.RData")



# subset 1 of level 1: ssnp_1_1
gt_ssnp_1_1 <- gt[ ,seq(1, ncol(gt), by = 2)]
gt0_ssnp_1_1 <- gt_ssnp_1_1
save(gt0_ssnp_1_1, file = "Data/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_1/gt0_ssnp_1_1.RData")

snpselect_gt_ssnp_1_1 <- rep(FALSE, ncol(gt))
snpselect_gt_ssnp_1_1[seq(1, ncol(gt), by = 2)] <- TRUE #creates logical vector of which snps are selected in each subset (for GRM script)
snppos_ssnp_1_1 <- snppos_ssnp[snpselect_gt_ssnp_1_1, ]
save(snppos_ssnp_1_1, file = "Data/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_1/snppos_ssnp_1_1.RData")


# subset 2 of level 1: ssnp_1_2
gt_ssnp_1_2 <- gt[ ,seq(2, ncol(gt), by = 2)]
gt0_ssnp_1_2 <- gt_ssnp_1_2
save(gt0_ssnp_1_2, file = "Data/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_2/gt0_ssnp_1_2.RData")

snpselect_gt_ssnp_1_2 <- rep(FALSE, ncol(gt))
snpselect_gt_ssnp_1_2[seq(2, ncol(gt), by = 2)] <- TRUE #creates logical vector of which snps are selected in each subset (for GRM script)
snppos_ssnp_1_2 <- snppos_ssnp[snpselect_gt_ssnp_1_2, ]
save(snppos_ssnp_1_2, file = "Data/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_2/snppos_ssnp_1_2.RData")


###### Second level subset ######
# 7 500 markers

# level 1 sub 1 - level 2 sub 1: ssnp_1_1.2_1
gt_ssnp_1_1.2_1 <- gt_ssnp_1_1[ ,seq(1, ncol(gt_ssnp_1_1), by = 2)]
gt0_ssnp_1_1.2_1 <- gt_ssnp_1_1.2_1
save(gt0_ssnp_1_1.2_1, file = "Data/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_1.2_1/gt0_ssnp_1_1.2_1.RData")

snpselect_gt_ssnp_1_1.2_1 <- rep(FALSE, ncol(gt_ssnp_1_1))
snpselect_gt_ssnp_1_1.2_1[seq(1, ncol(gt_ssnp_1_1), by = 2)] <- TRUE #creates logical vector of which snps are selected in each subset (for GRM script)
snppos_ssnp_1_1.2_1 <- snppos_ssnp_1_1[snpselect_gt_ssnp_1_1.2_1, ]
save(snppos_ssnp_1_1.2_1, file = "Data/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_1.2_1/snppos_ssnp_1_1.2_1.RData")


# level 1 sub 1 - level 2 sub 2: ssnp_1_1.2_2
gt_ssnp_1_1.2_2 <- gt_ssnp_1_1[ ,seq(2, ncol(gt_ssnp_1_1), by = 2)]
gt0_ssnp_1_1.2_2 <- gt_ssnp_1_1.2_2
save(gt0_ssnp_1_1.2_2, file = "Data/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_1.2_2/gt0_ssnp_1_1.2_2.RData")

snpselect_gt_ssnp_1_1.2_2 <- rep(FALSE, ncol(gt_ssnp_1_1))
snpselect_gt_ssnp_1_1.2_2[seq(2, ncol(gt_ssnp_1_1), by = 2)] <- TRUE #creates logical vector of which snps are selected in each subset (for GRM script)
snppos_ssnp_1_1.2_2 <- snppos_ssnp_1_1[snpselect_gt_ssnp_1_1.2_2, ]
save(snppos_ssnp_1_1.2_2, file = "Data/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_1.2_2/snppos_ssnp_1_1.2_2.RData")


# level 1 sub 2 - level 2 sub 1: ssnp_1_2.2_1
gt_ssnp_1_2.2_1 <- gt_ssnp_1_2[ ,seq(1, ncol(gt_ssnp_1_2), by = 2)]
gt0_ssnp_1_2.2_1 <- gt_ssnp_1_2.2_1
save(gt0_ssnp_1_2.2_1, file = "Data/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_2.2_1/gt0_ssnp_1_2.2_1.RData")

snpselect_gt_ssnp_1_2.2_1 <- rep(FALSE, ncol(gt_ssnp_1_2))
snpselect_gt_ssnp_1_2.2_1[seq(1, ncol(gt_ssnp_1_2), by = 2)] <- TRUE #creates logical vector of which snps are selected in each subset (for GRM script)
snppos_ssnp_1_2.2_1 <- snppos_ssnp_1_2[snpselect_gt_ssnp_1_2.2_1, ]
save(snppos_ssnp_1_2.2_1, file = "Data/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_2.2_1/snppos_ssnp_1_2.2_1.RData")

# level 1 sub 2 - level 2 sub 2: ssnp_1_2.2_2
gt_ssnp_1_2.2_2 <- gt_ssnp_1_2[ ,seq(2, ncol(gt_ssnp_1_2), by = 2)]
gt0_ssnp_1_2.2_2 <- gt_ssnp_1_2.2_2
save(gt0_ssnp_1_2.2_2, file = "Data/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_2.2_2/gt0_ssnp_1_2.2_2.RData")

snpselect_gt_ssnp_1_2.2_2 <- rep(FALSE, ncol(gt_ssnp_1_2))
snpselect_gt_ssnp_1_2.2_2[seq(2, ncol(gt_ssnp_1_2), by = 2)] <- TRUE #creates logical vector of which snps are selected in each subset (for GRM script)
snppos_ssnp_1_2.2_2 <- snppos_ssnp_1_2[snpselect_gt_ssnp_1_2.2_2, ]
save(snppos_ssnp_1_2.2_2, file = "Data/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_2.2_2/snppos_ssnp_1_2.2_2.RData")



###### Third level subset ######
# 3 700 markers

# level 1 sub 1, level 2 sub 1, level 3 sub 1: ssnp_1_1.2_1.3_1
gt_ssnp_1_1.2_1.3_1 <- gt_ssnp_1_1.2_1[ ,seq(1, ncol(gt_ssnp_1_1.2_1), by = 2)]
gt0_ssnp_1_1.2_1.3_1 <- gt_ssnp_1_1.2_1.3_1
save(gt0_ssnp_1_1.2_1.3_1, file = "Data/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_1.2_1.3_1/gt0_ssnp_1_1.2_1.3_1.RData")

snpselect_gt_ssnp_1_1.2_1.3_1 <- rep(FALSE, ncol(gt_ssnp_1_1.2_1))
snpselect_gt_ssnp_1_1.2_1.3_1[seq(1, ncol(gt_ssnp_1_1.2_1), by = 2)] <- TRUE #creates logical vector of which snps are selected in each subset (for GRM script)
snppos_ssnp_1_1.2_1.3_1 <- snppos_ssnp_1_1.2_1[snpselect_gt_ssnp_1_1.2_1.3_1, ]
save(snppos_ssnp_1_1.2_1.3_1, file = "Data/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_1.2_1.3_1/snppos_ssnp_1_1.2_1.3_1.RData")


###

# level 1 sub 1, level 2 sub 2, level 3 sub 1: ssnp_1_1.2_2.3_1
gt_ssnp_1_1.2_2.3_1 <- gt_ssnp_1_1.2_2[ ,seq(1, ncol(gt_ssnp_1_1.2_2), by = 2)]
gt0_ssnp_1_1.2_2.3_1 <- gt_ssnp_1_1.2_2.3_1
save(gt0_ssnp_1_1.2_2.3_1, file = "Data/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_1.2_2.3_1/gt0_ssnp_1_1.2_2.3_1.RData")

snpselect_gt_ssnp_1_1.2_2.3_1 <- rep(FALSE, ncol(gt_ssnp_1_1.2_2))
snpselect_gt_ssnp_1_1.2_2.3_1[seq(1, ncol(gt_ssnp_1_1.2_2), by = 2)] <- TRUE #creates logical vector of which snps are selected in each subset (for GRM script)
snppos_ssnp_1_1.2_2.3_1 <- snppos_ssnp_1_1.2_2[snpselect_gt_ssnp_1_1.2_2.3_1, ]
save(snppos_ssnp_1_1.2_2.3_1, file = "Data/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_1.2_2.3_1/snppos_ssnp_1_1.2_2.3_1.RData")


###

# level 1 sub 2, level 2 sub 1, level 3 sub 1: ssnp_1_2.2_1.3_1
gt_ssnp_1_2.2_1.3_1 <- gt_ssnp_1_2.2_1[ ,seq(1, ncol(gt_ssnp_1_2.2_1), by = 2)]
gt0_ssnp_1_2.2_1.3_1 <- gt_ssnp_1_2.2_1.3_1
save(gt0_ssnp_1_2.2_1.3_1, file = "Data/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_2.2_1.3_1/gt0_ssnp_1_2.2_1.3_1.RData")

snpselect_gt_ssnp_1_2.2_1.3_1 <- rep(FALSE, ncol(gt_ssnp_1_2.2_1))
snpselect_gt_ssnp_1_2.2_1.3_1[seq(1, ncol(gt_ssnp_1_2.2_1), by = 2)] <- TRUE #creates logical vector of which snps are selected in each subset (for GRM script)
snppos_ssnp_1_2.2_1.3_1 <- snppos_ssnp_1_2.2_1[snpselect_gt_ssnp_1_2.2_1.3_1, ]
save(snppos_ssnp_1_2.2_1.3_1, file = "Data/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_2.2_1.3_1/snppos_ssnp_1_2.2_1.3_1.RData")


###

# level 1 sub 2, level 2 sub 2, level 3 sub 1: ssnp_1_1.2_2.3_1
gt_ssnp_1_2.2_2.3_1 <- gt_ssnp_1_2.2_2[ ,seq(1, ncol(gt_ssnp_1_2.2_2), by = 2)]
gt0_ssnp_1_2.2_2.3_1 <- gt_ssnp_1_2.2_2.3_1
save(gt0_ssnp_1_2.2_2.3_1, file = "Data/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_2.2_2.3_1/gt0_ssnp_1_2.2_2.3_1.RData")

snpselect_gt_ssnp_1_2.2_2.3_1 <- rep(FALSE, ncol(gt_ssnp_1_2.2_2))
snpselect_gt_ssnp_1_2.2_2.3_1[seq(1, ncol(gt_ssnp_1_2.2_2), by = 2)] <- TRUE #creates logical vector of which snps are selected in each subset (for GRM script)
snppos_ssnp_1_2.2_2.3_1 <- snppos_ssnp_1_2.2_2[snpselect_gt_ssnp_1_2.2_2.3_1, ]
save(snppos_ssnp_1_2.2_2.3_1, file = "Data/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_2.2_2.3_1/snppos_ssnp_1_2.2_2.3_1.RData")



###### Fourth level subset ######
# 1 850 markers

# level 1 sub 1, level 2 sub 1, level 3 sub 1, level 4 sub 1; 1_1.2_1.3_1.4_1
gt_ssnp_1_1.2_1.3_1.4_1 <- gt_ssnp_1_1.2_1.3_1[ ,seq(1, ncol(gt_ssnp_1_1.2_1.3_1), by = 2)]
gt0_ssnp_1_1.2_1.3_1.4_1 <- gt_ssnp_1_1.2_1.3_1.4_1
save(gt0_ssnp_1_1.2_1.3_1.4_1, file = "Data/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_1.2_1.3_1.4_1/gt0_ssnp_1_1.2_1.3_1.4_1.RData")

snpselect_gt_ssnp_1_1.2_1.3_1.4_1 <- rep(FALSE, ncol(gt_ssnp_1_1.2_1.3_1))
snpselect_gt_ssnp_1_1.2_1.3_1.4_1[seq(1, ncol(gt_ssnp_1_1.2_1.3_1), by = 2)] <- TRUE #creates logical vector of which snps are selected in each subset (for GRM script)
snppos_ssnp_1_1.2_1.3_1.4_1 <- snppos_ssnp_1_1.2_1.3_1[snpselect_gt_ssnp_1_1.2_1.3_1.4_1, ]
save(snppos_ssnp_1_1.2_1.3_1.4_1, file = "Data/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_1.2_1.3_1.4_1/snppos_ssnp_1_1.2_1.3_1.4_1.RData")

# level 1 sub 1, level 2 sub 2, level 3 sub 1, level 4 sub 1; 1_1.2_1.3_1.4_1
gt_ssnp_1_1.2_2.3_1.4_1 <- gt_ssnp_1_1.2_2.3_1[ ,seq(1, ncol(gt_ssnp_1_1.2_2.3_1), by = 2)]
gt0_ssnp_1_1.2_2.3_1.4_1 <- gt_ssnp_1_1.2_2.3_1.4_1
save(gt0_ssnp_1_1.2_2.3_1.4_1, file = "Data/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_1.2_2.3_1.4_1/gt0_ssnp_1_1.2_2.3_1.4_1.RData")

snpselect_gt_ssnp_1_1.2_2.3_1.4_1 <- rep(FALSE, ncol(gt_ssnp_1_1.2_2.3_1))
snpselect_gt_ssnp_1_1.2_2.3_1.4_1[seq(1, ncol(gt_ssnp_1_1.2_2.3_1), by = 2)] <- TRUE #creates logical vector of which snps are selected in each subset (for GRM script)
snppos_ssnp_1_1.2_2.3_1.4_1 <- snppos_ssnp_1_1.2_2.3_1[snpselect_gt_ssnp_1_1.2_2.3_1.4_1, ]
save(snppos_ssnp_1_1.2_2.3_1.4_1, file = "Data/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_1.2_2.3_1.4_1/snppos_ssnp_1_1.2_2.3_1.4_1.RData")

# level 1 sub 2, level 2 sub 1, level 3 sub 1, level 4 sub 1; 1_2.2_1.3_1.4_1
gt_ssnp_1_2.2_1.3_1.4_1 <- gt_ssnp_1_2.2_1.3_1[ ,seq(1, ncol(gt_ssnp_1_2.2_1.3_1), by = 2)]
gt0_ssnp_1_2.2_1.3_1.4_1 <- gt_ssnp_1_2.2_1.3_1.4_1
save(gt0_ssnp_1_2.2_1.3_1.4_1, file = "Data/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_2.2_1.3_1.4_1/gt0_ssnp_1_2.2_1.3_1.4_1.RData")

snpselect_gt_ssnp_1_2.2_1.3_1.4_1 <- rep(FALSE, ncol(gt_ssnp_1_2.2_1.3_1))
snpselect_gt_ssnp_1_2.2_1.3_1.4_1[seq(1, ncol(gt_ssnp_1_2.2_1.3_1), by = 2)] <- TRUE #creates logical vector of which snps are selected in each subset (for GRM script)
snppos_ssnp_1_2.2_1.3_1.4_1 <- snppos_ssnp_1_2.2_1.3_1[snpselect_gt_ssnp_1_2.2_1.3_1.4_1, ]
save(snppos_ssnp_1_2.2_1.3_1.4_1, file = "Data/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_2.2_1.3_1.4_1/snppos_ssnp_1_2.2_1.3_1.4_1.RData")

# level 1 sub 2, level 2 sub 2, level 3 sub 1, level 4 sub 1; 1_2.2_2.3_1.4_1
gt_ssnp_1_2.2_2.3_1.4_1 <- gt_ssnp_1_2.2_2.3_1[ ,seq(1, ncol(gt_ssnp_1_2.2_2.3_1), by = 2)]
gt0_ssnp_1_2.2_2.3_1.4_1 <- gt_ssnp_1_2.2_2.3_1.4_1
save(gt0_ssnp_1_2.2_2.3_1.4_1, file = "Data/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_2.2_2.3_1.4_1/gt0_ssnp_1_2.2_2.3_1.4_1.RData")

snpselect_gt_ssnp_1_2.2_2.3_1.4_1 <- rep(FALSE, ncol(gt_ssnp_1_2.2_2.3_1))
snpselect_gt_ssnp_1_2.2_2.3_1.4_1[seq(1, ncol(gt_ssnp_1_2.2_2.3_1), by = 2)] <- TRUE #creates logical vector of which snps are selected in each subset (for GRM script)
snppos_ssnp_1_2.2_2.3_1.4_1 <- snppos_ssnp_1_2.2_2.3_1[snpselect_gt_ssnp_1_2.2_2.3_1.4_1, ]
save(snppos_ssnp_1_2.2_2.3_1.4_1, file = "Data/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_2.2_2.3_1.4_1/snppos_ssnp_1_2.2_2.3_1.4_1.RData")


###### Fifth level subset ######
# 925 markers

# level 1 sub 1, level 2 sub 1, level 3 sub 1, level 4 sub 1, level 5 sub 1; 1_1.2_1.3_1.4_1.5_1
gt_ssnp_1_1.2_1.3_1.4_1.5_1 <- gt_ssnp_1_1.2_1.3_1.4_1[ ,seq(1, ncol(gt_ssnp_1_1.2_1.3_1.4_1), by = 2)]
gt0_ssnp_1_1.2_1.3_1.4_1.5_1 <- gt_ssnp_1_1.2_1.3_1.4_1.5_1
save(gt0_ssnp_1_1.2_1.3_1.4_1.5_1, file = "Data/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_1.2_1.3_1.4_1.5_1/gt0_ssnp_1_1.2_1.3_1.4_1.5_1.RData")

snpselect_gt_ssnp_1_1.2_1.3_1.4_1.5_1 <- rep(FALSE, ncol(gt_ssnp_1_1.2_1.3_1.4_1))
snpselect_gt_ssnp_1_1.2_1.3_1.4_1.5_1[seq(1, ncol(gt_ssnp_1_1.2_1.3_1.4_1), by = 2)] <- TRUE #creates logical vector of which snps are selected in each subset (for GRM script)
snppos_ssnp_1_1.2_1.3_1.4_1.5_1 <- snppos_ssnp_1_1.2_1.3_1.4_1[snpselect_gt_ssnp_1_1.2_1.3_1.4_1.5_1, ]
save(snppos_ssnp_1_1.2_1.3_1.4_1.5_1, file = "Data/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_1.2_1.3_1.4_1.5_1/snppos_ssnp_1_1.2_1.3_1.4_1.5_1.RData")

# level 1 sub 1, level 2 sub 2, level 3 sub 1, level 4 sub 1, level 5 sub 1; 1_1.2_1.3_1.4_1.5_1
gt_ssnp_1_1.2_2.3_1.4_1.5_1 <- gt_ssnp_1_1.2_2.3_1.4_1[ ,seq(1, ncol(gt_ssnp_1_1.2_2.3_1.4_1), by = 2)]
gt0_ssnp_1_1.2_2.3_1.4_1.5_1 <- gt_ssnp_1_1.2_2.3_1.4_1.5_1
save(gt0_ssnp_1_1.2_2.3_1.4_1.5_1, file = "Data/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_1.2_2.3_1.4_1.5_1/gt0_ssnp_1_1.2_2.3_1.4_1.5_1.RData")

snpselect_gt_ssnp_1_1.2_2.3_1.4_1.5_1 <- rep(FALSE, ncol(gt_ssnp_1_1.2_2.3_1.4_1))
snpselect_gt_ssnp_1_1.2_2.3_1.4_1.5_1[seq(1, ncol(gt_ssnp_1_1.2_2.3_1.4_1), by = 2)] <- TRUE #creates logical vector of which snps are selected in each subset (for GRM script)
snppos_ssnp_1_1.2_2.3_1.4_1.5_1 <- snppos_ssnp_1_1.2_2.3_1.4_1[snpselect_gt_ssnp_1_1.2_2.3_1.4_1.5_1, ]
save(snppos_ssnp_1_1.2_2.3_1.4_1.5_1, file = "Data/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_1.2_2.3_1.4_1.5_1/snppos_ssnp_1_1.2_2.3_1.4_1.5_1.RData")

# level 1 sub 2, level 2 sub 1, level 3 sub 1, level 4 sub 1, level 5 sub 1; 1_2.2_1.3_1.4_1.5_1
gt_ssnp_1_2.2_1.3_1.4_1.5_1 <- gt_ssnp_1_2.2_1.3_1.4_1[ ,seq(1, ncol(gt_ssnp_1_2.2_1.3_1.4_1), by = 2)]
gt0_ssnp_1_2.2_1.3_1.4_1.5_1 <- gt_ssnp_1_2.2_1.3_1.4_1.5_1
save(gt0_ssnp_1_2.2_1.3_1.4_1.5_1, file = "Data/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_2.2_1.3_1.4_1.5_1/gt0_ssnp_1_2.2_1.3_1.4_1.5_1.RData")

snpselect_gt_ssnp_1_2.2_1.3_1.4_1.5_1 <- rep(FALSE, ncol(gt_ssnp_1_2.2_1.3_1.4_1))
snpselect_gt_ssnp_1_2.2_1.3_1.4_1.5_1[seq(1, ncol(gt_ssnp_1_2.2_1.3_1.4_1), by = 2)] <- TRUE #creates logical vector of which snps are selected in each subset (for GRM script)
snppos_ssnp_1_2.2_1.3_1.4_1.5_1 <- snppos_ssnp_1_2.2_1.3_1.4_1[snpselect_gt_ssnp_1_2.2_1.3_1.4_1.5_1, ]
save(snppos_ssnp_1_2.2_1.3_1.4_1.5_1, file = "Data/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_2.2_1.3_1.4_1.5_1/snppos_ssnp_1_2.2_1.3_1.4_1.5_1.RData")

# level 1 sub 2, level 2 sub 2, level 3 sub 1, level 4 sub 1, level 5 sub 1; 1_2.2_2.3_1.4_1.5_1
gt_ssnp_1_2.2_2.3_1.4_1.5_1 <- gt_ssnp_1_2.2_2.3_1.4_1[ ,seq(1, ncol(gt_ssnp_1_2.2_2.3_1.4_1), by = 2)]
gt0_ssnp_1_2.2_2.3_1.4_1.5_1 <- gt_ssnp_1_2.2_2.3_1.4_1.5_1
save(gt0_ssnp_1_2.2_2.3_1.4_1.5_1, file = "Data/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_2.2_2.3_1.4_1.5_1/gt0_ssnp_1_2.2_2.3_1.4_1.5_1.RData")

snpselect_gt_ssnp_1_2.2_2.3_1.4_1.5_1 <- rep(FALSE, ncol(gt_ssnp_1_2.2_2.3_1.4_1))
snpselect_gt_ssnp_1_2.2_2.3_1.4_1.5_1[seq(1, ncol(gt_ssnp_1_2.2_2.3_1.4_1), by = 2)] <- TRUE #creates logical vector of which snps are selected in each subset (for GRM script)
snppos_ssnp_1_2.2_2.3_1.4_1.5_1 <- snppos_ssnp_1_2.2_2.3_1.4_1[snpselect_gt_ssnp_1_2.2_2.3_1.4_1.5_1, ]
save(snppos_ssnp_1_2.2_2.3_1.4_1.5_1, file = "Data/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_2.2_2.3_1.4_1.5_1/snppos_ssnp_1_2.2_2.3_1.4_1.5_1.RData")


###### Sixth level subset ######
# 460 markers

# level 1 sub 1, level 2 sub 1, level 3 sub 1, level 4 sub 1, level 5 sub 1, level 6 sub 1; 1_1.2_1.3_1.4_1.5_1.6_1
gt_ssnp_1_1.2_1.3_1.4_1.5_1.6_1 <- gt_ssnp_1_1.2_1.3_1.4_1.5_1[ ,seq(1, ncol(gt_ssnp_1_1.2_1.3_1.4_1.5_1), by = 2)]
gt0_ssnp_1_1.2_1.3_1.4_1.5_1.6_1 <- gt_ssnp_1_1.2_1.3_1.4_1.5_1.6_1
save(gt0_ssnp_1_1.2_1.3_1.4_1.5_1.6_1, file = "Data/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_1.2_1.3_1.4_1.5_1.6_1/gt0_ssnp_1_1.2_1.3_1.4_1.5_1.6_1.RData")

snpselect_gt_ssnp_1_1.2_1.3_1.4_1.5_1.6_1 <- rep(FALSE, ncol(gt_ssnp_1_1.2_1.3_1.4_1.5_1))
snpselect_gt_ssnp_1_1.2_1.3_1.4_1.5_1.6_1[seq(1, ncol(gt_ssnp_1_1.2_1.3_1.4_1.5_1), by = 2)] <- TRUE #creates logical vector of which snps are selected in each subset (for GRM script)
snppos_ssnp_1_1.2_1.3_1.4_1.5_1.6_1 <- snppos_ssnp_1_1.2_1.3_1.4_1.5_1[snpselect_gt_ssnp_1_1.2_1.3_1.4_1.5_1.6_1, ]
save(snppos_ssnp_1_1.2_1.3_1.4_1.5_1.6_1, file = "Data/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_1.2_1.3_1.4_1.5_1.6_1/snppos_ssnp_1_1.2_1.3_1.4_1.5_1.6_1.RData")

# level 1 sub 1, level 2 sub 2, level 3 sub 1, level 4 sub 1, level 5 sub 1, level 6 sub 1; 1_1.2_1.3_1.4_1.5_1.6_1
gt_ssnp_1_1.2_2.3_1.4_1.5_1.6_1 <- gt_ssnp_1_1.2_2.3_1.4_1.5_1[ ,seq(1, ncol(gt_ssnp_1_1.2_2.3_1.4_1.5_1), by = 2)]
gt0_ssnp_1_1.2_2.3_1.4_1.5_1.6_1 <- gt_ssnp_1_1.2_2.3_1.4_1.5_1.6_1
save(gt0_ssnp_1_1.2_2.3_1.4_1.5_1.6_1, file = "Data/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_1.2_2.3_1.4_1.5_1.6_1/gt0_ssnp_1_1.2_2.3_1.4_1.5_1.6_1.RData")

snpselect_gt_ssnp_1_1.2_2.3_1.4_1.5_1.6_1 <- rep(FALSE, ncol(gt_ssnp_1_1.2_2.3_1.4_1.5_1))
snpselect_gt_ssnp_1_1.2_2.3_1.4_1.5_1.6_1[seq(1, ncol(gt_ssnp_1_1.2_2.3_1.4_1.5_1), by = 2)] <- TRUE #creates logical vector of which snps are selected in each subset (for GRM script)
snppos_ssnp_1_1.2_2.3_1.4_1.5_1.6_1 <- snppos_ssnp_1_1.2_2.3_1.4_1.5_1[snpselect_gt_ssnp_1_1.2_2.3_1.4_1.5_1.6_1, ]
save(snppos_ssnp_1_1.2_2.3_1.4_1.5_1.6_1, file = "Data/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_1.2_2.3_1.4_1.5_1.6_1/snppos_ssnp_1_1.2_2.3_1.4_1.5_1.6_1.RData")

# level 1 sub 2, level 2 sub 1, level 3 sub 1, level 4 sub 1, level 5 sub 1, level 6 sub 1; 1_2.2_1.3_1.4_1.5_1.6_1
gt_ssnp_1_2.2_1.3_1.4_1.5_1.6_1 <- gt_ssnp_1_2.2_1.3_1.4_1.5_1[ ,seq(1, ncol(gt_ssnp_1_2.2_1.3_1.4_1.5_1), by = 2)]
gt0_ssnp_1_2.2_1.3_1.4_1.5_1.6_1 <- gt_ssnp_1_2.2_1.3_1.4_1.5_1.6_1
save(gt0_ssnp_1_2.2_1.3_1.4_1.5_1.6_1, file = "Data/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_2.2_1.3_1.4_1.5_1.6_1/gt0_ssnp_1_2.2_1.3_1.4_1.5_1.6_1.RData")

snpselect_gt_ssnp_1_2.2_1.3_1.4_1.5_1.6_1 <- rep(FALSE, ncol(gt_ssnp_1_2.2_1.3_1.4_1.5_1))
snpselect_gt_ssnp_1_2.2_1.3_1.4_1.5_1.6_1[seq(1, ncol(gt_ssnp_1_2.2_1.3_1.4_1.5_1), by = 2)] <- TRUE #creates logical vector of which snps are selected in each subset (for GRM script)
snppos_ssnp_1_2.2_1.3_1.4_1.5_1.6_1 <- snppos_ssnp_1_2.2_1.3_1.4_1.5_1[snpselect_gt_ssnp_1_2.2_1.3_1.4_1.5_1.6_1, ]
save(snppos_ssnp_1_2.2_1.3_1.4_1.5_1.6_1, file = "Data/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_2.2_1.3_1.4_1.5_1.6_1/snppos_ssnp_1_2.2_1.3_1.4_1.5_1.6_1.RData")

# level 1 sub 2, level 2 sub 2, level 3 sub 1, level 4 sub 1, level 5 sub 1, level 6 sub 1; 1_2.2_2.3_1.4_1.5_1.6_1
gt_ssnp_1_2.2_2.3_1.4_1.5_1.6_1 <- gt_ssnp_1_2.2_2.3_1.4_1.5_1[ ,seq(1, ncol(gt_ssnp_1_2.2_2.3_1.4_1.5_1), by = 2)]
gt0_ssnp_1_2.2_2.3_1.4_1.5_1.6_1 <- gt_ssnp_1_2.2_2.3_1.4_1.5_1.6_1
save(gt0_ssnp_1_2.2_2.3_1.4_1.5_1.6_1, file = "Data/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_2.2_2.3_1.4_1.5_1.6_1/gt0_ssnp_1_2.2_2.3_1.4_1.5_1.6_1.RData")

snpselect_gt_ssnp_1_2.2_2.3_1.4_1.5_1.6_1 <- rep(FALSE, ncol(gt_ssnp_1_2.2_2.3_1.4_1.5_1))
snpselect_gt_ssnp_1_2.2_2.3_1.4_1.5_1.6_1[seq(1, ncol(gt_ssnp_1_2.2_2.3_1.4_1.5_1), by = 2)] <- TRUE #creates logical vector of which snps are selected in each subset (for GRM script)
snppos_ssnp_1_2.2_2.3_1.4_1.5_1.6_1 <- snppos_ssnp_1_2.2_2.3_1.4_1.5_1[snpselect_gt_ssnp_1_2.2_2.3_1.4_1.5_1.6_1, ]
save(snppos_ssnp_1_2.2_2.3_1.4_1.5_1.6_1, file = "Data/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_2.2_2.3_1.4_1.5_1.6_1/snppos_ssnp_1_2.2_2.3_1.4_1.5_1.6_1.RData")


###### Seventh level subset ######
# 230 markers

# level 1 sub 1, level 2 sub 1, level 3 sub 1, level 4 sub 1, level 5 sub 1, level 6 sub 1, level 7 sub 1; 1_1.2_1.3_1.4_1.5_1.6_1.7_1  
gt_ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1 <- gt_ssnp_1_1.2_1.3_1.4_1.5_1.6_1[ ,seq(1, ncol(gt_ssnp_1_1.2_1.3_1.4_1.5_1.6_1), by = 2)]
gt0_ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1 <- gt_ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1
save(gt0_ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1, file = "Data/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1/gt0_ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1.RData")

snpselect_gt_ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1 <- rep(FALSE, ncol(gt_ssnp_1_1.2_1.3_1.4_1.5_1.6_1))
snpselect_gt_ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1[seq(1, ncol(gt_ssnp_1_1.2_1.3_1.4_1.5_1.6_1), by = 2)] <- TRUE #creates logical vector of which snps are selected in each subset (for GRM script)
snppos_ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1 <- snppos_ssnp_1_1.2_1.3_1.4_1.5_1.6_1[snpselect_gt_ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1, ]
save(snppos_ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1, file = "Data/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1/snppos_ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1.RData")

# level 1 sub 1, level 2 sub 2, level 3 sub 1, level 4 sub 1, level 5 sub 1, level 6 sub 1, level 7 sub 1; 1_1.2_1.3_1.4_1.5_1.6_1.7_1
gt_ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1 <- gt_ssnp_1_1.2_2.3_1.4_1.5_1.6_1[ ,seq(1, ncol(gt_ssnp_1_1.2_2.3_1.4_1.5_1.6_1), by = 2)]
gt0_ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1 <- gt_ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1
save(gt0_ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1, file = "Data/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1/gt0_ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1.RData")

snpselect_gt_ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1 <- rep(FALSE, ncol(gt_ssnp_1_1.2_2.3_1.4_1.5_1.6_1))
snpselect_gt_ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1[seq(1, ncol(gt_ssnp_1_1.2_2.3_1.4_1.5_1.6_1), by = 2)] <- TRUE #creates logical vector of which snps are selected in each subset (for GRM script)
snppos_ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1 <- snppos_ssnp_1_1.2_2.3_1.4_1.5_1.6_1[snpselect_gt_ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1, ]
save(snppos_ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1, file = "Data/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1/snppos_ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1.RData")

# level 1 sub 2, level 2 sub 1, level 3 sub 1, level 4 sub 1, level 5 sub 1, level 6 sub 1, level 7 sub 1; 1_2.2_1.3_1.4_1.5_1.6_1.7_1
gt_ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1 <- gt_ssnp_1_2.2_1.3_1.4_1.5_1.6_1[ ,seq(1, ncol(gt_ssnp_1_2.2_1.3_1.4_1.5_1.6_1), by = 2)]
gt0_ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1 <- gt_ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1
save(gt0_ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1, file = "Data/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1/gt0_ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1.RData")

snpselect_gt_ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1 <- rep(FALSE, ncol(gt_ssnp_1_2.2_1.3_1.4_1.5_1.6_1))
snpselect_gt_ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1[seq(1, ncol(gt_ssnp_1_2.2_1.3_1.4_1.5_1.6_1), by = 2)] <- TRUE #creates logical vector of which snps are selected in each subset (for GRM script)
snppos_ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1 <- snppos_ssnp_1_2.2_1.3_1.4_1.5_1.6_1[snpselect_gt_ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1, ]
save(snppos_ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1, file = "Data/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1/snppos_ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1.RData")

# level 1 sub 2, level 2 sub 2, level 3 sub 1, level 4 sub 1, level 5 sub 1, level 6 sub 1, level 7 sub 1; 1_2.2_2.3_1.4_1.5_1.6_1.7_1
gt_ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1 <- gt_ssnp_1_2.2_2.3_1.4_1.5_1.6_1[ ,seq(1, ncol(gt_ssnp_1_2.2_2.3_1.4_1.5_1.6_1), by = 2)]
gt0_ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1 <- gt_ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1
save(gt0_ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1, file = "Data/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1/gt0_ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1.RData")

snpselect_gt_ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1 <- rep(FALSE, ncol(gt_ssnp_1_2.2_2.3_1.4_1.5_1.6_1))
snpselect_gt_ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1[seq(1, ncol(gt_ssnp_1_2.2_2.3_1.4_1.5_1.6_1), by = 2)] <- TRUE #creates logical vector of which snps are selected in each subset (for GRM script)
snppos_ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1 <- snppos_ssnp_1_2.2_2.3_1.4_1.5_1.6_1[snpselect_gt_ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1, ]
save(snppos_ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1, file = "Data/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1/snppos_ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1.RData")


###### Eighth level subset ######
# 115 markers

# level 1 sub 1, level 2 sub 1, level 3 sub 1, level 4 sub 1, level 5 sub 1, level 6 sub 1, level 7 sub 1, level 8 sub 1; 1_1.2_1.3_1.4_1.5_1.6_1.7_1.8_1  
gt_ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1.8_1 <- gt_ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1[ ,seq(1, ncol(gt_ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1), by = 2)]
gt0_ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1.8_1 <- gt_ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1.8_1
save(gt0_ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1.8_1, file = "Data/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1.8_1/gt0_ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1.8_1.RData")

snpselect_gt_ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1.8_1 <- rep(FALSE, ncol(gt_ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1))
snpselect_gt_ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1.8_1[seq(1, ncol(gt_ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1), by = 2)] <- TRUE #creates logical vector of which snps are selected in each subset (for GRM script)
snppos_ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1.8_1 <- snppos_ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1[snpselect_gt_ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1.8_1, ]
save(snppos_ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1.8_1, file = "Data/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1.8_1/snppos_ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1.8_1.RData")

# level 1 sub 1, level 2 sub 2, level 3 sub 1, level 4 sub 1, level 5 sub 1, level 6 sub 1, level 7 sub 1, level 8 sub 1; 1_1.2_1.3_1.4_1.5_1.6_1.7_1.8_1
gt_ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1.8_1 <- gt_ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1[ ,seq(1, ncol(gt_ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1), by = 2)]
gt0_ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1.8_1 <- gt_ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1.8_1
save(gt0_ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1.8_1, file = "Data/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1.8_1/gt0_ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1.8_1.RData")

snpselect_gt_ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1.8_1 <- rep(FALSE, ncol(gt_ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1))
snpselect_gt_ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1.8_1[seq(1, ncol(gt_ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1), by = 2)] <- TRUE #creates logical vector of which snps are selected in each subset (for GRM script)
snppos_ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1.8_1 <- snppos_ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1[snpselect_gt_ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1.8_1, ]
save(snppos_ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1.8_1, file = "Data/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1.8_1/snppos_ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1.8_1.RData")

# level 1 sub 2, level 2 sub 1, level 3 sub 1, level 4 sub 1, level 5 sub 1, level 6 sub 1, level 7 sub 1, level 8 sub 1; 1_2.2_1.3_1.4_1.5_1.6_1.7_1.8_1
gt_ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1.8_1 <- gt_ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1[ ,seq(1, ncol(gt_ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1), by = 2)]
gt0_ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1.8_1 <- gt_ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1.8_1
save(gt0_ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1.8_1, file = "Data/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1.8_1/gt0_ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1.8_1.RData")

snpselect_gt_ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1.8_1 <- rep(FALSE, ncol(gt_ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1))
snpselect_gt_ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1.8_1[seq(1, ncol(gt_ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1), by = 2)] <- TRUE #creates logical vector of which snps are selected in each subset (for GRM script)
snppos_ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1.8_1 <- snppos_ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1[snpselect_gt_ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1.8_1, ]
save(snppos_ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1.8_1, file = "Data/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1.8_1/snppos_ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1.8_1.RData")

# level 1 sub 2, level 2 sub 2, level 3 sub 1, level 4 sub 1, level 5 sub 1, level 6 sub 1, level 7 sub 1, level 8 sub 1; 1_2.2_2.3_1.4_1.5_1.6_1.7_1.8_1
gt_ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1.8_1 <- gt_ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1[ ,seq(1, ncol(gt_ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1), by = 2)]
gt0_ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1.8_1 <- gt_ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1.8_1
save(gt0_ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1.8_1, file = "Data/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1.8_1/gt0_ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1.8_1.RData")

snpselect_gt_ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1.8_1 <- rep(FALSE, ncol(gt_ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1))
snpselect_gt_ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1.8_1[seq(1, ncol(gt_ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1), by = 2)] <- TRUE #creates logical vector of which snps are selected in each subset (for GRM script)
snppos_ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1.8_1 <- snppos_ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1[snpselect_gt_ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1.8_1, ]
save(snppos_ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1.8_1, file = "Data/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1.8_1/snppos_ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1.8_1.RData")


###### Ninth level ######
# 12 markers (shift to every tenth, to get a minimal model, to estimate the correlation with no viable genetic information as input)

# level 1 sub 1, level 2 sub 1, level 3 sub 1, level 4 sub 1, level 5 sub 1, level 6 sub 1, level 7 sub 1, level 8 sub 1, level 9; 1_1.2_1.3_1.4_1.5_1.6_1.7_1.8_1.9  
gt_ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1.8_1.9 <- gt_ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1.8_1[ ,seq(1, ncol(gt_ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1.8_1), by = 10)]
gt0_ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1.8_1.9 <- gt_ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1.8_1.9
save(gt0_ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1.8_1.9, file = "Data/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1.8_1.9/gt0_ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1.8_1.9.RData")

snpselect_gt_ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1.8_1.9 <- rep(FALSE, ncol(gt_ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1.8_1))
snpselect_gt_ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1.8_1.9[seq(1, ncol(gt_ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1.8_1), by = 10)] <- TRUE #creates logical vector of which snps are selected in each subset (for GRM script)
snppos_ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1.8_1.9 <- snppos_ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1.8_1[snpselect_gt_ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1.8_1.9, ]
save(snppos_ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1.8_1.9, file = "Data/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1.8_1.9/snppos_ssnp_1_1.2_1.3_1.4_1.5_1.6_1.7_1.8_1.9.RData")

# level 1 sub 1, level 2 sub 2, level 3 sub 1, level 4 sub 1, level 5 sub 1, level 6 sub 1, level 7 sub 1, level 8 sub 1; 1_1.2_1.3_1.4_1.5_1.6_1.7_1.8_1.9
gt_ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1.8_1.9 <- gt_ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1.8_1[ ,seq(1, ncol(gt_ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1.8_1), by = 10)]
gt0_ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1.8_1.9 <- gt_ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1.8_1.9
save(gt0_ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1.8_1.9, file = "Data/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1.8_1.9/gt0_ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1.8_1.9.RData")

snpselect_gt_ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1.8_1.9 <- rep(FALSE, ncol(gt_ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1.8_1))
snpselect_gt_ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1.8_1.9[seq(1, ncol(gt_ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1.8_1), by = 10)] <- TRUE #creates logical vector of which snps are selected in each subset (for GRM script)
snppos_ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1.8_1.9 <- snppos_ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1.8_1[snpselect_gt_ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1.8_1.9, ]
save(snppos_ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1.8_1.9, file = "Data/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1.8_1.9/snppos_ssnp_1_1.2_2.3_1.4_1.5_1.6_1.7_1.8_1.9.RData")

# level 1 sub 2, level 2 sub 1, level 3 sub 1, level 4 sub 1, level 5 sub 1, level 6 sub 1, level 7 sub 1, level 8 sub 1; 1_2.2_1.3_1.4_1.5_1.6_1.7_1.8_1.9
gt_ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1.8_1.9 <- gt_ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1.8_1[ ,seq(1, ncol(gt_ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1.8_1), by = 10)]
gt0_ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1.8_1.9 <- gt_ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1.8_1.9
save(gt0_ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1.8_1.9, file = "Data/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1.8_1.9/gt0_ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1.8_1.9.RData")

snpselect_gt_ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1.8_1.9 <- rep(FALSE, ncol(gt_ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1.8_1))
snpselect_gt_ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1.8_1.9[seq(1, ncol(gt_ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1.8_1), by = 10)] <- TRUE #creates logical vector of which snps are selected in each subset (for GRM script)
snppos_ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1.8_1.9 <- snppos_ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1.8_1[snpselect_gt_ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1.8_1.9, ]
save(snppos_ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1.8_1.9, file = "Data/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1.8_1.9/snppos_ssnp_1_2.2_1.3_1.4_1.5_1.6_1.7_1.8_1.9.RData")

# level 1 sub 2, level 2 sub 2, level 3 sub 1, level 4 sub 1, level 5 sub 1, level 6 sub 1, level 7 sub 1, level 8 sub 1; 1_2.2_2.3_1.4_1.5_1.6_1.7_1.8_1.9
gt_ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1.8_1.9 <- gt_ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1.8_1[ ,seq(1, ncol(gt_ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1.8_1), by = 10)]
gt0_ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1.8_1.9 <- gt_ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1.8_1.9
save(gt0_ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1.8_1.9, file = "Data/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1.8_1.9/gt0_ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1.8_1.9.RData")

snpselect_gt_ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1.8_1.9 <- rep(FALSE, ncol(gt_ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1.8_1))
snpselect_gt_ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1.8_1.9[seq(1, ncol(gt_ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1.8_1), by = 10)] <- TRUE #creates logical vector of which snps are selected in each subset (for GRM script)
snppos_ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1.8_1.9 <- snppos_ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1.8_1[snpselect_gt_ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1.8_1.9, ]
save(snppos_ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1.8_1.9, file = "Data/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1.8_1.9/snppos_ssnp_1_2.2_2.3_1.4_1.5_1.6_1.7_1.8_1.9.RData")
