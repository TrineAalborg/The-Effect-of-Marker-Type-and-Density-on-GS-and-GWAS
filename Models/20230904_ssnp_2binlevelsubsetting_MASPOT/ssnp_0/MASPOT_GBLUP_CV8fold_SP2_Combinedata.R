#!/usr/bin/env Rscript
## Script: combine stats
# TRAA September 2023

# subjects (for training): MASPOT 
# variants: ssnp_0
# Trait: SP2 (chipping quality)
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

load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/yHat.gb_SP2_CV01.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/yHat.gb_SP2_CV02.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/yHat.gb_SP2_CV03.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/yHat.gb_SP2_CV04.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/yHat.gb_SP2_CV05.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/yHat.gb_SP2_CV06.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/yHat.gb_SP2_CV07.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/yHat.gb_SP2_CV08.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/yHat.gb_SP2_CV09.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/yHat.gb_SP2_CV10.RData")

###### Combine to find overall correlation and bias ######

yHat_SP2=data.frame("CV01"=yHat.gb_SP2_CV01$yHat.gb_SP2_test,
                    "CV02"=yHat.gb_SP2_CV02$yHat.gb_SP2_test,
                    "CV03"=yHat.gb_SP2_CV03$yHat.gb_SP2_test,
                    "CV04"=yHat.gb_SP2_CV04$yHat.gb_SP2_test,
                    "CV05"=yHat.gb_SP2_CV05$yHat.gb_SP2_test,
                    "CV06"=yHat.gb_SP2_CV06$yHat.gb_SP2_test,
                    "CV07"=yHat.gb_SP2_CV07$yHat.gb_SP2_test,
                    "CV08"=yHat.gb_SP2_CV08$yHat.gb_SP2_test,
                    "CV09"=yHat.gb_SP2_CV09$yHat.gb_SP2_test,
                    "CV10"=yHat.gb_SP2_CV10$yHat.gb_SP2_test)

stats_SP2=cbind(t(cor(pt$SP2, yHat_SP2, use = "pair")),
                c(lm(pt$SP2~yHat_SP2[,1])$coefficients[2],
                  lm(pt$SP2~yHat_SP2[,2])$coefficients[2],
                  lm(pt$SP2~yHat_SP2[,3])$coefficients[2],
                  lm(pt$SP2~yHat_SP2[,4])$coefficients[2],
                  lm(pt$SP2~yHat_SP2[,5])$coefficients[2],
                  lm(pt$SP2~yHat_SP2[,6])$coefficients[2],
                  lm(pt$SP2~yHat_SP2[,7])$coefficients[2],
                  lm(pt$SP2~yHat_SP2[,8])$coefficients[2],
                  lm(pt$SP2~yHat_SP2[,9])$coefficients[2],
                  lm(pt$SP2~yHat_SP2[,10])$coefficients[2]))
colnames(stats_SP2)=c("Correlation",
                      "Bias")
stats_SP2=as.data.frame(stats_SP2)
rownames(stats_SP2)=NULL
stats_SP2["CV"]=rep(1:10)
stats_SP2["Trait"]="SP2"
stats_SP2["Panel"]="MASPOT"
stats_SP2["Training"]="MASPOT"
stats_SP2["Method"]="ssnp_0"
stats_SP2["Model"]="GBLUP"
stats_SP2[,1:2]=round(stats_SP2[,1:2],3)
show(stats_SP2)

###### Plot predicted phenotype vs observed ######

yHat_SP2["Mean"]=apply(yHat_SP2[,c(1:10)],1,mean)
yHat_SP2["SD"]=apply(yHat_SP2[,c(1:10)],1,sd)
yHat_SP2["PT"]=pt$SP2
yHat_SP2["Trait"]="SP2"
yHat_SP2["Panel"]="MASPOT"
yHat_SP2["Training"]="MASPOT"
yHat_SP2["Method"]="ssnp_0"
yHat_SP2["Model"]="GBLUP"
yHat_SP2["SOR"]=pt$SOR
yHat_SP2[,1:12]=round(yHat_SP2[,1:12],3)
head(yHat_SP2)

stats_SP2_mean=data.frame(Mean_mean=c(cor(pt$SP2, yHat_SP2$Mean, use = "pair"),
                                      lm(pt$SP2~yHat_SP2$Mean)$coefficients[2]),
                          Mean_stats=c(aggregate(Correlation~Panel,stats_SP2,mean)$Correlation,
                                       aggregate(Bias~Panel,stats_SP2,mean)$Bias),
                          Min=c(aggregate(Correlation~Panel,stats_SP2,min)$Correlation,
                                aggregate(Bias~Panel,stats_SP2,min)$Bias),
                          Max=c(aggregate(Correlation~Panel,stats_SP2,max)$Correlation,
                                aggregate(Bias~Panel,stats_SP2,max)$Bias),
                          Parameter=rep(c("Correlation",
                                          "Bias")),
                          Trait="SP2",
                          Panel="MASPOT",
                          Training="MASPOT",
                          Method="ssnp_0")
stats_SP2_mean[,1:4]=round(stats_SP2_mean[,1:4],3)
rownames(stats_SP2_mean)=NULL
show(stats_SP2_mean)  

ssnp_0_stats_SP2_All_comb=stats_SP2
ssnp_0_stats_SP2_mean_All_comb=stats_SP2_mean
ssnp_0_yHat_SP2_All_comb=yHat_SP2

stats_SP2_All_comb=stats_SP2
stats_SP2_mean_All_comb=stats_SP2_mean
yHat_SP2_All_comb=yHat_SP2

save(ssnp_0_stats_SP2_All_comb,file="Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/ssnp_0_stats_SP2_All_comb.RData")
save(ssnp_0_stats_SP2_mean_All_comb,file="Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/ssnp_0_stats_SP2_mean_All_comb.RData")
save(ssnp_0_yHat_SP2_All_comb,file="Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/ssnp_0_yHat_SP2_All_comb.RData")

### plotting gear ###

#axis range
tmp_SP2_p = range(yHat_SP2_All_comb$PT, yHat_SP2_All_comb$Mean, na.rm=T)

#stat table
stats <- data.frame("Correlation" = stats_SP2_mean_All_comb$Mean_stats[1], 
                             "Bias" = stats_SP2_mean_All_comb$Mean_stats[2], 
                             "Panel" = "MASPOT") # See if this works

p_SP2 = 
  ggplot(yHat_SP2,aes(Mean,PT)) +
  geom_point(color = "chartreuse3") +
  geom_smooth(method = "lm", se = F, color = "chartreuse3") +
  theme_few() + 
  xlim(tmp_SP2_p) +
  ylim(tmp_SP2_p) +
  labs(x = "Predicted Phenotype", y = "Observed phenotype", title = "SP2, ssnp_0, GBLUP, CV8fold, MASPOT") +
  theme(legend.position = "none") +
  annotate(geom = "table",
           x = 22,
           y = 5.5,
           label = list(stats))

plot_grid(p_SP2)

ggsave("Plots/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/ssnp_0_MASPOT_gb_CV8fold_SP2.png", width = 6, height = 5, scale = 0.9)
