#!/usr/bin/env Rscript
## Script: create GS models
# TRAA September 2023

# subjects (for training): MASPOT
# variants: ssnp_0
# Trait: #GIC + SP2 + UU2 + TP2 + LW + NDV
# Model: GBLUP

###### Set working directory ######
setwd("/MASPOT/GS")
rm(list = ls())
library(BGLR)

###### Load data elements ######
load("Data/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/gt_ssnp_0.RData")
load("Data/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/pt_ssnp_0.RData")
load("Data/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/G_ssnp_0.RData")
load("Data/CV_MASPOT_8fold_ssnp.RData")

gt = gt_ssnp_0
pt = pt_ssnp_0
G = G_ssnp_0

pt["CV"] = CV_MASPOT_8fold$CV08

###### Make CV lists ######

list_CVtestpanel = NULL; for(i in 1:8){
  list = pt[pt$CV == i, c("SOR", "CV")];
  list_CVtestpanel = rbind(list_CVtestpanel, list)}

list_CVtestpanel_train = NULL; for(i in 1:8){
  list = pt[pt$CV == i, c("SOR","CV")];
  list_CVtestpanel_train = rbind(list_CVtestpanel_train,list)} 

###### Model parameters ######

# number of iterations and burn-in
nIter = 12000
burnIn = 2000

###### train GBLUP models for each traits and extract predictions ######

### GIC ###

yHat.gb_GIC_test = NULL;
yHat.gb_GIC_train = NULL;
yHat.gb_GIC_all_CV08 = list();
for(i in 1:8){
  ptNA=pt$GIC;
  ptNA[pt$CV == i]=NA; # blanks the phenotypes for those in the testset for each cross validation fold, i.e. i
  ETA.gb = list(list(K=G, model = "RKHS"));
  fit.gb_GIC = BGLR(ptNA,ETA=ETA.gb,nIter = nIter, burnIn = burnIn, saveAt = "Models/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/out/gb_GIC_CV08_");
  yHat.gb_GIC_all_CV08[[i]] = fit.gb_GIC$yHat;
  yHat.gb_GIC_test = c(yHat.gb_GIC_test,fit.gb_GIC$yHat[pt$CV == i]);
  yHat.gb_GIC_train = c(yHat.gb_GIC_train,fit.gb_GIC$yHat[pt$CV != i])
}

# Extract predictions for each cultivar in test and training 

yHat.gb_GIC=cbind(list_CVtestpanel,yHat.gb_GIC_test) #yhat for each cultivar when used in test set (used in 1 of 8 folds as test set)
yHat.gb_GIC_CV08=yHat.gb_GIC[order(yHat.gb_GIC$SOR),c("SOR","yHat.gb_GIC_test")] # remove CV column and order according to cultivar name
save(yHat.gb_GIC_CV08,file="Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/yHat.gb_GIC_CV08.RData") #the yHat (predicted phenotypes) for each cultivar when it was in a testset in 8fold CV

yHat.gb_GIC_train=cbind(list_CVtestpanel_train,yHat.gb_GIC_train) # yHat for each cultivar in each training run (each used in 7 of 8 folds as training set)
yHat_mean=aggregate(yHat.gb_GIC_train ~. , mean, data=yHat.gb_GIC_train) # mean yHat for each cultivar across 7 folds of training
yHat_SD=aggregate(yHat.gb_GIC_train ~. , sd, data=yHat.gb_GIC_train) # SD yHat for each cultivar across 7 folds of training 
yHat.gb_GIC_train=cbind(yHat_mean[,c("SOR","yHat.gb_GIC_train")],yHat_SD[,"yHat.gb_GIC_train"])
yHat.gb_GIC_train_CV08=yHat.gb_GIC_train[order(yHat.gb_GIC_train$SOR),]
save(yHat.gb_GIC_train_CV08,file="Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/yHat.gb_GIC_train_CV08.RData")

save(yHat.gb_GIC_all_CV08,file="Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/yHat.gb_GIC_all_CV08.RData")


### SP2 ###

