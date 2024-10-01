#!/usr/bin/env Rscript
## Script: combine stats
# TRAA September 2023

# subjects (for training): MASPOT 
# variants: ssnp_0
# Trait: TP2 (chipping quality)
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

load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/yHat.gb_TP2_CV01.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/yHat.gb_TP2_CV02.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/yHat.gb_TP2_CV03.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/yHat.gb_TP2_CV04.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/yHat.gb_TP2_CV05.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/yHat.gb_TP2_CV06.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/yHat.gb_TP2_CV07.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/yHat.gb_TP2_CV08.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/yHat.gb_TP2_CV09.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/yHat.gb_TP2_CV10.RData")

###### Combine to find overall correlation and bias ######

yHat_TP2=data.frame("CV01"=yHat.gb_TP2_CV01$yHat.gb_TP2_test,
                    "CV02"=yHat.gb_TP2_CV02$yHat.gb_TP2_test,
                    "CV03"=yHat.gb_TP2_CV03$yHat.gb_TP2_test,
                    "CV04"=yHat.gb_TP2_CV04$yHat.gb_TP2_test,
                    "CV05"=yHat.gb_TP2_CV05$yHat.gb_TP2_test,
                    "CV06"=yHat.gb_TP2_CV06$yHat.gb_TP2_test,
                    "CV07"=yHat.gb_TP2_CV07$yHat.gb_TP2_test,
                    "CV08"=yHat.gb_TP2_CV08$yHat.gb_TP2_test,
                    "CV09"=yHat.gb_TP2_CV09$yHat.gb_TP2_test,
                    "CV10"=yHat.gb_TP2_CV10$yHat.gb_TP2_test)

stats_TP2=cbind(t(cor(pt$TP2, yHat_TP2, use = "pair")),
                c(lm(pt$TP2~yHat_TP2[,1])$coefficients[2],
                  lm(pt$TP2~yHat_TP2[,2])$coefficients[2],
                  lm(pt$TP2~yHat_TP2[,3])$coefficients[2],
                  lm(pt$TP2~yHat_TP2[,4])$coefficients[2],
                  lm(pt$TP2~yHat_TP2[,5])$coefficients[2],
                  lm(pt$TP2~yHat_TP2[,6])$coefficients[2],
                  lm(pt$TP2~yHat_TP2[,7])$coefficients[2],
                  lm(pt$TP2~yHat_TP2[,8])$coefficients[2],
                  lm(pt$TP2~yHat_TP2[,9])$coefficients[2],
                  lm(pt$TP2~yHat_TP2[,10])$coefficients[2]))
colnames(stats_TP2)=c("Correlation",
                      "Bias")
stats_TP2=as.data.frame(stats_TP2)
rownames(stats_TP2)=NULL
stats_TP2["CV"]=rep(1:10)
stats_TP2["Trait"]="TP2"
stats_TP2["Panel"]="MASPOT"
stats_TP2["Training"]="MASPOT"
stats_TP2["Method"]="ssnp_0"
stats_TP2["Model"]="GBLUP"
stats_TP2[,1:2]=round(stats_TP2[,1:2],3)
show(stats_TP2)

###### Plot predicted phenotype vs observed ######

yHat_TP2["Mean"]=apply(yHat_TP2[,c(1:10)],1,mean)
yHat_TP2["SD"]=apply(yHat_TP2[,c(1:10)],1,sd)
yHat_TP2["PT"]=pt$TP2
yHat_TP2["Trait"]="TP2"
yHat_TP2["Panel"]="MASPOT"
yHat_TP2["Training"]="MASPOT"
yHat_TP2["Method"]="ssnp_0"
yHat_TP2["Model"]="GBLUP"
yHat_TP2["SOR"]=pt$SOR
yHat_TP2[,1:12]=round(yHat_TP2[,1:12],3)
head(yHat_TP2)

stats_TP2_mean=data.frame(Mean_mean=c(cor(pt$TP2, yHat_TP2$Mean, use = "pair"),
                                      lm(pt$TP2~yHat_TP2$Mean)$coefficients[2]),
                          Mean_stats=c(aggregate(Correlation~Panel,stats_TP2,mean)$Correlation,
                                       aggregate(Bias~Panel,stats_TP2,mean)$Bias),
                          Min=c(aggregate(Correlation~Panel,stats_TP2,min)$Correlation,
                                aggregate(Bias~Panel,stats_TP2,min)$Bias),
                          Max=c(aggregate(Correlation~Panel,stats_TP2,max)$Correlation,
                                aggregate(Bias~Panel,stats_TP2,max)$Bias),
                          Parameter=rep(c("Correlation",
                                          "Bias")),
                          Trait="TP2",
                          Panel="MASPOT",
                          Training="MASPOT",
                          Method="ssnp_0")
stats_TP2_mean[,1:4]=round(stats_TP2_mean[,1:4],3)
rownames(stats_TP2_mean)=NULL
show(stats_TP2_mean)

ssnp_0_stats_TP2_All_comb=stats_TP2
ssnp_0_stats_TP2_mean_All_comb=stats_TP2_mean
ssnp_0_yHat_TP2_All_comb=yHat_TP2

stats_TP2_All_comb=stats_TP2
stats_TP2_mean_All_comb=stats_TP2_mean
yHat_TP2_All_comb=yHat_TP2

save(ssnp_0_stats_TP2_All_comb,file="Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/ssnp_0_stats_TP2_All_comb.RData")
save(ssnp_0_stats_TP2_mean_All_comb,file="Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/ssnp_0_stats_TP2_mean_All_comb.RData")
save(ssnp_0_yHat_TP2_All_comb,file="Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/ssnp_0_yHat_TP2_All_comb.RData")

### plotting gear ###

#axis range
tmp_TP2_p = range(yHat_TP2_All_comb$PT, yHat_TP2_All_comb$Mean, na.rm=T)

#stat table
stats <- data.frame("Correlation" = stats_TP2_mean_All_comb$Mean_stats[1], 
                             "Bias" = stats_TP2_mean_All_comb$Mean_stats[2], 
                             "Panel" = "MASPOT") # See if this works

p_TP2 = 
  ggplot(yHat_TP2,aes(Mean,PT)) +
  geom_point(color = "chocolate4") +
  geom_smooth(method = "lm", se = F, color = "chocolate4") +
  theme_few() + 
  xlim(tmp_TP2_p) +
  ylim(tmp_TP2_p) +
  labs(x = "Predicted Phenotype", y = "Observed phenotype", title = "TP2, ssnp_0, GBLUP, CV8fold, MASPOT") +
  theme(legend.position = "none") +
  annotate(geom = "table",
           x = 27.5,
           y = 11,
           label = list(stats))

plot_grid(p_TP2)

ggsave("Plots/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/ssnp_0_MASPOT_gb_CV8fold_TP2.png", width = 6, height = 5, scale = 0.9)
