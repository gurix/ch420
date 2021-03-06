library(mongolite)
m <- mongo(db="heroku_t242kdp0", collection = "supporters")


all <- m$find('{"duplicate":  { "$ne": true }}')
all$created_at <- as.Date(all$created_at)
all <- subset(all, created_at >= as.Date('2016-04-20'))

barplot(table(all$created_at), main = "Verlauf Einträge #CH420 Total")

li_members <- subset(all, li_membership == T)

barplot(table(li_members$created_at), main = "Verlauf Einträge #CH420 Mitgliedschaft")


ages <- table(all$age_category)
percentlabels<- round(100*ages/sum(ages), 1)
pielabels<- paste(percentlabels, "%", sep="")
cols <- rainbow(4)
pie(ages, main="Altersverteilung #CH420", col=cols, labels=pielabels, cex=0.8, sub=paste("N =", sum(ages)))
legend("topright", c("30-64",">64","< 18","18-30"), cex=0.8, fill=cols)



