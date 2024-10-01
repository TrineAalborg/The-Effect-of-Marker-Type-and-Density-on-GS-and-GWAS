#!/usr/bin/env Rscript
###### Script: combine all ssnp 2binlevelsubsetting data ######
# TRAA September 2023

# Subjects: MASPOT
# variants: ssnp (w 2binlevelsubsetting as marker reduction method)

###### Set working directory ######

setwd("/MASPOT/GS")
rm(list = ls())

library(dplyr)
library(tidyr)
library(ggplot2)
library(ggthemes)
library(cowplot)
library(forcats)

###### Combine data elements on each subset level ######
# between each script the global environment is cleared, why the data elements generated in these scripts need to be reloaded

source("Models/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/99_Combine_data_0.R")
source("Models/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/99_Combine_data_1.R")
source("Models/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/99_Combine_data_2.R")
source("Models/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/99_Combine_data_3.R")
source("Models/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/99_Combine_data_4.R")
source("Models/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/99_Combine_data_5.R")
source("Models/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/99_Combine_data_6.R")
source("Models/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/99_Combine_data_7.R") 
source("Models/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/99_Combine_data_8.R") 
source("Models/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/99_Combine_data_9.R")

rm(list = ls())

###### Load data elements ######

### yHat ###

load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/yHat_0.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/yHat_1.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/yHat_2.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/yHat_3.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/yHat_4.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/yHat_5.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/yHat_6.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/yHat_7.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/yHat_8.RData") 
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/yHat_9.RData") 

### stats ###
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/stats_0.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/stats_1.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/stats_2.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/stats_3.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/stats_4.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/stats_5.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/stats_6.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/stats_7.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/stats_8.RData")
load("Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/stats_9.RData") 


###### Combine all stats ######

stats <- rbind(stats_0,
               stats_1,
               stats_2,
               stats_3,
               stats_4,
               stats_5,
               stats_6,
               stats_7,
               stats_8,
               stats_9
               )
save(stats, file = "Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_markerreduction_stats_allcomb.RData")

stats_all_mean <- stats %>% group_by(Trait, Method) %>% 
  summarize(Correlation = mean(Correlation),
            Bias = mean(Bias),
            CV = NA) #%>% 
  #select(Correlation, Bias, CV, Trait, Panel, Training, Method, Markers)
save(stats_all_mean, file = "Results/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/ssnp_stats_all_mean.RData")


##### Plot stats ######

stats$Markers <- as.factor(stats$Markers)

# Correlation
p_corr <- ggplot(stats, aes(Markers, Correlation)) +
              geom_boxplot() + 
  facet_grid(Trait ~ ., scales = "free_y", space = "free_x"#, 
             #labeller = labeller(Trait = as_labeller(setNames(c("Chipping quality", "Length-width ratio", "Senescence", "Starch content", "Dry matter content", "Yield"), 
                                                              #unique(stats$Trait))))
) +
  theme_few() +
              theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
              labs(x = "Number of markers", y = "Correlation")

#plot_grid(p_corr)
ggsave("Plots/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/MASPOT_ssnp_markerreduction_correlation_discrete_x.png")



# Bias 
p_bias <- ggplot(stats, aes(Markers, Bias)) +
              geom_boxplot() + 
  facet_grid(Trait ~ ., scales = "free_y", space = "free_x"#
             #, labeller = labeller(Trait = as_labeller(setNames(c("Chipping quality", "Starch content", "Yield"), unique(stats$Trait))))
             ) +
  theme_few() +
              theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
              labs(x = "Number of markers", y = "Bias") +
  geom_hline(yintercept = 1.00, linetype = "dashed")
#plot_grid(p_bias)
ggsave("Plots/ssnp/20230904_ssnp_2binlevelsubsetting_MASPOT/MASPOT_ssnp_markerreduction_bias_discrete_x.png")
