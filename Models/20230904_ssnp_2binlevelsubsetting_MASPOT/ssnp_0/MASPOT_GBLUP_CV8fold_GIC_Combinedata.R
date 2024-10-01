#!/usr/bin/env Rscript
## Script: combine stats
# TRAA September 2023

# subjects (for training): MASPOT 
# variants: ssnp_0
# Trait: GIC (chipping quality)
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

load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/yHat.gb_GIC_CV01.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/yHat.gb_GIC_CV02.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/yHat.gb_GIC_CV03.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/yHat.gb_GIC_CV04.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/yHat.gb_GIC_CV05.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/yHat.gb_GIC_CV06.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/yHat.gb_GIC_CV07.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/yHat.gb_GIC_CV08.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/yHat.gb_GIC_CV09.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/yHat.gb_GIC_CV10.RData")

###### Combine to find overall correlation and bias ######

yHat_GIC=data.frame("CV01"=yHat.gb_GIC_CV01$yHat.gb_GIC_test,
                    "CV02"=yHat.gb_GIC_CV02$yHat.gb_GIC_test,
                    "CV03"=yHat.gb_GIC_CV03$yHat.gb_GIC_test,
                    "CV04"=yHat.gb_GIC_CV04$yHat.gb_GIC_test,
                    "CV05"=yHat.gb_GIC_CV05$yHat.gb_GIC_test,
                    "CV06"=yHat.gb_GIC_CV06$yHat.gb_GIC_test,
                    "CV07"=yHat.gb_GIC_CV07$yHat.gb_GIC_test,
                    "CV08"=yHat.gb_GIC_CV08$yHat.gb_GIC_test,
                    "CV09"=yHat.gb_GIC_CV09$yHat.gb_GIC_test,
                    "CV10"=yHat.gb_GIC_CV10$yHat.gb_GIC_test)

stats_GIC=cbind(t(cor(pt$GIC, yHat_GIC, use = "pair")),
                c(lm(pt$GIC~yHat_GIC[,1])$coefficients[2],
                  lm(pt$GIC~yHat_GIC[,2])$coefficients[2],
                  lm(pt$GIC~yHat_GIC[,3])$coefficients[2],
                  lm(pt$GIC~yHat_GIC[,4])$coefficients[2],
                  lm(pt$GIC~yHat_GIC[,5])$coefficients[2],
                  lm(pt$GIC~yHat_GIC[,6])$coefficients[2],
                  lm(pt$GIC~yHat_GIC[,7])$coefficients[2],
                  lm(pt$GIC~yHat_GIC[,8])$coefficients[2],
                  lm(pt$GIC~yHat_GIC[,9])$coefficients[2],
                  lm(pt$GIC~yHat_GIC[,10])$coefficients[2]))
colnames(stats_GIC)=c("Correlation",
                      "Bias")
stats_GIC=as.data.frame(stats_GIC)
rownames(stats_GIC)=NULL
stats_GIC["CV"]=rep(1:10)
stats_GIC["Trait"]="GIC"
stats_GIC["Panel"]="MASPOT"
stats_GIC["Training"]="MASPOT"
stats_GIC["Method"]="ssnp_0"
stats_GIC["Model"]="GBLUP"
stats_GIC[,1:2]=round(stats_GIC[,1:2],3)
show(stats_GIC)

###### Plot predicted phenotype vs observed ######

yHat_GIC["Mean"]=apply(yHat_GIC[,c(1:10)],1,mean)
yHat_GIC["SD"]=apply(yHat_GIC[,c(1:10)],1,sd)
yHat_GIC["PT"]=pt$GIC
yHat_GIC["Trait"]="GIC"
yHat_GIC["Panel"]="MASPOT"
yHat_GIC["Training"]="MASPOT"
yHat_GIC["Method"]="ssnp_0"
yHat_GIC["Model"]="GBLUP"
yHat_GIC["SOR"]=pt$SOR
yHat_GIC[,1:12]=round(yHat_GIC[,1:12],3)
head(yHat_GIC)

stats_GIC_mean=data.frame(Mean_mean=c(cor(pt$GIC, yHat_GIC$Mean, use = "pair"),
                                      lm(pt$GIC~yHat_GIC$Mean)$coefficients[2]),
                          Mean_stats=c(aggregate(Correlation~Panel,stats_GIC,mean)$Correlation,
                                       aggregate(Bias~Panel,stats_GIC,mean)$Bias),
                          Min=c(aggregate(Correlation~Panel,stats_GIC,min)$Correlation,
                                aggregate(Bias~Panel,stats_GIC,min)$Bias),
                          Max=c(aggregate(Correlation~Panel,stats_GIC,max)$Correlation,
                                aggregate(Bias~Panel,stats_GIC,max)$Bias),
                          Parameter=rep(c("Correlation",
                                          "Bias")),
                          Trait="GIC",
                          Panel="MASPOT",
                          Training="MASPOT",
                          Method="ssnp_0")
stats_GIC_mean[,1:4]=round(stats_GIC_mean[,1:4],3)
rownames(stats_GIC_mean)=NULL
show(stats_GIC_mean) 

ssnp_0_stats_GIC_All_comb=stats_GIC
ssnp_0_stats_GIC_mean_All_comb=stats_GIC_mean
ssnp_0_yHat_GIC_All_comb=yHat_GIC

stats_GIC_All_comb=stats_GIC
stats_GIC_mean_All_comb=stats_GIC_mean
yHat_GIC_All_comb=yHat_GIC

save(ssnp_0_stats_GIC_All_comb,file="Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/ssnp_0_stats_GIC_All_comb.RData")
save(ssnp_0_stats_GIC_mean_All_comb,file="Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/ssnp_0_stats_GIC_mean_All_comb.RData")
save(ssnp_0_yHat_GIC_All_comb,file="Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/ssnp_0_yHat_GIC_All_comb.RData")

### plotting gear ###

#axis range
tmp_GIC_p = range(yHat_GIC_All_comb$PT, yHat_GIC_All_comb$Mean, na.rm=T)

#stat table
stats <- data.frame("Correlation" = stats_GIC_mean_All_comb$Mean_stats[1], 
                             "Bias" = stats_GIC_mean_All_comb$Mean_stats[2], 
                             "Panel" = "MASPOT") # See if this works

p_GIC = 
  ggplot(yHat_GIC,aes(Mean,PT)) +
  geom_point(color = "coral") +
  geom_smooth(method = "lm", se = F, color = "coral") +
  theme_few() + 
  xlim(tmp_GIC_p) +
  ylim(tmp_GIC_p) +
  labs(x = "Predicted Phenotype", y = "Observed phenotype", title = "GIC, ssnp_0, GBLUP, CV8fold, MASPOT") +
  theme(legend.position = "none") +
  annotate(geom = "table",
           x = 8,
           y = 1,
           label = list(stats))

plot_grid(p_GIC)

ggsave("Plots/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_0/ssnp_0_MASPOT_gb_CV8fold_GIC.png", width = 6, height = 5, scale = 0.9)
