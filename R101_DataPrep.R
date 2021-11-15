########################################################################################
#Data Preparation and Preprocessing
#######################################################################################

aki_cohort<-readRDS("D:/NextGenBMI-MUIRB2074022/data/aki_cohort.rda")
aki_outcome<-readRDS("D:/NextGenBMI-MUIRB2074022/data/aki_outcome.rda")
aki_demo<-readRDS("D:/NextGenBMI-MUIRB2074022/data/aki_demo.rda")

#====================================================================================
# Inspect your data
#====================================================================================

#Use head() to view the first few rows.
head(aki_cohort)

#Use tail() to view the first few rows.
tail(aki_cohort)

#Use str() to look at the structure of the data
str(aki_cohort)

#Use summary() to get a quick overview of the data
summary(aki_cohort)

#Use the Metadata table to understand meaning of each column in each table
metadata<-read.csv("D:/NextGenBMI-MUIRB2074022/data/metadata.csv")


#====================================================================================
# Quantitative and Qualitative Data
# Qualitative Data: also called "categorical data", which cannot be expressed numerically     
#* - nominal: when there is no natural ordering among the categories (e.g. sex, race) 
#* - ordinal: when there is a natural ordering among the categories (e.g. age_group, grades)
# Quantitative Data: can be measured, written down with numbers and manipulated numerically 
# (i.e. age, BMI, blood pressure, variety of labs)   
#* - discrete: data that can only taken certain values (e.g. number of visits)   
#* - continuous: data tha can take any values (e.g. age, weights)    
#====================================================================================



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
#==================================================================================================================
pacman::p_load(tidyverse)

#==================================================================================================================
# Data Integration
# - A process of combining data derived from various data sources (e.g. databases, flat files, tables)
#   into a consistent dataset
#==================================================================================================================

##==============================================
# "join","left_join","right_join" functions for
# merging multiple tables together
##==============================================

aki_data<-aki_cohort %>%
  left_join(aki_outcome, by="PATID") %>%
  left_join(aki_demo, by="PATID")

#======================================================================================================================
# Data Abstraction
# "Data abstraction" is usually needed when repeated measurement of the same 
# variable exists and we want to remove some physical, spacial or temporal details in order to focus 
# attention on information with higher importance 
#
# There are many different methods for data abstractions, which can be as simple as "using the first observation" 
# or "taking the average", or as complex as "feature extraction using principle component analysis (PCA)" or 
# "building a markov chain". Which method to use really depends on your research context and feasibility consideration.
#======================================================================================================================



#======================================================================================================
# Data Cleaning
# Real world data are usually "messy" due to a variety of reasons:
#  - random technical issues with bio-monitors
#  - human errors in entry
#  - clinical variables are not consistently collected since EHR were collected for non-study purposes
#  - adverse events may be recorded particularly for certain study, but not regularly recorded as a routine check; 
#    clinical locations may be a key factor affecting.  
#  - missing information due to patients seeking care in other facility
#  - even within the same facility, the frequencies of seeing the patients can be highly variable
#  - different flowsheet documentations across different clinics
#=======================================================================================================

#=======================================================================================================
# Data Cleaning - Obvious Inconsistencies, Outliers
#
# Obvious Inconsistencies: occur when a record contains a value or combination of values that cannot 
# correspond to a real-world situation
#
# Outliers: also called abnormalities, discordants, deviants, and anomalies, are a data point which 
# is difference from the remaining data. Outliers not only include errors but also dicordant data that 
# arises from natural variationm, which may carry interesting information (e.g. fraud detection). 
#=========================================================================================================
# How to identify Outliers? 
#* Tukey's Method: [Q1-1.5IQR, Q3+1.5IQR], where Q1 is the first quartile, Q3 is the 3rd quartile, and IQR 
#* is the interquartile range (IQR = Q3-Q1)
#* Assumption: the underlying distribution is not too skewed 
#* Transformations can be help reshape the distribution to satisfy the assumption
#* 
#* Z-score: z = (x-m)/s, where m is the mean and s is the sample standard deviation. It computes the number 
#* of standard deviations away from the mean. A rule of thumb for identifying outliers is |z| >= 3
#* Assumption: the underlying distribution is likely to be normal
#* Transformations can be help reshape the distribution to satisfy the assumption
#* 
#* Cook's Distance: in linear regression, cook's distance is commonly used to estimate the influence of a data 
#* point on the coefficients ("Influence Diagnostic"). 
#* It measures the average effects of deleting a given observation The higher the Cook's distance is, the more 
#* influential a point will be Some commonly-used cut-off values are: 0.5, 1, 4/(N-k-1) 
#* (N: total number of observations)
#=========================================================================================================