yHat.gb_SP2_test = NULL;
yHat.gb_SP2_train = NULL;
yHat.gb_SP2_all_CV08 = list();
for(i in 1:8){
  ptNA=pt$SP2;
  ptNA[pt$CV == i]=NA; # blanks the phenotypes for those in the testset for each cross validation fold, i.e. i
  ETA.gb = list(list(K=G, model = "RKHS"));
  fit.gb_SP2 = BGLR(ptNA,ETA=ETA.gb,nIter = nIter, burnIn = burnIn, saveAt = "Models/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/out/gb_SP2_CV08_");
  yHat.gb_SP2_all_CV08[[i]] = fit.gb_SP2$yHat;
  yHat.gb_SP2_test = c(yHat.gb_SP2_test,fit.gb_SP2$yHat[pt$CV == i]);
  yHat.gb_SP2_train = c(yHat.gb_SP2_train,fit.gb_SP2$yHat[pt$CV != i])
}

# Extract predictions for each cultivar in test and training 

yHat.gb_SP2=cbind(list_CVtestpanel,yHat.gb_SP2_test) #yhat for each cultivar when used in test set (used in 1 of 8 folds as test set)
yHat.gb_SP2_CV08=yHat.gb_SP2[order(yHat.gb_SP2$SOR),c("SOR","yHat.gb_SP2_test")] # remove CV column and order according to cultivar name
save(yHat.gb_SP2_CV08,file="Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/yHat.gb_SP2_CV08.RData") #the yHat (predicted phenotypes) for each cultivar when it was in a testset in 8fold CV

yHat.gb_SP2_train=cbind(list_CVtestpanel_train,yHat.gb_SP2_train) # yHat for each cultivar in each training run (each used in 7 of 8 folds as training set)
yHat_mean=aggregate(yHat.gb_SP2_train ~. , mean, data=yHat.gb_SP2_train) # mean yHat for each cultivar across 7 folds of training
yHat_SD=aggregate(yHat.gb_SP2_train ~. , sd, data=yHat.gb_SP2_train) # SD yHat for each cultivar across 7 folds of training 
yHat.gb_SP2_train=cbind(yHat_mean[,c("SOR","yHat.gb_SP2_train")],yHat_SD[,"yHat.gb_SP2_train"])
yHat.gb_SP2_train_CV08=yHat.gb_SP2_train[order(yHat.gb_SP2_train$SOR),]
save(yHat.gb_SP2_train_CV08,file="Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/yHat.gb_SP2_train_CV08.RData")

save(yHat.gb_SP2_all_CV08,file="Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/yHat.gb_SP2_all_CV08.RData")

### TP2 ###

yHat.gb_TP2_test = NULL;
yHat.gb_TP2_train = NULL;
yHat.gb_TP2_all_CV08 = list();
for(i in 1:8){
  ptNA=pt$TP2;
  ptNA[pt$CV == i]=NA; # blanks the phenotypes for those in the testset for each cross validation fold, i.e. i
  ETA.gb = list(list(K=G, model = "RKHS"));
  fit.gb_TP2 = BGLR(ptNA,ETA=ETA.gb,nIter = nIter, burnIn = burnIn, saveAt = "Models/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/out/gb_TP2_CV08_");
  yHat.gb_TP2_all_CV08[[i]] = fit.gb_TP2$yHat;
  yHat.gb_TP2_test = c(yHat.gb_TP2_test,fit.gb_TP2$yHat[pt$CV == i]);
  yHat.gb_TP2_train = c(yHat.gb_TP2_train,fit.gb_TP2$yHat[pt$CV != i])
}

# Extract predictions for each cultivar in test and training 

yHat.gb_TP2=cbind(list_CVtestpanel,yHat.gb_TP2_test) #yhat for each cultivar when used in test set (used in 1 of 8 folds as test set)
yHat.gb_TP2_CV08=yHat.gb_TP2[order(yHat.gb_TP2$SOR),c("SOR","yHat.gb_TP2_test")] # remove CV column and order according to cultivar name
save(yHat.gb_TP2_CV08,file="Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/yHat.gb_TP2_CV08.RData") #the yHat (predicted phenotypes) for each cultivar when it was in a testset in 8fold CV

