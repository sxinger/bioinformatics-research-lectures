########################################################################################
#Data Input/Output
#Data Input/Import: You will need to read data from a variety of data storage locations 
#into R environment/memory in order to perform analysis. 
#======================================================================================
#Data Output/Export: You will also need to write intermediate or final results back to 
#permanant data storage locations
#######################################################################################

#====You may read data from local C: or D: drive====
#--in .txt format
dat_txt<-read.table(".txt")

#--in .csv format
dat_csv<-read.csv("sample_csv_file.csv")

#--in .rda (r data) format
dat_rda<-readRDS(".rda")

#====You may need to read data directly from the backend Snowflake database====
# follow instructions in wiki page to configure ODBC connetor:
# https://github.com/sxinger/bioinformatics-research-lectures/wiki/ODBC_Connector
# to connect to Snowflake de-id database. Note that you will need
# a separate set of credentials to make the connection


#=====R can send SQL to database and load data back into R=====


# - 2. a configuration file with your database/Oracle credentials
config_file<-read.csv("config.csv",stringsAsFactors = F)

# - 3. RJDBC and DBI package
pacman::p_load(DBI,RJDBC)
# .rs.restartR() #--might need to run this line to restart R

drv<-RJDBC::JDBC(driverClass="oracle.jdbc.OracleDriver",
                 classPath="./ojdbc6.jar") #-- take the db driver from your home directory
url<-paste0("jdbc:oracle:thin:@localhost:1521:",config_file$database) #--standard connection url
conn <- RJDBC::dbConnect(drv=drv,
                         url=url,
                         user=config_file$username, 
                         password=config_file$password)
summary(conn)

idd_pat<-dbGetQuery(conn,"select * from XSONG.PRVM_IDD_PATIENT_VIEW")


#==== you may want to save intermediate results for further analysis or final results to export
#---save data as .txt file
write.table(csv1,file="save_as_csv.txt")

#---save data as .csv file
write.csv(csv1,file="save_as_csv.csv")

#---save data as .rda(Rdata) file
saveRDS(csv1,file="save_as_rda.rda")
