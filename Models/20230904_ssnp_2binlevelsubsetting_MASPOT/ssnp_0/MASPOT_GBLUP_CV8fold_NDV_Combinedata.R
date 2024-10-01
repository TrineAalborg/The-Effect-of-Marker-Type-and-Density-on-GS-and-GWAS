#!/usr/bin/env Rscript
## Script: combine stats
# TRAA September 2023

# subjects (for training): MASPOT 
# variants: ssnp_0
# Trait: NDV (chipping quality)
# Model: GBLUP

###### Set working directory ######
setwd("/home/bio.aau.dk/vm82rp/MASPOT/GS")

library(BGLR)
library(ggplot2)
library(ggpmisc)
library(ggthemes)
library(cowplot)

###### Load data elements ######
load("Data/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/pt_ssnp_0.RData")

pt=pt_ssnp_0

load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/yHat.gb_NDV_CV01.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/yHat.gb_NDV_CV02.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/yHat.gb_NDV_CV03.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/yHat.gb_NDV_CV04.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/yHat.gb_NDV_CV05.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/yHat.gb_NDV_CV06.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/yHat.gb_NDV_CV07.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/yHat.gb_NDV_CV08.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/yHat.gb_NDV_CV09.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/yHat.gb_NDV_CV10.RData")

###### Combine to find overall correlation and bias ######

yHat_NDV=data.frame("CV01"=yHat.gb_NDV_CV01$yHat.gb_NDV_test,
                    "CV02"=yHat.gb_NDV_CV02$yHat.gb_NDV_test,
                    "CV03"=yHat.gb_NDV_CV03$yHat.gb_NDV_test,
                    "CV04"=yHat.gb_NDV_CV04$yHat.gb_NDV_test,
                    "CV05"=yHat.gb_NDV_CV05$yHat.gb_NDV_test,
                    "CV06"=yHat.gb_NDV_CV06$yHat.gb_NDV_test,
                    "CV07"=yHat.gb_NDV_CV07$yHat.gb_NDV_test,
                    "CV08"=yHat.gb_NDV_CV08$yHat.gb_NDV_test,
                    "CV09"=yHat.gb_NDV_CV09$yHat.gb_NDV_test,
                    "CV10"=yHat.gb_NDV_CV10$yHat.gb_NDV_test)

stats_NDV=cbind(t(cor(pt$NDV, yHat_NDV, use = "pair")),
                c(lm(pt$NDV~yHat_NDV[,1])$coefficients[2],
                  lm(pt$NDV~yHat_NDV[,2])$coefficients[2],
                  lm(pt$NDV~yHat_NDV[,3])$coefficients[2],
                  lm(pt$NDV~yHat_NDV[,4])$coefficients[2],
                  lm(pt$NDV~yHat_NDV[,5])$coefficients[2],
                  lm(pt$NDV~yHat_NDV[,6])$coefficients[2],
                  lm(pt$NDV~yHat_NDV[,7])$coefficients[2],
                  lm(pt$NDV~yHat_NDV[,8])$coefficients[2],
                  lm(pt$NDV~yHat_NDV[,9])$coefficients[2],
                  lm(pt$NDV~yHat_NDV[,10])$coefficients[2]))
colnames(stats_NDV)=c("Correlation",
                      "Bias")
stats_NDV=as.data.frame(stats_NDV)
rownames(stats_NDV)=NULL
stats_NDV["CV"]=rep(1:10)
stats_NDV["Trait"]="NDV"
stats_NDV["Panel"]="MASPOT"
stats_NDV["Training"]="MASPOT"
stats_NDV["Method"]="ssnp_0"
stats_NDV["Model"]="GBLUP"
stats_NDV[,1:2]=round(stats_NDV[,1:2],3)
show(stats_NDV)

###### Plot predicted phenotype vs observed ######

yHat_NDV["Mean"]=apply(yHat_NDV[,c(1:10)],1,mean)
yHat_NDV["SD"]=apply(yHat_NDV[,c(1:10)],1,sd)
yHat_NDV["PT"]=pt$NDV
yHat_NDV["Trait"]="NDV"
yHat_NDV["Panel"]="MASPOT"
yHat_NDV["Training"]="MASPOT"
yHat_NDV["Method"]="ssnp_0"
yHat_NDV["Model"]="GBLUP"
yHat_NDV["SOR"]=pt$SOR
yHat_NDV[,1:12]=round(yHat_NDV[,1:12],3)
head(yHat_NDV)

stats_NDV_mean=data.frame(Mean_mean=c(cor(pt$NDV, yHat_NDV$Mean, use = "pair"),
                                      lm(pt$NDV~yHat_NDV$Mean)$coefficients[2]),
                          Mean_stats=c(aggregate(Correlation~Panel,stats_NDV,mean)$Correlation,
                                       aggregate(Bias~Panel,stats_NDV,mean)$Bias),
                          Min=c(aggregate(Correlation~Panel,stats_NDV,min)$Correlation,
                                aggregate(Bias~Panel,stats_NDV,min)$Bias),
                          Max=c(aggregate(Correlation~Panel,stats_NDV,max)$Correlation,
                                aggregate(Bias~Panel,stats_NDV,max)$Bias),
                          Parameter=rep(c("Correlation",
                                          "Bias")),
                          Trait="NDV",
                          Panel="MASPOT",
                          Training="MASPOT",
                          Method="ssnp_0")
stats_NDV_mean[,1:4]=round(stats_NDV_mean[,1:4],3)
rownames(stats_NDV_mean)=NULL
show(stats_NDV_mean)

ssnp_0_stats_NDV_All_comb=stats_NDV
ssnp_0_stats_NDV_mean_All_comb=stats_NDV_mean
ssnp_0_yHat_NDV_All_comb=yHat_NDV

stats_NDV_All_comb=stats_NDV
stats_NDV_mean_All_comb=stats_NDV_mean
yHat_NDV_All_comb=yHat_NDV

save(ssnp_0_stats_NDV_All_comb,file="Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/ssnp_0_stats_NDV_All_comb.RData")
save(ssnp_0_stats_NDV_mean_All_comb,file="Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/ssnp_0_stats_NDV_mean_All_comb.RData")
save(ssnp_0_yHat_NDV_All_comb,file="Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/ssnp_0_yHat_NDV_All_comb.RData")

### plotting gear ###

#axis range
tmp_NDV_p = range(yHat_NDV_All_comb$PT, yHat_NDV_All_comb$Mean, na.rm=T)

#stat table
stats <- data.frame("Correlation" = stats_NDV_mean_All_comb$Mean_stats[1], 
                             "Bias" = stats_NDV_mean_All_comb$Mean_stats[2], 
                             "Panel" = "MASPOT") # See if this works

p_NDV = 
  ggplot(yHat_NDV,aes(Mean,PT)) +
  geom_point(color = "deeppink3") +
  geom_smooth(method = "lm", se = F, color = "deeppink3") +
  theme_few() + 
  xlim(tmp_NDV_p) +
  ylim(tmp_NDV_p) +
  labs(x = "Predicted Phenotype", y = "Observed phenotype", title = "NDV, ssnp_0, GBLUP, CV8fold, MASPOT") +
  theme(legend.position = "none") +
  annotate(geom = "table",
           x = 2,
           y = 2,
           label = list(stats))

plot_grid(p_NDV)

ggsave("Plots/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/ssnp_0_MASPOT_gb_CV8fold_NDV.png", width = 6, height = 5, scale = 0.9)
