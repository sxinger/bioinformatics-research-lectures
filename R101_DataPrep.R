########################################################################################
#Data Preparation and Preprocessing
#######################################################################################

pacman::p_load(tidyverse)

bmi_cohort<-readRDS()

#====================================================================================
# Inspect your data
#====================================================================================

#Use head() to view the first few rows.
head(surveys)

#Use tail() to view the first few rows.
tail(surveys)

#Use str() to look at the structure of the data
str(surveys)

#Use summary() to get a quick overview of the data
summary()

#Use the Metadata table to understand meaning of each column in each table
metadata<-read.csv("D:/NextGenBMI-MUIRB2074022/data/metadata.csv")

#=========================================================================================================
# Clean your data
# - A series of steps to transform raw data into a "clean" and "tidy" dataset, or "analytic dataset" 
#   prior to statistical analysis
# - EHR data were collected for clinical and billing purposes, not necessarily for research purposes
#   Preprcoessing aims at improving the quality of data to allow for reliable statistical analysis
# - General steps for data preprocessing are:
#   - Data Integration
#   - Data Abstraction
#   - Data Cleaning
#   - Data Transformation
#   - Data Reduction
#========================================================================================================




