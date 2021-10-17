########################################################################################
#Data Input/Output
#Data Input/Import: You will need to read data from a variety of data storage locations 
#into R environment/memory in order to perform analysis. 
#Data Output/Export: You will also need to write intermediate or final results back to 
#permanant data storage locations
#######################################################################################

#====You may read data from local C: or D: drive====
#--in .csv format
csv1<-read.csv("sample_csv_file.csv")

#--in .txt format

#--in .rda (r data) format

#====You may need to read data directly from backend database====


#=====R can send SQL to database and load data back into R=====
#---You need to prepare things:
# - 1. a database driver: JDBC driver is an API allowing interaction 
#      between java applications (Rstudio is a java application) and database.
#    - You should be able to see an "ojdbc6.jar" file under your home directory

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


#---save data as .csv file
write.csv(csv1,file="save_as_csv.csv")

#---save data as .rda(Rdata) file
saveRDS(csv1,file="save_as_rda.rda")
