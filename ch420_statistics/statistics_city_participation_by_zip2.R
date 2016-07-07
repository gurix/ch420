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

# Read BFS-Data with statistics of population from 2014
dataTable <- read.xlsx(file = "external_data/su-d-01.02.03.07.xls", sheetName = "2014", startRow = 5, endRow = 3189, colIndex = c(1,2))
colnames(dataTable) <- c('zip', 'total')

# Count number of total participants grouped by zip
participants_by_zip <- ddply(dt,~zip,summarise,participants=length(zip))

mainTable <- merge(dataTable, participants_by_zip, by='zip')

# Count number of total signers grouped by zip
signer_by_zip <- ddply(subset(dt, support=="signer"),~zip,summarise,signers=length(zip))

mainTable <- merge(mainTable, signer_by_zip, by='zip')

# Count number of total signers grouped by zip
supporter_by_zip <- ddply(subset(dt, support=="supporter"),~zip,summarise,supporters=length(zip))

mainTable <- merge(mainTable, supporter_by_zip, by='zip')

# Calculate the ration between participants and the total amount of habitants
mainTable$participant_ratio = mainTable$participants/mainTable$total

# Calculate the ration between signer and supporter
mainTable$supporter_signer_ratio = mainTable$supporters/mainTable$participants

# Calculate the ration between participants and the total amount of habitants
mainTable$participant_ratio = mainTable$participants/mainTable$total

write.xlsx(mainTable, file = "statistics_city_participation_by_zip2.xls", row.names=F)
