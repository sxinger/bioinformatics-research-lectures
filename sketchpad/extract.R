install.packages(c("odbc","DBI","tidyverse"))
library(odbc)
library(DBI)
library(tidyverse)
library(dbplyr)
myconn <- DBI::dbConnect(odbc::odbc(),
                         'snowflake_cdm',
                         uid='xsm7f',
                         pwd='Sxdh=12171316')

#--retrieve data for AKI-Sequelae study
aki_cohort<-tbl(myconn,in_schema("AKI_SEQUELAE","AKI_ONSETS_SUB")) %>% collect
saveRDS(aki_outcome,file="D:/NextGenBMI-MUIRB2074022/data/aki_cohort.rda")

aki_outcome<-tbl(myconn,in_schema("AKI_SEQUELAE","AKI_POST_SEQ")) %>% collect
saveRDS(aki_outcome,file="D:/NextGenBMI-MUIRB2074022/data/aki_outcome.rda")

aki_demo<-tbl(myconn,in_schema("AKI_SEQUELAE","COV_DEMO")) %>% collect
saveRDS(aki_outcome,file="D:/NextGenBMI-MUIRB2074022/data/aki_demo.rda")

aki_enc<-tbl(myconn,in_schema("AKI_SEQUELAE","COV_ENC")) %>% collect
saveRDS(aki_outcome,file="D:/NextGenBMI-MUIRB2074022/data/aki_enc.rda")

aki_meta<-tbl(myconn,in_schema("AKI_SEQUELAE","METADATA")) %>% collect
write.csv(aki_meta,file="D:/NextGenBMI-MUIRB2074022/data/metadata.csv",row.names = F)

#--retrieve data for obesity-Antipsychotic study
bmi_cohort<-tbl(myconn,in_schema("OBESITY_APD","BMI_COHORT_ELIGIBLE")) %>% collect
saveRDS(bmi_cohort,file="D:/NextGenBMI-MUIRB2073764/data/bmi_cohort.rda")

bmi_apd<-tbl(myconn,in_schema("OBESITY_APD","BMI_APD_ELIGIBLE")) %>% collect
saveRDS(bmi_apd,file="D:/NextGenBMI-MUIRB2073764/data/bmi_apd.rda")

bmi_demo<-tbl(myconn,in_schema("OBESITY_APD","COV_DEMO")) %>% collect
saveRDS(bmi_demo,file="D:/NextGenBMI-MUIRB2073764/data/bmi_demo.rda")

bmi_meta<-tbl(myconn,in_schema("OBESITY_APD","METADATA")) %>% collect
write.csv(bmi_meta,file="D:/NextGenBMI-MUIRB2073764/data/metadata.csv",row.names = F)

