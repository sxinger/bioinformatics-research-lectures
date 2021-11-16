rm(list=ls())

pacman::p_load(tidyverse,tidyr,gmodels,lubridate)

#load pre-processed data
dat<-readRDS("D:/NextGenBMI-MUIRB2074022/data/aki_data.rda") %>%
  filter(!is.na(SEX)) %>%
  filter(is.na(AKI3_ONSET) & DS_EX_IND ==0) %>%
  mutate(AGE_AT_1stAKI = year(AKI1_ONSET) - year(BIRTH_DATE)) %>%
  as.data.frame

######################################
# summarizing prevalence rates
######################################

#### One-way Frequency Table ####
##==============================================
# use "table","prop.table" function 
# for quick check
##==============================================
#once confirmed that you don't have any duplicates
table(dat$DEATH_IND,dnn=list("death_ind"))
prop.table(table(dat$DEATH_IND,dnn=list("death_ind")))

##==============================================
# Or you can use "group_by" and "summarize" function 
# which is compatible with %>% operator
##==============================================
N<-length(unique(dat$PATID)) #total cohort size (denominator)
prev_rt_mort<-dat %>%
  dplyr::group_by(DEATH_IND) %>%
  dplyr::summarise(n = length(unique(PATID)),
                   prop=length(unique(PATID))/N,
                   .groups="drop")


#### Two-way Frequency Table ####
##==============================================
# use "table","prop.table" function 
# for quick check
##==============================================
#once confirmed that you don't have any duplicates
table(dat$SEX,dat$DEATH_IND,dnn=list("sex","death_ind"))
prop.table(table(dat$SEX,dat$DEATH_IND,dnn=list("sex","death_ind")),margin=2)

##==================================================
# Or you can use "group_by" and "summarize" function 
# which is compatible with %>% operator
##==================================================
prev_rt_mort_by_sex<-dat %>%
  group_by(DEATH_IND) %>%
  mutate(n_death = length(unique(PATID))) %>%
  ungroup %>% 
  group_by(SEX) %>%
  mutate(n_sex = length(unique(PATID))) %>%
  ungroup %>%
  group_by(DEATH_IND,SEX) %>%
  dplyr::summarize(n = length(unique(PATID)),
                   prop=length(unique(PATID))/N,
                   prop_sex = length(unique(PATID))/n_death,
                   prop_death = length(unique(PATID))/n_sex,
                   .groups = "drop")

##==================================================
# Use other packages of high-level function to get 
# summary in fewer steps
##==================================================
CrossTable(dat$SEX,dat$DEATH_IND)


##=========================================================
# you can also use ggplot to better visualize the summaries
##=========================================================
# for categorical covariates
ggplot(dat,aes(x=as.factor(DEATH_IND),fill=SEX))+
  geom_bar(position="dodge")

# for numerical covariates
ggplot(dat,aes(x=as.factor(DEATH_IND),y=AGE_AT_1stAKI))+
  geom_boxplot()

######################################
# univariate odds ratio
######################################
logreg_mort_sex<-glm(DEATH_IND ~ SEX_F_IND,
                     data = dat,
                     family="binomial")

summary(logreg_mort_sex)

coef_sexf<-coef(logreg_mort_sex)[2]
odds<-exp(coef(logreg_mort_sex)[2])
odds


logreg_mort_ds<-glm(DEATH_IND ~ DISCHARGE_STATUS,
                    data = dat,
                    family="binomial")

coef_dssh<-coef(logreg_mort_ds)["DISCHARGE_STATUSSH"]
odds<-exp(coef_dssh)
odds


######################################
# multiple regression
######################################
# only select the significant factors from univariate analysis into multiple regression
multireg_mort<<-glm(DEATH_IND ~ SEX_F_IND + AGE_AT_1stAKI + RACE,
                    data = dat,
                    family="binomial")

summary(multireg_mort)


