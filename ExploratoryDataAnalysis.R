########################################################################################
#Exploratory Data Analysis (EDA)
#* Maximize insight** into the database/understand the database structure
#* Visualize potential relationships** (direction and magnitude) between exposure and outcome variables
#* Detect outliers and anomalies** (values that are significantly different from the other observations)
#* Extract and create clinically** relevant variables.
#######################################################################################

pacman:p_load(tidyverse,tidyr,broom)

#load pre-processed data


#====================================================================================
# Categorical Data/Variables 
#* Univariate EDA
#* - Non-Graphical Methods
#*  -- Tabulation, or Frequency table
#* - Graphical Methods
#*  -- Barplot
#*  -- Pie chart
#*
#* Multivariate EDA
#* - Non-Graphical Method
#*  -- Cross tabulation, or Contingency table, or Frequency table
#* - Graphical Method
#*  -- Conditional Barplot
#*  -- Heatmap
#====================================================================================





#====================================================================================
# Numerical Data/Variables 
#* Univariate EDA
#* - Non-Graphical Methods
#*  -- Descriptive Statistics
#*   a) Central Tendency: mean, median, mode
#*   b) Spread: min, max, variance, standard deviation (sd), interquartile range (IQR)
#*   c) Shape: skewness (normal distribution is near 0), kurtosis (normal distribution is around 3)
#* - Graphical Methods
#*  -- Histogram, Density plot
#*  -- Boxplot
#*
#* Multivariate EDA
#* - Non-Graphical Method
#*  -- Pearson Correlation
#*  -- Spearman Correlation
#* - Graphical Method
#*  -- Scatter Plot
#====================================================================================





#====================================================================================
# Mixture Data (multivariate)
#* - Non-Graphical Methods
#*  -- ANOVA
#* - Graphical Methods
#*  -- Conditional Boxplot
#====================================================================================
