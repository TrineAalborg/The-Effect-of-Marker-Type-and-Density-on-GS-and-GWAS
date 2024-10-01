#!/usr/bin/env Rscript
## Script: combine stats
# TRAA September 2023

# subjects (for training): MASPOT 
# variants: ssnp_0
# Trait: UU2 (chipping quality)
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

load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/yHat.gb_UU2_CV01.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/yHat.gb_UU2_CV02.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/yHat.gb_UU2_CV03.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/yHat.gb_UU2_CV04.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/yHat.gb_UU2_CV05.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/yHat.gb_UU2_CV06.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/yHat.gb_UU2_CV07.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/yHat.gb_UU2_CV08.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/yHat.gb_UU2_CV09.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/yHat.gb_UU2_CV10.RData")

###### Combine to find overall correlation and bias ######

yHat_UU2=data.frame("CV01"=yHat.gb_UU2_CV01$yHat.gb_UU2_test,
                    "CV02"=yHat.gb_UU2_CV02$yHat.gb_UU2_test,
                    "CV03"=yHat.gb_UU2_CV03$yHat.gb_UU2_test,
                    "CV04"=yHat.gb_UU2_CV04$yHat.gb_UU2_test,
                    "CV05"=yHat.gb_UU2_CV05$yHat.gb_UU2_test,
                    "CV06"=yHat.gb_UU2_CV06$yHat.gb_UU2_test,
                    "CV07"=yHat.gb_UU2_CV07$yHat.gb_UU2_test,
                    "CV08"=yHat.gb_UU2_CV08$yHat.gb_UU2_test,
                    "CV09"=yHat.gb_UU2_CV09$yHat.gb_UU2_test,
                    "CV10"=yHat.gb_UU2_CV10$yHat.gb_UU2_test)

stats_UU2=cbind(t(cor(pt$UU2, yHat_UU2, use = "pair")),
                c(lm(pt$UU2~yHat_UU2[,1])$coefficients[2],
                  lm(pt$UU2~yHat_UU2[,2])$coefficients[2],
                  lm(pt$UU2~yHat_UU2[,3])$coefficients[2],
                  lm(pt$UU2~yHat_UU2[,4])$coefficients[2],
                  lm(pt$UU2~yHat_UU2[,5])$coefficients[2],
                  lm(pt$UU2~yHat_UU2[,6])$coefficients[2],
                  lm(pt$UU2~yHat_UU2[,7])$coefficients[2],
                  lm(pt$UU2~yHat_UU2[,8])$coefficients[2],
                  lm(pt$UU2~yHat_UU2[,9])$coefficients[2],
                  lm(pt$UU2~yHat_UU2[,10])$coefficients[2]))
colnames(stats_UU2)=c("Correlation",
                      "Bias")
stats_UU2=as.data.frame(stats_UU2)
rownames(stats_UU2)=NULL
stats_UU2["CV"]=rep(1:10)
stats_UU2["Trait"]="UU2"
stats_UU2["Panel"]="MASPOT"
stats_UU2["Training"]="MASPOT"
stats_UU2["Method"]="ssnp_0"
stats_UU2["Model"]="GBLUP"
stats_UU2[,1:2]=round(stats_UU2[,1:2],3)
show(stats_UU2)

###### Plot predicted phenotype vs observed ######

yHat_UU2["Mean"]=apply(yHat_UU2[,c(1:10)],1,mean)
yHat_UU2["SD"]=apply(yHat_UU2[,c(1:10)],1,sd)
yHat_UU2["PT"]=pt$UU2
yHat_UU2["Trait"]="UU2"
yHat_UU2["Panel"]="MASPOT"
yHat_UU2["Training"]="MASPOT"
yHat_UU2["Method"]="ssnp_0"
yHat_UU2["Model"]="GBLUP"
yHat_UU2["SOR"]=pt$SOR
yHat_UU2[,1:12]=round(yHat_UU2[,1:12],3)
head(yHat_UU2)

stats_UU2_mean=data.frame(Mean_mean=c(cor(pt$UU2, yHat_UU2$Mean, use = "pair"),
                                      lm(pt$UU2~yHat_UU2$Mean)$coefficients[2]),
                          Mean_stats=c(aggregate(Correlation~Panel,stats_UU2,mean)$Correlation,
                                       aggregate(Bias~Panel,stats_UU2,mean)$Bias),
                          Min=c(aggregate(Correlation~Panel,stats_UU2,min)$Correlation,
                                aggregate(Bias~Panel,stats_UU2,min)$Bias),
                          Max=c(aggregate(Correlation~Panel,stats_UU2,max)$Correlation,
                                aggregate(Bias~Panel,stats_UU2,max)$Bias),
                          Parameter=rep(c("Correlation",
                                          "Bias")),
                          Trait="UU2",
                          Panel="MASPOT",
                          Training="MASPOT",
                          Method="ssnp_0")
stats_UU2_mean[,1:4]=round(stats_UU2_mean[,1:4],3)
rownames(stats_UU2_mean)=NULL
show(stats_UU2_mean) 

ssnp_0_stats_UU2_All_comb=stats_UU2
ssnp_0_stats_UU2_mean_All_comb=stats_UU2_mean
ssnp_0_yHat_UU2_All_comb=yHat_UU2

stats_UU2_All_comb=stats_UU2
stats_UU2_mean_All_comb=stats_UU2_mean
yHat_UU2_All_comb=yHat_UU2

save(ssnp_0_stats_UU2_All_comb,file="Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/ssnp_0_stats_UU2_All_comb.RData")
save(ssnp_0_stats_UU2_mean_All_comb,file="Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/ssnp_0_stats_UU2_mean_All_comb.RData")
save(ssnp_0_yHat_UU2_All_comb,file="Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/ssnp_0_yHat_UU2_All_comb.RData")

### plotting gear ###

#axis range
tmp_UU2_p = range(yHat_UU2_All_comb$PT, yHat_UU2_All_comb$Mean, na.rm=T)

#stat table
stats <- data.frame("Correlation" = stats_UU2_mean_All_comb$Mean_stats[1], 
                             "Bias" = stats_UU2_mean_All_comb$Mean_stats[2], 
                             "Panel" = "MASPOT") # See if this works

p_UU2 = 
  ggplot(yHat_UU2,aes(Mean,PT)) +
  geom_point(color = "deepskyblue") +
  geom_smooth(method = "lm", se = F, color = "deepskyblue") +
  theme_few() + 
  xlim(tmp_UU2_p) +
  ylim(tmp_UU2_p) +
  labs(x = "Predicted Phenotype", y = "Observed phenotype", title = "UU2, ssnp_0, GBLUP, CV8fold, MASPOT") +
  theme(legend.position = "none") +
  annotate(geom = "table",
           x = 1250,
           y = 100,
           label = list(stats))

plot_grid(p_UU2)

ggsave("Plots/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/ssnp_0_MASPOT_gb_CV8fold_UU2.png", width = 6, height = 5, scale = 0.9)
