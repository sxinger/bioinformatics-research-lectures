rm(list=ls())

pacman:p_load(tidyverse,tidyr,broom)

#load pre-processed data
# dat<-readRDS("D:/NextGenBMI-MUIRB2073764/data/bmi_data.rda")

#--exploratory analysis--
dat_sample<-dat %>%
  semi_join(dat %>% select(PATID))
  
ggplot(dat,aes(x=DAYS_SINCE_APD,y=BMI,group=PATID))+
  geom_line()+
  geom_point()


#--paired t-test--
#mu0:bmi1-bmi0=0
#mu1:bmi1-bmi0>0



#--univariate linear regression--
reg_bmi_sex<-glm(BMI_CHANGE ~ SEX,
                 data = dat,
                 family = "gaussian")

summary(reg_bmi_sex)



#--Multiple Regression--
multireg_bmi_apd<-glm(BMI_CHANGE ~ SEX,
                      data = dat,
                      family = "gaussian")

summary(multireg_bmi_apd)


#--Mixed-effect model--