yHat.gb_TP2_train=cbind(list_CVtestpanel_train,yHat.gb_TP2_train) # yHat for each cultivar in each training run (each used in 7 of 8 folds as training set)
yHat_mean=aggregate(yHat.gb_TP2_train ~. , mean, data=yHat.gb_TP2_train) # mean yHat for each cultivar across 7 folds of training
yHat_SD=aggregate(yHat.gb_TP2_train ~. , sd, data=yHat.gb_TP2_train) # SD yHat for each cultivar across 7 folds of training 
yHat.gb_TP2_train=cbind(yHat_mean[,c("SOR","yHat.gb_TP2_train")],yHat_SD[,"yHat.gb_TP2_train"])
yHat.gb_TP2_train_CV08=yHat.gb_TP2_train[order(yHat.gb_TP2_train$SOR),]
save(yHat.gb_TP2_train_CV08,file="Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/yHat.gb_TP2_train_CV08.RData")

save(yHat.gb_TP2_all_CV08,file="Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/yHat.gb_TP2_all_CV08.RData")


### UU2 ###

yHat.gb_UU2_test = NULL;
yHat.gb_UU2_train = NULL;
yHat.gb_UU2_all_CV08 = list();
for(i in 1:8){
  ptNA=pt$UU2;
  ptNA[pt$CV == i]=NA; # blanks the phenotypes for those in the testset for each cross validation fold, i.e. i
  ETA.gb = list(list(K=G, model = "RKHS"));
  fit.gb_UU2 = BGLR(ptNA,ETA=ETA.gb,nIter = nIter, burnIn = burnIn, saveAt = "Models/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/out/gb_UU2_CV08_");
  yHat.gb_UU2_all_CV08[[i]] = fit.gb_UU2$yHat;
  yHat.gb_UU2_test = c(yHat.gb_UU2_test,fit.gb_UU2$yHat[pt$CV == i]);
  yHat.gb_UU2_train = c(yHat.gb_UU2_train,fit.gb_UU2$yHat[pt$CV != i])
}

# Extract predictions for each cultivar in test and training 

yHat.gb_UU2=cbind(list_CVtestpanel,yHat.gb_UU2_test) #yhat for each cultivar when used in test set (used in 1 of 8 folds as test set)
yHat.gb_UU2_CV08=yHat.gb_UU2[order(yHat.gb_UU2$SOR),c("SOR","yHat.gb_UU2_test")] # remove CV column and order according to cultivar name
save(yHat.gb_UU2_CV08,file="Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/yHat.gb_UU2_CV08.RData") #the yHat (predicted phenotypes) for each cultivar when it was in a testset in 8fold CV

yHat.gb_UU2_train=cbind(list_CVtestpanel_train,yHat.gb_UU2_train) # yHat for each cultivar in each training run (each used in 7 of 8 folds as training set)
yHat_mean=aggregate(yHat.gb_UU2_train ~. , mean, data=yHat.gb_UU2_train) # mean yHat for each cultivar across 7 folds of training
yHat_SD=aggregate(yHat.gb_UU2_train ~. , sd, data=yHat.gb_UU2_train) # SD yHat for each cultivar across 7 folds of training 
yHat.gb_UU2_train=cbind(yHat_mean[,c("SOR","yHat.gb_UU2_train")],yHat_SD[,"yHat.gb_UU2_train"])
yHat.gb_UU2_train_CV08=yHat.gb_UU2_train[order(yHat.gb_UU2_train$SOR),]
save(yHat.gb_UU2_train_CV08,file="Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/yHat.gb_UU2_train_CV08.RData")

save(yHat.gb_UU2_all_CV08,file="Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/yHat.gb_UU2_all_CV08.RData")


### LW ###

yHat.gb_LW_test = NULL;
yHat.gb_LW_train = NULL;
yHat.gb_LW_all_CV08 = list();
for(i in 1:8){
  ptNA=pt$LW;
  ptNA[pt$CV == i]=NA; # blanks the phenotypes for those in the testset for each cross validation fold, i.e. i
  ETA.gb = list(list(K=G, model = "RKHS"));
  fit.gb_LW = BGLR(ptNA,ETA=ETA.gb,nIter = nIter, burnIn = burnIn, saveAt = "Models/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/out/gb_LW_CV08_");
  yHat.gb_LW_all_CV08[[i]] = fit.gb_LW$yHat;
  yHat.gb_LW_test = c(yHat.gb_LW_test,fit.gb_LW$yHat[pt$CV == i]);
  yHat.gb_LW_train = c(yHat.gb_LW_train,fit.gb_LW$yHat[pt$CV != i])
}