##===================================================
# "ggplot" function to detect and visualize outliers
##==================================================



#=========================================================================================================
# How to Deal with Outliers
#* - Deletion: delete the "influential" observations that are obviously "outlier" or "inconsistent". Can be 
#* treated as "missing" data later
#* - Correction: correct the observations that are obviously "outlier" or "inconsistent" with values following 
#* certain rules or using imputation.
#* - Transformation: discretize numerical values into bins can help relieve the effect from extreme values  
#=========================================================================================================

##=====================================================
# "case_when" function for performing multiple "if else" 
# type of conditional statements
##=====================================================



#==============================================================================================================
# Data Cleaning - Missing Data
#* To deal with missing data, the first step is to identify the source of "missingness":
#* - the value could be missing because **it was forgotton or lost** (e.g. disconnection of sensors, 
#* errors in communications across different databases, human errors, etc.);
#* - the value could be missing because **it was not applicable to the instance** (e.g. a patient is 
#* diconnected from the ventilator because of a medical decision);
#* the value could be missing because **it was of no interst to the instance**
#==============================================================================================================
# Type of Missing
#* Understanding the source of "missingness" will help determine if the "missingness" is recoverable. 
#* In general, there are three types of "missingness":  
#* 
#* Missing Completely at Randm (MCAR)
#* - the probability of an observation being missing depends only on itself 
#* (e.g. disconnection of sensors, human errors);
#* 
#* Missing at Random (MAR)
#* - the probablity of a value being missing is related only to some observable data 
#* (e.g. lab is only taken due to certain diagnosis);  
#*   
#* Missing Not at Random (MNAR)** 
#* - the probablity of a value being missing is related to both observable data and unobservable data 
#* (e.g. patients with low blood pressure are more likely to have their blood pressure measured less frequently);
#* 
#* Informative Missingness
#* Missingness" sometimes may just suggest not presenting with certain condition 
#* (e.g. missing diagnosis code for cardiovascular disease may just suggest someone doesn't have the condition)
#==============================================================================================================


#==============================================================================================================
# Dealing with Missing
#* Deletion
#* - Listwise deletion (complete-case analysis): all the observations with at least one missing variable are discarded;         
#* - Pairwise deletion (available-case analysis): only discard the observations with at least one missing among the 
#* necessary variables required for specific study
#* 
#* Imputation
#* - Single value imputation: missing values are filled by some type of "predicted" values
#* - Model based imputation:
#*  -- K-Nearest Neighbors
#*  -- Linear Regression (regress the missing variable against observable variables)
#*  -- Multiple-Value Imputation Chain Equation (MICE)\
#*  
#*  Creating Indicator
#*  - for informative missingness, you can create indicators to capture the missing pattern and use it as an 
#*  additional variable
#==============================================================================================================





#=============================================================================================================
# Data Transformation
# - A process of combining data derived from various data sources (e.g. databases, flat files, tables)
#   into a consistent dataset
#==============================================================================================================
# Encoding Categorical Data
#* Since what will be eventually fed into any statistical test or analysis model should be numerical values, 
#* it is essential to transform categorical data into a numerical representations, i.e. a set of indicators for 
#* each category, which is called "one-hot-encoding"
#* 
#* Discretizing Numerical Data
#* Sometimes, it is a good strategy to **discretize** numerical data into value groups ("Binning"). 
#* For example, instead of using BMI values, we may want to categorize them into weight groups. This could help 
#* improve interpretability of your model, control overfitting, and remove outliers.
#=============================================================================================================
  



#======================================================================================================
# Data Generalization/Aggregation/Reduction
#* - Two or more values of the same attribute (but with different labels) are aggregated into one value. 
#* For example, you may want to group multiple minorities into "Other" race type
#* - Sometime, you may want to aggregate low level attributes into higher level ones. For example, 
#* you may want to group all MACE events into a single variable as "at least 1 MACE event".
#=======================================================================================================





