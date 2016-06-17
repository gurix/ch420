library(mongolite)
library(plyr)
library(xlsx)

Sys.setlocale("LC_ALL", "de_DE")

# Connect to the databes with the supporter collection
m <- mongo(db="heroku_t242kdp0", collection = "supporters")

# Find all datasets not marked as dublicates
dt <- m$find('{"duplicate":  { "$ne": true }}')
dt$created_at <- as.Date(dt$created_at)
# Filter erroneous data
dt <- subset(dt, zip >=1000)
dt <- subset(dt, zip < 10000)

# Read BFS-Data with town names
mainTable <- read.xlsx(file = "external_data/be-b-00.04-osv-01.xls", sheetIndex = 2, startRow = 1, colIndex = c(2,4,8,6))
colnames(mainTable) <- c('OHW','GWH','name', 'zip') 
mainTable <- subset(mainTable, is.na(OHW))
mainTable <- subset(mainTable, is.na(GWH))
mainTable <- unique(mainTable)


# Read BFS-Data with statistics of population from 2014
dataTable <- read.xlsx(file = "external_data/su-d-01.02.03.07.xls", sheetName = "2014", startRow = 5, endRow = 3189, colIndex = c(1,2))
colnames(dataTable) <- c('zip', 'total') 

# Merge town names with statistics of population
mainTable <- merge(mainTable,dataTable, by="zip", all.y = T)

# Count number of total participants grouped by zip
participants_by_zip <- ddply(dt,~zip,summarise,participants=length(zip))

# Calculate the ration between participants and the total amount of habitants
mainTable$participant_ratio = mainTable$participants/mainTable$total

# Merge number of participants with main table
mainTable <- merge(mainTable,participants_by_zip, by="zip", all.x=T)

# Count number of total signers grouped by zip
signer_by_zip <- ddply(subset(dt, support=="signer"),~zip,summarise,signers=length(zip))

# Merge number of signers with main table
mainTable <- merge(mainTable,signer_by_zip, by="zip", all.x=T)

# Count number of total signers grouped by zip
supporter_by_zip <- ddply(subset(dt, support=="supporter"),~zip,summarise,supporters=length(zip))

# Merge number of signers with main table
mainTable <- merge(mainTable,supporter_by_zip, by="zip", all.x=T)

# Calculate the ration between signer and supporter
mainTable$supporter_signer_ratio = mainTable$supporters/mainTable$participants

# Replace Na's with 0
mainTable[is.na(mainTable)] <- 0


write.xlsx(mainTable, file = "statistics_city_participation_by_zip.xls", row.names=F)
