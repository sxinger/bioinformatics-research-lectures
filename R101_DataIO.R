########################################################################################
#Data Input/Output
#Data Input/Import: You will need to read data from a variety of data storage locations 
#into R environment/memory in order to perform analysis. 
#======================================================================================
#Data Output/Export: You will also need to write intermediate or final results back to 
#permanent data storage locations
#######################################################################################
pacman::p_load(dplyr,magrittr,dbplyr)

#=============================================================================
# You may read data from local C: or D: drive
#=============================================================================
#--in .txt format
dat_txt<-read.table("D:/NextGenBMI-MUIRB2074022/data/aki_demo.txt")

#--in .csv format
dat_csv<-read.csv("D:/NextGenBMI-MUIRB2074022/data/aki_demo.csv")

#--in .rda (r data) format
dat_rda<-readRDS("D:/NextGenBMI-MUIRB2074022/data/aki_demo.rda")

#=================================================================================
# You can also read data directly from the backend Snowflake database
# follow instructions in wiki page to configure ODBC connetor:
# https://github.com/sxinger/bioinformatics-research-lectures/wiki/ODBC_Connector
# to connect to Snowflake de-id database. 
# !! Note that you will need a separate set of credentials to make the connection
#==============================================================================
# pacman::p_load(odbc,DBI)
# myconn <- DBI::dbConnect(drv=odbc::odbc(),
#                          dsn=Sys.getenv("DSN"),
#                          uid=Sys.getenv("Snowflake_Username"),
#                          pwd=Sys.getenv("Snowflake_Password"),)
# 
# #--retrieve data using the connection, e.g.,
# aki_demo<-tbl(myconn,in_schema("AKI_SEQUELAE","COV_DEMO")) %>% collect

#==============================================================================
# you may want to save intermediate results for further analysis
#==============================================================================
#---save data as .txt file
write.table(aki_demo,file="D:/NextGenBMI-MUIRB2074022/data/aki_demo.txt")

#---save data as .csv file
write.csv(aki_demo,file="D:/NextGenBMI-MUIRB2074022/data/aki_demo.txt",row.names = F)

#---save data as .rda(Rdata) file
saveRDS(aki_demo,file="D:/NextGenBMI-MUIRB2074022/data/aki_demo.rda")