# Extract predictions for each cultivar in test and training 

yHat.gb_LW=cbind(list_CVtestpanel,yHat.gb_LW_test) #yhat for each cultivar when used in test set (used in 1 of 8 folds as test set)
yHat.gb_LW_CV08=yHat.gb_LW[order(yHat.gb_LW$SOR),c("SOR","yHat.gb_LW_test")] # remove CV column and order according to cultivar name
save(yHat.gb_LW_CV08,file="Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/yHat.gb_LW_CV08.RData") #the yHat (predicted phenotypes) for each cultivar when it was in a testset in 8fold CV

yHat.gb_LW_train=cbind(list_CVtestpanel_train,yHat.gb_LW_train) # yHat for each cultivar in each training run (each used in 7 of 8 folds as training set)
yHat_mean=aggregate(yHat.gb_LW_train ~. , mean, data=yHat.gb_LW_train) # mean yHat for each cultivar across 7 folds of training
yHat_SD=aggregate(yHat.gb_LW_train ~. , sd, data=yHat.gb_LW_train) # SD yHat for each cultivar across 7 folds of training 
yHat.gb_LW_train=cbind(yHat_mean[,c("SOR","yHat.gb_LW_train")],yHat_SD[,"yHat.gb_LW_train"])
yHat.gb_LW_train_CV08=yHat.gb_LW_train[order(yHat.gb_LW_train$SOR),]
save(yHat.gb_LW_train_CV08,file="Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/yHat.gb_LW_train_CV08.RData")

save(yHat.gb_LW_all_CV08,file="Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/yHat.gb_LW_all_CV08.RData")


### NDV ###

yHat.gb_NDV_test = NULL;
yHat.gb_NDV_train = NULL;
yHat.gb_NDV_all_CV08 = list();
for(i in 1:8){
  ptNA=pt$NDV;
  ptNA[pt$CV == i]=NA; # blanks the phenotypes for those in the testset for each cross validation fold, i.e. i
  ETA.gb = list(list(K=G, model = "RKHS"));
  fit.gb_NDV = BGLR(ptNA,ETA=ETA.gb,nIter = nIter, burnIn = burnIn, saveAt = "Models/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/out/gb_NDV_CV08_");
  yHat.gb_NDV_all_CV08[[i]] = fit.gb_NDV$yHat;
  yHat.gb_NDV_test = c(yHat.gb_NDV_test,fit.gb_NDV$yHat[pt$CV == i]);
  yHat.gb_NDV_train = c(yHat.gb_NDV_train,fit.gb_NDV$yHat[pt$CV != i])
}

# Extract predictions for each cultivar in test and training 

yHat.gb_NDV=cbind(list_CVtestpanel,yHat.gb_NDV_test) #yhat for each cultivar when used in test set (used in 1 of 8 folds as test set)
yHat.gb_NDV_CV08=yHat.gb_NDV[order(yHat.gb_NDV$SOR),c("SOR","yHat.gb_NDV_test")] # remove CV column and order according to cultivar name
save(yHat.gb_NDV_CV08,file="Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/yHat.gb_NDV_CV08.RData") #the yHat (predicted phenotypes) for each cultivar when it was in a testset in 8fold CV

yHat.gb_NDV_train=cbind(list_CVtestpanel_train,yHat.gb_NDV_train) # yHat for each cultivar in each training run (each used in 7 of 8 folds as training set)
yHat_mean=aggregate(yHat.gb_NDV_train ~. , mean, data=yHat.gb_NDV_train) # mean yHat for each cultivar across 7 folds of training
yHat_SD=aggregate(yHat.gb_NDV_train ~. , sd, data=yHat.gb_NDV_train) # SD yHat for each cultivar across 7 folds of training 
yHat.gb_NDV_train=cbind(yHat_mean[,c("SOR","yHat.gb_NDV_train")],yHat_SD[,"yHat.gb_NDV_train"])
yHat.gb_NDV_train_CV08=yHat.gb_NDV_train[order(yHat.gb_NDV_train$SOR),]
save(yHat.gb_NDV_train_CV08,file="Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/yHat.gb_NDV_train_CV08.RData")

save(yHat.gb_NDV_all_CV08,file="Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/yHat.gb_NDV_all_CV08.RData")




