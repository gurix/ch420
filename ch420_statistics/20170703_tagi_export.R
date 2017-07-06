library(mongolite)
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
population_per_plz4 <- read.xlsx(file = "external_data/su-d-01.02.03.07.xls", sheetName = "2014", startRow = 5, endRow = 3189, colIndex = c(1,2))
colnames(population_per_plz4) <- c('zip', 'popuplation')

# Read canton name and zip from 
ktkz_plz4 <- read.xlsx(file = "external_data/be-b-00.04-osv-01.xls", sheetName = "PLZ4 -> GDE - NPA4 -> COM", startRow = 12,colIndex = c(1,2,4,5))
colnames(ktkz_plz4) <- c('zip', 'percent_of_community', 'canton', 'name')

ktkz_plz4 <- ktkz_plz4[order(100-ktkz_plz4$percent_of_community),] 
ktkz_plz4_uniq <- ktkz_plz4[!duplicated(ktkz_plz4$zip),]

# Merge population and canton by zip together
location_description <- merge(ktkz_plz4_uniq, population_per_plz4, by='zip')

# Total participants per zip
participants <- as.data.frame(table(dt$zip))
colnames(participants) <- c('zip','total_participants')

# Signers only
signers <- as.data.frame(table(subset(dt, support=="signer")$zip))
colnames(signers) <- c('zip','signers')

# Supporters only
supporters <- as.data.frame(table(subset(dt, support=="supporter")$zip))
colnames(supporters) <- c('zip','supporters')

# Merge everything to one big table
main_table <- merge(location_description, participants, by="zip", all.x=T)
main_table <- merge(main_table, signers, by="zip", all.x=T)
main_table <- merge(main_table, supporters, by="zip", all.x=T)

# Calculate ratio in population
main_table$total_participants_ratio <- main_table$total_participants / main_table$popuplation
main_table$total_signers_ratio <- main_table$signers / main_table$popuplation
main_table$total_supporters_ratio <- main_table$supporters / main_table$popuplation

# Export as xlsx
write.xlsx2(main_table, file = "20170703_tagi_export.xlsx", row.names=F)
