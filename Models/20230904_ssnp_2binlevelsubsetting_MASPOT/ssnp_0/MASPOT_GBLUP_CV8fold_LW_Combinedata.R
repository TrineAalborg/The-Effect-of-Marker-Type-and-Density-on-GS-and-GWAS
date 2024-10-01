#!/usr/bin/env Rscript
## Script: combine stats
# TRAA September 2023

# subjects (for training): MASPOT 
# variants: ssnp_0
# Trait: LW (chipping quality)
# Model: GBLUP

###### Set working directory ######
setwd("/MASPOT/GS")

library(BGLR)
library(ggplot2)
library(ggpmisc)
library(ggthemes)
library(cowplot)

###### Load data elements ######
load("Data/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/pt_ssnp_0.RData")

pt=pt_ssnp_0

load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/yHat.gb_LW_CV01.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/yHat.gb_LW_CV02.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/yHat.gb_LW_CV03.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/yHat.gb_LW_CV04.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/yHat.gb_LW_CV05.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/yHat.gb_LW_CV06.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/yHat.gb_LW_CV07.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/yHat.gb_LW_CV08.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/yHat.gb_LW_CV09.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/yHat.gb_LW_CV10.RData")

###### Combine to find overall correlation and bias ######

yHat_LW=data.frame("CV01"=yHat.gb_LW_CV01$yHat.gb_LW_test,
                    "CV02"=yHat.gb_LW_CV02$yHat.gb_LW_test,
                    "CV03"=yHat.gb_LW_CV03$yHat.gb_LW_test,
                    "CV04"=yHat.gb_LW_CV04$yHat.gb_LW_test,
                    "CV05"=yHat.gb_LW_CV05$yHat.gb_LW_test,
                    "CV06"=yHat.gb_LW_CV06$yHat.gb_LW_test,
                    "CV07"=yHat.gb_LW_CV07$yHat.gb_LW_test,
                    "CV08"=yHat.gb_LW_CV08$yHat.gb_LW_test,
                    "CV09"=yHat.gb_LW_CV09$yHat.gb_LW_test,
                    "CV10"=yHat.gb_LW_CV10$yHat.gb_LW_test)

stats_LW=cbind(t(cor(pt$LW, yHat_LW, use = "pair")),
                c(lm(pt$LW~yHat_LW[,1])$coefficients[2],
                  lm(pt$LW~yHat_LW[,2])$coefficients[2],
                  lm(pt$LW~yHat_LW[,3])$coefficients[2],
                  lm(pt$LW~yHat_LW[,4])$coefficients[2],
                  lm(pt$LW~yHat_LW[,5])$coefficients[2],
                  lm(pt$LW~yHat_LW[,6])$coefficients[2],
                  lm(pt$LW~yHat_LW[,7])$coefficients[2],
                  lm(pt$LW~yHat_LW[,8])$coefficients[2],
                  lm(pt$LW~yHat_LW[,9])$coefficients[2],
                  lm(pt$LW~yHat_LW[,10])$coefficients[2]))
colnames(stats_LW)=c("Correlation",
                      "Bias")
stats_LW=as.data.frame(stats_LW)
rownames(stats_LW)=NULL
stats_LW["CV"]=rep(1:10)
stats_LW["Trait"]="LW"
stats_LW["Panel"]="MASPOT"
stats_LW["Training"]="MASPOT"
stats_LW["Method"]="ssnp_0"
stats_LW["Model"]="GBLUP"
stats_LW[,1:2]=round(stats_LW[,1:2],3)
show(stats_LW)

###### Plot predicted phenotype vs observed ######

yHat_LW["Mean"]=apply(yHat_LW[,c(1:10)],1,mean)
yHat_LW["SD"]=apply(yHat_LW[,c(1:10)],1,sd)
yHat_LW["PT"]=pt$LW
yHat_LW["Trait"]="LW"
yHat_LW["Panel"]="MASPOT"
yHat_LW["Training"]="MASPOT"
yHat_LW["Method"]="ssnp_0"
yHat_LW["Model"]="GBLUP"
yHat_LW["SOR"]=pt$SOR
yHat_LW[,1:12]=round(yHat_LW[,1:12],3)
head(yHat_LW)

stats_LW_mean=data.frame(Mean_mean=c(cor(pt$LW, yHat_LW$Mean, use = "pair"),
                                      lm(pt$LW~yHat_LW$Mean)$coefficients[2]),
                          Mean_stats=c(aggregate(Correlation~Panel,stats_LW,mean)$Correlation,
                                       aggregate(Bias~Panel,stats_LW,mean)$Bias),
                          Min=c(aggregate(Correlation~Panel,stats_LW,min)$Correlation,
                                aggregate(Bias~Panel,stats_LW,min)$Bias),
                          Max=c(aggregate(Correlation~Panel,stats_LW,max)$Correlation,
                                aggregate(Bias~Panel,stats_LW,max)$Bias),
                          Parameter=rep(c("Correlation",
                                          "Bias")),
                          Trait="LW",
                          Panel="MASPOT",
                          Training="MASPOT",
                          Method="ssnp_0")
stats_LW_mean[,1:4]=round(stats_LW_mean[,1:4],3)
rownames(stats_LW_mean)=NULL
show(stats_LW_mean)  

ssnp_0_stats_LW_All_comb=stats_LW
ssnp_0_stats_LW_mean_All_comb=stats_LW_mean
ssnp_0_yHat_LW_All_comb=yHat_LW

stats_LW_All_comb=stats_LW
stats_LW_mean_All_comb=stats_LW_mean
yHat_LW_All_comb=yHat_LW

save(ssnp_0_stats_LW_All_comb,file="Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/ssnp_0_stats_LW_All_comb.RData")
save(ssnp_0_stats_LW_mean_All_comb,file="Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/ssnp_0_stats_LW_mean_All_comb.RData")
save(ssnp_0_yHat_LW_All_comb,file="Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/ssnp_0_yHat_LW_All_comb.RData")

### plotting gear ###

#axis range
tmp_LW_p = range(yHat_LW_All_comb$PT, yHat_LW_All_comb$Mean, na.rm=T)

#stat table
stats <- data.frame("Correlation" = stats_LW_mean_All_comb$Mean_stats[1], 
                             "Bias" = stats_LW_mean_All_comb$Mean_stats[2], 
                             "Panel" = "MASPOT") # See if this works

p_LW = 
  ggplot(yHat_LW,aes(Mean,PT)) +
  geom_point(color = "darkorchid4") +
  geom_smooth(method = "lm", se = F, color = "darkorchid4") +
  theme_few() + 
  xlim(tmp_LW_p) +
  ylim(tmp_LW_p) +
  labs(x = "Predicted Phenotype", y = "Observed phenotype", title = "LW, ssnp_0, GBLUP, CV8fold, MASPOT") +
  theme(legend.position = "none") +
  annotate(geom = "table",
           x = 2.4,
           y = 1.25,
           label = list(stats))

plot_grid(p_LW)

ggsave("Plots/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/ssnp_0_MASPOT_gb_CV8fold_LW.png", width = 6, height = 5, scale = 0.9)