###### Correlation and bias (yHat stats) ######


### GIC ###

stats_yHat_GIC_CV08=rbind(cor(pt$GIC, yHat.gb_GIC_CV08$yHat.gb_GIC_test, use = "pair"),
                          lm(pt$GIC~yHat.gb_GIC_CV08$yHat.gb_GIC_test)$coefficients[2])
rownames(stats_yHat_GIC_CV08)=c("Correlation",
                                "Bias")
colnames(stats_yHat_GIC_CV08)="MASPOT"
stats_yHat_GIC_CV08=round(stats_yHat_GIC_CV08,3)
show(stats_yHat_GIC_CV08)
save(stats_yHat_GIC_CV08,file="Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/stats_yHat_GIC_CV08.RData")


### SP2 ###

stats_yHat_SP2_CV08=rbind(cor(pt$SP2, yHat.gb_SP2_CV08$yHat.gb_SP2_test, use = "pair"),
                          lm(pt$SP2~yHat.gb_SP2_CV08$yHat.gb_SP2_test)$coefficients[2])
rownames(stats_yHat_SP2_CV08)=c("Correlation",
                                "Bias")
colnames(stats_yHat_SP2_CV08)="MASPOT"
stats_yHat_SP2_CV08=round(stats_yHat_SP2_CV08,3)
show(stats_yHat_SP2_CV08)
save(stats_yHat_SP2_CV08,file="Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/stats_yHat_SP2_CV08.RData")


### TP2 ###

stats_yHat_TP2_CV08=rbind(cor(pt$TP2, yHat.gb_TP2_CV08$yHat.gb_TP2_test, use = "pair"),
                          lm(pt$TP2~yHat.gb_TP2_CV08$yHat.gb_TP2_test)$coefficients[2])
rownames(stats_yHat_TP2_CV08)=c("Correlation",
                                "Bias")
colnames(stats_yHat_TP2_CV08)="MASPOT"
stats_yHat_TP2_CV08=round(stats_yHat_TP2_CV08,3)
show(stats_yHat_TP2_CV08)
save(stats_yHat_TP2_CV08,file="Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/stats_yHat_TP2_CV08.RData")



### UU2 ###

stats_yHat_UU2_CV08=rbind(cor(pt$UU2, yHat.gb_UU2_CV08$yHat.gb_UU2_test, use = "pair"),
                          lm(pt$UU2~yHat.gb_UU2_CV08$yHat.gb_UU2_test)$coefficients[2])
rownames(stats_yHat_UU2_CV08)=c("Correlation",
                                "Bias")
colnames(stats_yHat_UU2_CV08)="MASPOT"
stats_yHat_UU2_CV08=round(stats_yHat_UU2_CV08,3)
show(stats_yHat_UU2_CV08)
save(stats_yHat_UU2_CV08,file="Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/stats_yHat_UU2_CV08.RData")


### LW ###

stats_yHat_LW_CV08=rbind(cor(pt$LW, yHat.gb_LW_CV08$yHat.gb_LW_test, use = "pair"),
                         lm(pt$LW~yHat.gb_LW_CV08$yHat.gb_LW_test)$coefficients[2])
rownames(stats_yHat_LW_CV08)=c("Correlation",
                               "Bias")
colnames(stats_yHat_LW_CV08)="MASPOT"
stats_yHat_LW_CV08=round(stats_yHat_LW_CV08,3)
show(stats_yHat_LW_CV08)
save(stats_yHat_LW_CV08,file="Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/stats_yHat_LW_CV08.RData")


### NDV ###

stats_yHat_NDV_CV08=rbind(cor(pt$NDV, yHat.gb_NDV_CV08$yHat.gb_NDV_test, use = "pair"),
                          lm(pt$NDV~yHat.gb_NDV_CV08$yHat.gb_NDV_test)$coefficients[2])
rownames(stats_yHat_NDV_CV08)=c("Correlation",
                                "Bias")
colnames(stats_yHat_NDV_CV08)="MASPOT"
stats_yHat_NDV_CV08=round(stats_yHat_NDV_CV08,3)
show(stats_yHat_NDV_CV08)
save(stats_yHat_NDV_CV08,file="Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/stats_yHat_NDV_CV08.RData")











