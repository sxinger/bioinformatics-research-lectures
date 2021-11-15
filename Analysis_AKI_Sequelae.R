rm(list=ls())

pacman:p_load(tidyverse,tidyr)

#load pre-processed data
# dat<-readRDS("D:/NextGenBMI-MUIRB2074022/aki_data.rda")

######################################
# summarizing prevalence rates
######################################

##==============================================
# use "table","prop.table" function 
# for quick check
##==============================================
#once confirmed that you don't have any duplicates
table(dat$DEATH,dnn=list("freq"))
prop.table(table(dat$DEATH,dnn=list("rel_freq")))

##==============================================
# Or you can use "group_by" and "summarize" function 
# which is compatible with %>% operator
##==============================================
N<-length(unique(dat$PATID)) #total cohort size (denominator)
prev_rt_mort<-dat %>%
  group_by(DEATH) %>%
  summarize(prop=length(unique(PATID))/N)
  
prev_rt_mort_by_sex<-dat %>%
  group_by(SEX,DEATH) %>%
  summarize(prop=length(unique(PATID))/N)

##==============================================
# you can also use ggplot to plot the summaries
##==============================================
# for numerical covariates
ggplot(dat,aes(x=DEATH,y=AGE))+
  geom_boxplot()

# for categorical covariates
ggplot(dat,aes(x=DEATH,y=SEX))+
  geom_bar()

######################################
# univariate odds ratio
######################################
logreg_mort_sex<-glm(DEATH ~ SEX_F,
                     data = dat,
                     family="binomial")

summary(logreg_mort_sex)


######################################
# multiple regression
######################################
# only select the significant factors from univariate analysis into multiple regression
multireg_mort<<-glm(DEATH ~ SEX_F + AGE + RACE,
                    data = dat,
                    family="binomial")

summary(multireg_mort)


